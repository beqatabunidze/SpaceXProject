//
//  ShipsDataSource.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import Foundation
import UIKit

class ShipsDataSource: NSObject {
    
    // MARK: - Private properties
    
    private var collectionView: UICollectionView!
    private var viewModel: ShipsListViewModel!
    private var view: UIView!
    private var timer : Timer?
    private var playButton: UIButton!
    private var restartButton: UIButton!
    private var speedUpButton: UIButton!
    private var rewindStep: Double = 1
    private var isPaused: Bool = true
    private var cellIndex: Int = 0
    private var shipsList = [ShipsViewModel]()
    private var storyboard = UIStoryboard(name: "ShipsViewController", bundle: nil)
    private var navigationController = UINavigationController()
    
    // class dependencies will be passed as constructor parameters using dependency injection
    
    init(with collectionView: UICollectionView, viewModel: ShipsListViewModel, view: UIView, playButton: UIButton, restartButton: UIButton, speedUpButton: UIButton, storyboard: UIStoryboard, navigationController: UINavigationController) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.viewModel = viewModel
        self.view = view
        self.playButton = playButton
        self.restartButton = restartButton
        self.speedUpButton = speedUpButton
        self.playButton.addTarget(self, action: #selector(startSlideshow), for: .touchUpInside)
        self.speedUpButton.addTarget(self, action: #selector(timeRewind), for: .touchUpInside)
        self.restartButton.addTarget(self, action: #selector(backToBegin), for: .touchUpInside)
        
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    // refresh function will append fetched ships into shipList and reloads the collection view data
    
    func refresh() {
        viewModel.getShipsList { ships in
            self.shipsList.append(contentsOf: ships)
            self.collectionView.reloadData()
        }
    }
    
    // starts the timer and slideshow and sets the starting step interval to 1. isPaused boolean is used to determine wheather the slideshow is strated or not. Default value for isPaused is false.
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1 / rewindStep, target: self, selector: #selector(self.slideShow), userInfo: nil, repeats: true);
        isPaused = false
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    // stops the timer but keeps the interval step in memory, when the user starts the timer again, it'll continue from where it left off.
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isPaused = true
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    // MARK: - objc functions
    
    // sets the starting collection view cell to 0, but does not affect the timer
    
    @objc func backToBegin() {
        cellIndex = 0
        collectionView.scrollToItem(at: IndexPath(item: cellIndex, section: 0), at: .right, animated: true)
    }
    
    // implements stop and start timer functions. Dependent on isPaused value
    
    @objc func startSlideshow() {
        isPaused ? startTimer() : stopTimer()
    }
    
    // rewindStep variable is used to increase/decrease time interval. Starting value is 1, every time the user calls this function rewindStep increases by 1 till 5, then it resets to 1 again.
    
    @objc func timeRewind() {
        
        timer?.invalidate()
        timer = nil
        
        if rewindStep < 5 && !isPaused {
            
            rewindStep += 1
            timer = Timer.scheduledTimer(timeInterval: 1 / rewindStep, target: self, selector: #selector(self.slideShow), userInfo: nil, repeats: true);
            
        } else if rewindStep == 5 && !isPaused {
            
            rewindStep = 1
            timer = Timer.scheduledTimer(timeInterval: 1 / rewindStep, target: self, selector: #selector(self.slideShow), userInfo: nil, repeats: true);
            
        } else if rewindStep < 5 && isPaused {
            
            rewindStep += 1
            
        } else if rewindStep == 5 && isPaused {
            
            rewindStep = 1
            
        }
        
        speedUpButton.setTitle("\(rewindStep)" + "x", for: .normal)
        
    }
    
    // responsible to calculate slidwshow direction and step amount
    
    @objc func slideShow(){
        
        cellIndex < shipsList.count - 1 ? (cellIndex += 1) : (cellIndex = 0)
        
        collectionView.scrollToItem(at: IndexPath(item: cellIndex, section: 0), at: .right, animated: true)
    }
    
}

// MARK: - CollectionView setup

// configure cells with fetched data

extension ShipsDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shipsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShipCollectionViewCell", for: indexPath) as! ShipCollectionViewCell
        cell.configure(with: shipsList[indexPath.row])
        
        cell.view.layer.cornerRadius = 15
        cell.imageView.layer.cornerRadius = 15
        cell.gradientImageView.layer.cornerRadius = 15
        
        self.cellIndex = indexPath.row - 1
        return cell
    }
    
}

// when Cell is clicked, by using an instance property, missions list is passed to MissionsViewController and MissionsViewController is being pushed to navigation stack

extension ShipsDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        stopTimer()
        
        let vc = storyboard.instantiateViewController(withIdentifier: "MissionsViewController") as! MissionsViewController
        vc.receivedMissionsList = shipsList[indexPath.item].missionList
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}

// sets the collectionViewCell width and height

extension ShipsDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height - 300)
    }
}

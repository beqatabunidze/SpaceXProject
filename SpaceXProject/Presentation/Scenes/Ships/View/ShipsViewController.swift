//
//  ShipsViewController.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import UIKit

class ShipsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private var viewModel: ShipsViewModelProtocol!
    private var dataSource: ShipsDataSource!
    private var shipsManager: FetchManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.refresh()
    }

    private func setupLayout() {

        collectionView.register(UINib(nibName: "ShipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShipCollectionViewCell")
    }
    
    private func configureViewModel() {
        shipsManager = FetchManager()
        viewModel = ShipsListViewModel(with: shipsManager)
        viewModel.spinner = self.spinner
        dataSource = ShipsDataSource(with: collectionView, viewModel: viewModel as! ShipsListViewModel, view: self.view, playButton: playButton, restartButton: beginButton, speedUpButton: rewindButton, storyboard: storyboard!, navigationController: navigationController!)
    }
    
}

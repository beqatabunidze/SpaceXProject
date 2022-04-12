//
//  ShipCollectionViewCell.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import UIKit
import Kingfisher

class ShipCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var portLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with ship: ShipsViewModel) {
        nameLabel.text = ship.name
        yearLabel.text = ship.year
        portLabel.text = ship.port
        imageView.kf.setImage(with: ship.imageURL)
        
    }

}

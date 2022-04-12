//
//  MissionsTableViewCell.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import UIKit

class MissionsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLAbel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var linksButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func configure(with launch: LaunchesViewModel) {
        nameLAbel.text = launch.name
        yearLabel.text = launch.launchYear
        detailsLabel.text = launch.description
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

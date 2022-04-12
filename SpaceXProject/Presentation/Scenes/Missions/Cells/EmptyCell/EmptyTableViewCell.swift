//
//  EmptyTableViewCell.swift
//  SpaceX
//
//  Created by Beqa Tabunidze on 11.04.22.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {
    @IBOutlet weak var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

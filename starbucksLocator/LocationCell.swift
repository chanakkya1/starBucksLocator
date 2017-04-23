//
//  LocationCell.swift
//  starbucksLocator
//
//  Created by chanakkya mati on 4/22/17.
//  Copyright © 2017 chanakkya mati. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

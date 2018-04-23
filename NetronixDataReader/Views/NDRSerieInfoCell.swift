//
//  NDRSerieInfoCell.swift
//  NetronixDataReader
//
//  Created by Anton Holub on 4/23/18.
//  Copyright © 2018 Anton Holub. All rights reserved.
//

import UIKit

class NDRSerieInfoCell: UITableViewCell {

    @IBOutlet weak var labelMeasurementName: UILabel!
    @IBOutlet weak var labelMeasurementValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

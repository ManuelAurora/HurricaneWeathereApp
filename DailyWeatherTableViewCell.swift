//
//  DailyWeatherTableViewCell.swift
//  Hurricane
//
//  Created by Мануэль on 03.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell
{
    @IBOutlet weak var _dayLabel:         UILabel!
    @IBOutlet weak var _temperatureLabel: UILabel!
    @IBOutlet weak var _weatherIcon:      UIImageView!
          
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

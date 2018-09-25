//
//  DoctorDetailsTableViewCell.swift
//  OdocTestApp
//
//  Created by Gihan Chanaka Beligaswaththa on 9/25/18.
//  Copyright © 2018 Gihan Chanaka Beligaswaththa. All rights reserved.
//

import UIKit
import SDWebImage

class DoctorDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var docNameLabel: UILabel!
    @IBOutlet weak var docProfilePicImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(set: DoctorModel){
        docNameLabel.text = set.fullName()
        var estimateTime = set.estimatedTime
        var formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm"
        var formatteddate = formatter.string(from: estimateTime)
        estimatedTimeLabel.text = formatteddate
        docProfilePicImage.sd_setImage(with: URL(string:set.doctorPorfilePic), placeholderImage:nil)
    }


}

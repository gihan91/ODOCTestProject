//
//  ShowDataViewController.swift
//  OdocTestApp
//
//  Created by Gihan Chanaka Beligaswaththa on 9/26/18.
//  Copyright © 2018 Gihan Chanaka Beligaswaththa. All rights reserved.
//

import UIKit
import SDWebImage

class ShowDataViewController: UIViewController {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var patientIdLabel: UILabel!
    @IBOutlet weak var docPorfilePic: UIImageView!
    @IBOutlet weak var estimateStartTime: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var doctorIdLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sessionIdLabel: UILabel!
    @IBOutlet weak var appointmentIdLabel: UILabel!


    
    var sessionId: String?
    var isOpen: Bool?
    var estimatedStartTime: Date?
    var patientId: String?
    var doctorId: String?
    var appointmentId: String?
    var startTime: Date?
    var type: String?
    var firstName: String?
    var lastName: String?
    var profileImageUrl: String?
    var docTitle: String?
    var eventName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()

    }
    
    //show all data
    func setUpUi(){
        var estimateTime = estimatedStartTime
        var formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm"
        var formatEstimateDate = formatter.string(from: estimateTime!)

        var startTimeIs = startTime
        var formatterStartTime = DateFormatter()
        formatterStartTime.dateFormat = "MMM d yyyy, h:mm"
        var formatStartTimeis = formatterStartTime.string(from: startTimeIs!)

        self.fullNameLabel.text = firstName
        self.eventNameLabel.text = eventName
        self.patientIdLabel.text = patientId
        self.estimateStartTime.text = formatEstimateDate
        self.appointmentIdLabel.text = appointmentId
        self.startTimeLabel.text = formatStartTimeis
        if isOpen == true{
            self.openLabel.text = "Yes"
        }
        docPorfilePic.sd_setImage(with: URL(string:profileImageUrl!), placeholderImage:nil)
        self.typeLabel.text = type
        self.sessionIdLabel.text = sessionId
        self.doctorIdLabel.text = doctorId

        
        

    }

}

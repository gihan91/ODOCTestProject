//
//  DoctorDetailsViewController.swift
//  OdocTestApp
//
//  Created by Gihan Chanaka Beligaswaththa on 9/25/18.
//  Copyright © 2018 Gihan Chanaka Beligaswaththa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class DoctorDetailsViewController: UIViewController {

    @IBOutlet weak var docInfoTableView: UITableView!

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


    var docDetailsList = [DoctorModel]()
    var showAllList = [DoctorModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        docInfoTableView.delegate = self
        docInfoTableView.dataSource = self
        docInfoTableView.estimatedRowHeight = 150
        getDocDetails()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.docInfoTableView.reloadData()
    }
    //Get Doc Details from Json
    func getDocDetails(){
        Alamofire.request(getBookingsUrl, method: .get).responseJSON{
            response in
            switch response.result{
            case .success:
                let json = JSON(response.result.value as Any)
                let jsonAll = json.array
                print(jsonAll!)
                if jsonAll != nil{
                    for eachData in jsonAll!{
                        let title = eachData["title"].stringValue
                        let docId = eachData["doctorId"].stringValue
                        let estimatedTime = eachData["estimated_start_time"].intValue
                        let docFirstName = eachData["firstName"].stringValue
                        let docLastName = eachData["lastName"].stringValue
                        let startTime = eachData["startTime"].intValue
                        let docProfPic = eachData["profilePictureUrl"].stringValue
                        let eventName = eachData["event"].stringValue

                        let sessionId = eachData["sessionId"].stringValue
                        let isOpen = eachData["is_open"].boolValue
                        let patientId = eachData["patientId"].stringValue
                        let appointmentId = eachData["appointmentId"].stringValue
                        let type = eachData["type"].stringValue

                        var convertToEstimateDate = Date(timeIntervalSince1970: (Double(estimatedTime) / 1000.0))
                        var convertToStartDate = Date(timeIntervalSince1970: (Double(startTime) / 1000.0))

                    
                        let doctorObj = DoctorModel(docId: docId, docTitle: title, docFirstName: docFirstName, docLastName: docLastName, docProfilePic: docProfPic, eventName: eventName, startTime: convertToStartDate, estimatedTime: convertToEstimateDate)

                        let showAllObj = DoctorModel(type: type, sessionId: sessionId, isOpen: isOpen, patientId: patientId, appointmentId: appointmentId)
                        self.showAllList.append(showAllObj)
                        print(showAllObj)
                        self.docDetailsList.append(doctorObj)

                    }

                }
                self.docInfoTableView.reloadData()
                break

            case .failure(let _error):
                print(_error)

            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAllData"{
            let vc = segue.destination as! ShowDataViewController
            vc.sessionId = sessionId
            vc.firstName = firstName
            vc.eventName = eventName
            vc.patientId = patientId
            vc.estimatedStartTime = estimatedStartTime
            vc.profileImageUrl = profileImageUrl
            vc.type = type
            vc.startTime = startTime
            vc.doctorId = doctorId
            vc.isOpen = isOpen
            vc.appointmentId = appointmentId

        }
    }

}
//MARK:-TableView delegate and datasource
extension DoctorDetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return docDetailsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "docCell") as! DoctorDetailsTableViewCell
        let docDataSet = docDetailsList[indexPath.row]
        cell.setData(set: docDataSet)
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = docDetailsList[indexPath.row]
        let selectedItemFromAll = showAllList[indexPath.row]
        sessionId = selectedItemFromAll.sessionId
        isOpen = selectedItemFromAll.isOpen
        estimatedStartTime = selectedItem.estimatedTime
        patientId = selectedItemFromAll.patientId
        doctorId = selectedItem.doctorId
        appointmentId = selectedItemFromAll.appointmentId
        startTime = selectedItem.startTime
        firstName = selectedItem.fullName()
        profileImageUrl = selectedItem.doctorPorfilePic
        docTitle = selectedItem.doctorTitle
        eventName = selectedItem.eventName
        type = selectedItemFromAll.type

        performSegue(withIdentifier: "showAllData", sender: self)
    }


}

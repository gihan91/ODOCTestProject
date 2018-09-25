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

    var docDetailsList = [DoctorModel]()

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

                        var convertToEstimateDate = Date(timeIntervalSince1970: (Double(estimatedTime) / 1000.0))
                        var convertToStartDate = Date(timeIntervalSince1970: (Double(startTime) / 1000.0))

                    
                        let doctorObj = DoctorModel(docId: docId, docTitle: title, docFirstName: docFirstName, docLastName: docLastName, docProfilePic: docProfPic, eventName: eventName, startTime: convertToStartDate, estimatedTime: convertToEstimateDate)
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
    


}

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
        print(selectedItem.fullName())
    }


}

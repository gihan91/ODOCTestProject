//
//  DoctorModel.swift
//  OdocTestApp
//
//  Created by Gihan Chanaka Beligaswaththa on 9/25/18.
//  Copyright © 2018 Gihan Chanaka Beligaswaththa. All rights reserved.
//

import Foundation

class DoctorModel{
    private var _doctorId: String?
    private var _doctorTitle: String?
    private var _doctorFirstName: String?
    private var _doctorLastName: String?
    private var _doctorProfilePic: String?
    private var _eventName: String?
    private var _startTime: Date?
    private var _estimatedTime: Date?

    init(docId: String,docTitle: String,docFirstName: String,docLastName: String,docProfilePic: String,eventName:String,startTime: Date,estimatedTime: Date) {
        self._doctorId = docId
        self._doctorTitle = docTitle
        self._doctorFirstName = docFirstName
        self._doctorLastName = docLastName
        self._doctorProfilePic = docProfilePic
        self._eventName = eventName
        self._startTime = startTime
        self._estimatedTime = estimatedTime
    }

    public var doctorId: String{
        get{
            return _doctorId!
        }
        set{
            _doctorId = newValue
        }
    }
    public var doctorTitle: String{
        get{
            return _doctorTitle!
        }
        set{
            _doctorTitle = newValue
        }
    }
    public var doctirFirstName: String{
        get{
            return _doctorFirstName!
        }
        set{
            _doctorFirstName = newValue
        }
    }
    public var doctorLastName:String{
        get{
            return _doctorLastName!
        }
        set{
            _doctorLastName = newValue
        }
    }
    public var doctorPorfilePic:String{
        get{
            return _doctorProfilePic!
        }
        set{
            _doctorProfilePic = newValue
        }
    }
    public var eventName:String{
        get{
            return _eventName!
        }
        set{
            _eventName = newValue
        }
    }
    public var startTime:Date{
        get{
            return _startTime!
        }
        set{
            _startTime = newValue
        }
    }
    public var estimatedTime: Date{
        get{
            return _estimatedTime!
        }
        set{
            _estimatedTime = newValue
        }
    }

    func fullName()-> String{
        return _doctorTitle! + _doctorFirstName! + " " + _doctorLastName!
    }
}

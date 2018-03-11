//
//  DateTime.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import ObjectMapper

struct DateTime: BaseModel {
   
    var timeStamp: Int = 0
    var timeZone: String = ""
    
    // MARK: Date Modifiers
    var hourFromTimeStampWithTimeZone: String {
        let date = timeStamp.dateFromTimeStamp
        return date.hourForTimeZone(timeZone)
    }
    
    var dateFromTimeStampWithTimeZone: String {
        let date = timeStamp.dateFromTimeStamp
        return date.calenderDateForTimeZone(timeZone)
    }
    
    // MARK: Initializer
    init?(map: Map) {
    }
    
    init(timeStamp: Int, timeZone:String) {
        self.timeStamp = timeStamp
        self.timeZone = timeZone
    }
    
    // MARK: Mapping
    mutating func mapping(map: Map) {
        timeStamp <- map["timestamp"]
        timeZone  <- map["tz"]
    }

}

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
    
    var hourFromTimeStampWithTimeZone: String {
        let date = timeStamp.dateFromTimeStamp
        return date.hourForTimeZone(timeZone)
    }
    
    var dateFromTimeStampWithTimeZone: String {
        let date = timeStamp.dateFromTimeStamp
        return date.calenderDateForTimeZone(timeZone)
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        timeStamp <- map["timestamp"]
        timeZone  <- map["tz"]
    }

}

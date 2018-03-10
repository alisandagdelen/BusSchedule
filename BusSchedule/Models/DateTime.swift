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
    
    var fromTimeStampWithTimeZone: Date {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        
        return date
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        timeStamp <- map["timestamp"]
        timeZone  <- map["tz"]
    }

}

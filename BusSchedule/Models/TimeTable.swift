//
//  TimeTable.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import ObjectMapper

struct TimeTable: BaseModel {
    
    var arrivals: [TimeTableDetails] = []
    var departures: [TimeTableDetails] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        arrivals   <- map["arrivals"]
        departures <- map["departures"]
    }
}

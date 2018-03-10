//
//  BusScheduleResponse.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import ObjectMapper

struct BusScheduleResponse: BaseModel {
    
    var timeTable: TimeTable? = nil

    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        timeTable   <- map["timetable"]
    }
}

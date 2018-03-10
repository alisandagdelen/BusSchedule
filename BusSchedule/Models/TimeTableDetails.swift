//
//  TimeTableDetails.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import ObjectMapper

struct TimeTableDetails: BaseModel {
    
    var lineNumber: String = ""
    var direction: String = ""
    var time: DateTime? = nil
    var briefRoute: String = ""
    var routeDetails : [RouteDetais] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        lineNumber    <- map["line_code"]
        direction     <- map["direction"]
        time           <- map["datetime"]
        briefRoute    <- map["through_the_stations"]
        routeDetails  <- map["route"]
    }
}

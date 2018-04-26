//
//  TimeTableDetails.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

struct TimeTableDetails: BaseModel {
    
    var lineNumber: String? = ""
    var direction: String? = ""
    var time: DateTime? = nil
    var briefRoute: String? = ""
    var routeDetails : [RouteDetails?] = []
    
    init(lineNumber: String, direction: String, time:DateTime, briefRoute:String, routeDetails:[RouteDetails]) {
        self.lineNumber = lineNumber
        self.direction = direction
        self.time = time
        self.briefRoute = briefRoute
        self.routeDetails = routeDetails
    }
    
    enum CodingKeys: String, CodingKey {
        case lineNumber = "line_code"
        case direction
        case time = "datetime"
        case briefRoute = "through_the_stations"
        case routeDetails = "route"
    }
}

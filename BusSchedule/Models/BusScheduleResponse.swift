//
//  BusScheduleResponse.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

struct BusScheduleResponse: BaseModel {
    
    var timeTable: TimeTable

    enum CodingKeys:CodingKey, String {
        case timeTable = "timetable"
    }
}

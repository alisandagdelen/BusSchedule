//
//  BusServiceMock.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
@testable import BusSchedule

class ErrorMock:Error {
    var message:String!
    init(message:String) {
        self.message = message
    }
}

class BusServiceMock: BusScheduleApi {
    
    var timeTable: TimeTable?
    
    func getTimeTable(city: City, _ result: @escaping (TimeTable?, Error?) -> Void) {
        if let timeTable = timeTable {
            result(timeTable,nil)
        } else {
            result(nil, ErrorMock(message: "timeTable empty"))
        }
    }
    
    
}

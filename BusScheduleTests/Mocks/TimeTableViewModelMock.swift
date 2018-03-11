//
//  TimeTableViewModelTests.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
@testable import BusSchedule

class TimeTableViewModelMock: TimeTableViewModelProtocol {
    var timeTableDetails: Dynamic<[String : [TimeTableDetails]]>
    
    var selectedDateType: Dynamic<DateType>
    
    var dates: [String]
    
    var stationName: String
    
    init(dateType:DateType) {
        self.selectedDateType = Dynamic(dateType)
        self.stationName = "testStation"
        self.dates = ["testDateOne", "testDateTwo"]
        self.timeTableDetails = Dynamic([dates.first!:[TimeTableMock.timeTableOne.arrivals.first!], dates.last!:[TimeTableMock.timeTableTwo.arrivals.first!]])
    }
    
    func changeDateType() {
        selectedDateType.value = selectedDateType.value == DateType.arrival ? DateType.departure : DateType.arrival
    }
}

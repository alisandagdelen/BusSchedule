//
//  TimeTableViewModelTests.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

@testable import BusSchedule

class TimeTableViewModelMock: TimeTableViewModelProtocol {
    var timeTableDetails: Variable<[SectionModel<String, TimeTableDetails>]>
    var selectedDateType: BehaviorSubject<DateType>
    let disposedBag = DisposeBag()
    
    var dates: [String]
    
    var stationName: String
    
    init(dateType:DateType) {
        self.selectedDateType = BehaviorSubject(value: dateType)
        self.stationName = "testStation"
        self.dates = ["testDateOne", "testDateTwo"]
        self.timeTableDetails = Variable([SectionModel(model: dates.first!, items: TimeTableMock.timeTableOne.arrivals), SectionModel(model: dates.last!, items: TimeTableMock.timeTableTwo.arrivals)])
    }
    
    func changeDateType() {
        let selectedDate = try! selectedDateType.value()
        selectedDateType.onNext(selectedDate == DateType.arrival ? DateType.departure : DateType.arrival)
    }
}

//
//  TimeTableViewModelTest.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import XCTest
import RxDataSources
@testable import BusSchedule

class TimeTableViewModelTest: XCTestCase {
    
    var dataService:BusServiceMock!
    var timeTable:TimeTable!
    
    override func setUp() {
        super.setUp()
        let mockService = BusServiceMock()
        timeTable = TimeTableMock.timeTableOne
        mockService.timeTable = timeTable
        dataService = mockService
    }
    
    override func tearDown() {
        
        dataService.timeTable = timeTable
        super.tearDown()
    }
    
    func testNilsAfterInit() {
        let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .arrival)
        
        XCTAssertNotNil(timeTableViewModel.stationName, "StationName should not be nill after initialize")
        XCTAssertNotNil(timeTableViewModel.selectedDateType.value, "SelectedDateType should not be nill after initialize")
        XCTAssertNotNil(timeTableViewModel.timeTableDetails.value, "TimeTableDetails should not be nill after initialize")
    }
    
    func testFillTimeTableForArrival() {
        dataService.timeTable = TimeTableMock.timeTableTwo
        let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .arrival)
        let dateAndTimeTable = fillTimeTable(dateType: .arrival, timeTable: TimeTableMock.timeTableTwo)
        var equals:[SectionModel<String, TimeTableDetails>] = []
        dateAndTimeTable.forEach { dateAndTime in
            equals = timeTableViewModel.timeTableDetails.value.filter { $0.model == dateAndTime.model }.filter { $0.items == dateAndTime.items}
        }
      
        XCTAssertEqual(equals.count, dateAndTimeTable.count)
        XCTAssertEqual(equals.count, timeTableViewModel.timeTableDetails.value.count)
        XCTAssertEqual(timeTableViewModel.timeTableDetails.value.count, dateAndTimeTable.count)
    }
    
    func testFillTimeTableForDeparture() {
        dataService.timeTable = TimeTableMock.timeTableTwo
        let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .departure)
        let dateAndTimeTable = fillTimeTable(dateType: .departure, timeTable: TimeTableMock.timeTableTwo)
        var equals:[SectionModel<String, TimeTableDetails>] = []
        dateAndTimeTable.forEach { dateAndTime in
            equals = timeTableViewModel.timeTableDetails.value.filter { $0.model == dateAndTime.model }.filter { $0.items == dateAndTime.items}
        }
       
        XCTAssertEqual(equals.count, dateAndTimeTable.count)
        XCTAssertEqual(equals.count, timeTableViewModel.timeTableDetails.value.count)
        XCTAssertEqual(timeTableViewModel.timeTableDetails.value.count, dateAndTimeTable.count)
    }
    
    func testChangeDateType() {
         let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .departure)
        timeTableViewModel.changeDateType()
        XCTAssertNotEqual(try? timeTableViewModel.selectedDateType.value(), DateType.departure)

    }
    
    func fillTimeTable(dateType:DateType, timeTable:TimeTable) -> [SectionModel<String, TimeTableDetails>] {
        
        let tableDetails = dateType == .departure ? timeTable.departures : timeTable.arrivals
        var tempTableDetails: [SectionModel<String, TimeTableDetails>] = []
        var listedDates:[String] = []
        
        tableDetails.forEach {
            guard let date = $0.time?.dateFromTimeStampWithTimeZone else { return }
            if !listedDates.contains(date) {
                let filteredTableDetail = tableDetails.filter { $0.time?.dateFromTimeStampWithTimeZone == date }
                tempTableDetails.append(SectionModel(model: date, items: filteredTableDetail))
                listedDates.append(date)
            }
        }
        return tempTableDetails
    }
    
}

extension TimeTableDetails : Equatable {
    
    static public func ==(lhs:TimeTableDetails,rhs:TimeTableDetails) -> Bool {
        return lhs.direction == rhs.direction && lhs.briefRoute == rhs.briefRoute && lhs.lineNumber == rhs.lineNumber
    }
    
}

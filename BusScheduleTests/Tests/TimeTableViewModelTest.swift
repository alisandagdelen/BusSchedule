//
//  TimeTableViewModelTest.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import XCTest
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
        
        XCTAssertNotNil(timeTableViewModel.dates, "Dates should not be nill after initialize")
        XCTAssertNotNil(timeTableViewModel.stationName, "StationName should not be nill after initialize")
        XCTAssertNotNil(timeTableViewModel.selectedDateType.value, "SelectedDateType should not be nill after initialize")
        XCTAssertNotNil(timeTableViewModel.timeTableDetails.value, "TimeTableDetails should not be nill after initialize")
    }
    
    func testFillTimeTableForArrival() {
        dataService.timeTable = TimeTableMock.timeTableTwo
        let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .arrival)
        let dateAndTimeTable = fillTimeTable(dateType: .arrival, timeTable: TimeTableMock.timeTableTwo)
        
        XCTAssertEqual(timeTableViewModel.dates, dateAndTimeTable.dates)
        XCTAssertEqual(timeTableViewModel.timeTableDetails.value.count, dateAndTimeTable.tableDetails.count)
    }
    
    func testFillTimeTableForDeparture() {
        dataService.timeTable = TimeTableMock.timeTableTwo
        let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .departure)
        let dateAndTimeTable = fillTimeTable(dateType: .departure, timeTable: TimeTableMock.timeTableTwo)
        
        XCTAssertEqual(timeTableViewModel.dates, dateAndTimeTable.dates)
        XCTAssertEqual(timeTableViewModel.timeTableDetails.value.count, dateAndTimeTable.tableDetails.count)
    }
    
    func testChangeDateType() {
         let timeTableViewModel = TimeTableViewModel(city: .berlin, dataService: dataService, dateType: .departure)
        timeTableViewModel.changeDateType()
        XCTAssertNotEqual(timeTableViewModel.selectedDateType.value, DateType.departure)

    }
    
    func fillTimeTable(dateType:DateType, timeTable:TimeTable) -> (dates: [String],tableDetails:[String : [TimeTableDetails]]) {
        
        let tableDetails = dateType == .departure ? timeTable.departures : timeTable.arrivals
        
        var tempTableDetails: [String:[TimeTableDetails]] = [:]
        var dates:[String] = []
        
        tableDetails.forEach {
            guard let date = $0.time?.dateFromTimeStampWithTimeZone else { return }
            if !dates.contains(date) {
                dates.append(date)
            }
        }
        dates.forEach { date in
            let filteredTableDetail = tableDetails.filter { $0.time?.dateFromTimeStampWithTimeZone == date }
            tempTableDetails[date] = filteredTableDetail
        }
        return (dates: dates, tableDetails: tempTableDetails)
    }
    
}

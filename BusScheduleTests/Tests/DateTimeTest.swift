//
//  DateTimeTest.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import XCTest
@testable import BusSchedule

class DateTimeTest: XCTestCase {
    
    var timeStamp: Int!
    var timeZone: String!
    
    override func setUp() {
        super.setUp()
        timeStamp = 1520703600
        timeZone = "GMT+03"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInit() {
        
        let dateTime = DateTime(timeStamp: timeStamp, timeZone: timeZone)
        
        XCTAssertEqual(dateTime.timeStamp, timeStamp, "Init method can not set timeStamp parameter correctly")
        XCTAssertEqual(dateTime.timeZone, timeZone, "Init method can not set timeZone parameter correctly")
    }
    
    func testDateFromTimeStampWithTimeZone() {
        
        let dateFromTimeStamp = timeStamp.dateFromTimeStamp
        let calenderDate = dateFromTimeStamp.calenderDateForTimeZone(timeZone)
        
        let dateTime = DateTime(timeStamp: timeStamp, timeZone: timeZone)
        
        XCTAssertEqual(calenderDate, dateTime.dateFromTimeStampWithTimeZone, "DateFromTimeStampWithTimeZone can not create calender date correctly ")
    }
    
    func testHourFromTimeStampWithTimeZone() {
        let dateFromTimeStamp = timeStamp.dateFromTimeStamp
        let hour = dateFromTimeStamp.hourForTimeZone(timeZone)
        
        let dateTime = DateTime(timeStamp: timeStamp, timeZone: timeZone)
        
        XCTAssertEqual(hour, dateTime.hourFromTimeStampWithTimeZone, "HourFromTimeStampWithTimeZone can not create calender date correctly ")
    }
}

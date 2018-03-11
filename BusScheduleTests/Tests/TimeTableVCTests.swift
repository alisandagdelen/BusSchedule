//
//  TimeTableVCTests.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import XCTest
@testable import BusSchedule

class TimeTableVCTests: XCTestCase {
    
    var timeTableVC: TimeTableVC!
    var timeTableViewModel:TimeTableViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        timeTableVC = storyboard.instantiateViewController(withIdentifier: "TimeTableVC") as! TimeTableVC
        timeTableViewModel = TimeTableViewModelMock(dateType: .arrival)
        timeTableVC.timeTableViewModel = TimeTableViewModelMock(dateType: .arrival)
        UIApplication.shared.keyWindow!.rootViewController = timeTableVC
        _ = timeTableVC.view
    }
    
    override func tearDown() {
        
        timeTableVC.timeTableViewModel = timeTableViewModel
        
        super.tearDown()
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(timeTableVC.navigationItem.title, timeTableViewModel.stationName)
    }
    
    func testHasATableView() {
        XCTAssertNotNil(timeTableVC.tblTimeTableDetails)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(timeTableVC.tblTimeTableDetails.dataSource)
    }
    
    func testTableViewAllowsSelecction() {
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.allowsSelection, false)
    }
    
    func testChangeDateType() {
        timeTableVC.changeDateType(UIButton())
        
        XCTAssertNotEqual(timeTableViewModel.selectedDateType.value, timeTableVC.timeTableViewModel.selectedDateType.value)
    }
    
    func testRightBarButtonImageChange() {
        let barButtonImage = timeTableVC.timeTableViewModel.selectedDateType.value == .arrival ? #imageLiteral(resourceName: "arrival") : #imageLiteral(resourceName: "departure")

        timeTableVC.changeDateType(UIButton())
        
        XCTAssertNotEqual(barButtonImage, timeTableVC.navigationItem.rightBarButtonItem?.image)
    }
    
    func testTableViewSectionSet() {
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.numberOfSections, timeTableViewModel.dates.count)
    }
    
    func testTableViewRowSet() {
        let timeTableDetails = timeTableViewModel.timeTableDetails.value
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.numberOfRows(inSection: 0), timeTableDetails[timeTableViewModel.dates[0]]?.count)
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.numberOfRows(inSection: 1), timeTableDetails[timeTableViewModel.dates[1]]?.count)
    }
    
    
}

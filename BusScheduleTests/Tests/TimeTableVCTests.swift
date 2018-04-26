//
//  TimeTableVCTests.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import XCTest
import RxSwift
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
        timeTableVC.timeTableViewModel.changeDateType()
        let selectedDateTypeBeforeChange = try! timeTableViewModel.selectedDateType.value()
        let selectedDateTypeAfterChange = try! timeTableVC.timeTableViewModel.selectedDateType.value()
        XCTAssertNotEqual(selectedDateTypeBeforeChange, selectedDateTypeAfterChange)
    }
    
    func testRightBarButtonImageChange() {
        let dateTypeBeforeChange = try! timeTableVC.timeTableViewModel.selectedDateType.value()
        let imageBeforeChange = dateTypeBeforeChange == .departure ? #imageLiteral(resourceName: "departure") : #imageLiteral(resourceName: "arrival")
        
        timeTableVC.timeTableViewModel.changeDateType()
        
        XCTAssertNotEqual(imageBeforeChange, timeTableVC.navigationItem.rightBarButtonItem?.image)
    }
    
    func testTableViewSectionSet() {
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.numberOfSections, timeTableViewModel.timeTableDetails.value.count)
    }
    
    func testTableViewRowSet() {
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.numberOfRows(inSection: 0), timeTableViewModel.timeTableDetails.value[0].items.count)
        XCTAssertEqual(timeTableVC.tblTimeTableDetails.numberOfRows(inSection: 1), timeTableViewModel.timeTableDetails.value[1].items.count)
    }
    
    
}

//
//  StationsVCTests.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import XCTest
@testable import BusSchedule

class StationsVCTests: XCTestCase {
    
    var stationsVC: StationsVC!
    var stationsViewModel:StationsViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        stationsVC = navigationController.topViewController as! StationsVC
        stationsViewModel = StationsViewModelMock()
        stationsVC.stationsViewModel = StationsViewModelMock()
        UIApplication.shared.keyWindow!.rootViewController = stationsVC
        _ = navigationController.view
        _ = stationsVC.view
    }
    
    func testPresentTimeTableVC() {
        stationsVC.presentTimeTableVC(city: .berlin, dataService: BusServiceMock())
        XCTAssertEqual(stationsVC.navigationController!.topViewController!, stationsVC)
    }
    
    func testNavigationTitle() {
        XCTAssertEqual(stationsVC.navigationItem.title, "Stations")
    }
    
    func testHasATableView() {
        XCTAssertNotNil(stationsVC.tblStations)
    }
    
    func testDidSelectRow() {
        let indexPath = IndexPath(row: 1, section: 0)
        stationsVC.tblStations.delegate!.tableView!(stationsVC.tblStations, didSelectRowAt: indexPath)
        XCTAssertEqual(stationsVC.navigationController!.topViewController!, stationsVC)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(stationsVC.tblStations.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue((stationsVC.tblStations.delegate?.conforms(to: UITableViewDelegate.self))!)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(stationsVC.tblStations.dataSource)
    }
    
    func testTableViewSectionSet() {
        XCTAssertEqual(stationsVC.tblStations.numberOfSections, stationsViewModel.stations.value.count)
    }
    
    func testTableViewRowSet() {
        XCTAssertEqual(stationsVC.tblStations.numberOfRows(inSection: 0), stationsViewModel.stations.value[0].items.count)
    }
    
}

//
//  TimeTableViewModel.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import SVProgressHUD

enum DateType {
    case arrival, departure
}

protocol TimeTableViewModelProtocol {
    var timeTableDetails:Dynamic<[String:[TimeTableDetails]]> { get }
    var selectedDateType: Dynamic<DateType> { get }
    var dates: [String] { get }
    var stationName :String { get }
    func changeDateType()
}

class TimeTableViewModel: NSObject, TimeTableViewModelProtocol {
    
    // MARK: Public Properties
    var timeTableDetails: Dynamic<[String : [TimeTableDetails]]>
    var selectedDateType: Dynamic<DateType>
    var dates: [String]
    var stationName :String {
        return city.description
    }
    
    // MARK: Private Properties
    private var dataService: BusScheduleApi
    private var city: City
    private var timeTable:TimeTable?
    private var dateType:DateType {
        didSet {
            selectedDateType.value = dateType
        }
    }
    
    // MARK: Initializer
    
    init(city:City, dataService:BusScheduleApi = BusScheduleService.sharedInstance, dateType:DateType = .departure) {
        self.dataService = dataService
        self.city = city
        self.selectedDateType = Dynamic(dateType)
        self.dateType = dateType
        self.timeTableDetails = Dynamic([:])
        self.dates = []
        self.timeTable = nil
        super.init()
        getTimeTableDetails()
    }
    
    // MARK: Service Methods
    
    private func getTimeTableDetails() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        
        dataService.getTimeTable(city: city) { (timetable, error) in
            if let timetable = timetable {
                self.timeTable = timetable
                self.fillTimeTable()
            }
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK: Model Modify Methods
    
    private func fillTimeTable() {
        guard let timeTable = timeTable else { return }
        let tableDetails = dateType == .departure ? timeTable.departures : timeTable.arrivals
        var tempTableDetails: [String:[TimeTableDetails]] = [:]
        dates = []
        
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
        timeTableDetails.value = tempTableDetails
    }
    
    func changeDateType() {
        SVProgressHUD.show()
        dateType = dateType == .arrival ? .departure : .arrival
        DispatchQueue.global(qos: .userInitiated).async {
            self.fillTimeTable()
            SVProgressHUD.dismiss()
        }
    }
}

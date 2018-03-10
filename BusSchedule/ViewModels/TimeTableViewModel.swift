//
//  TimeTableViewModel.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

enum DateType {
    case arrival, departure
}

protocol TimeTableViewModelProtocol {
    var timeTableDetails:Dynamic<[Date:[TimeTableDetails]]> { get }
    var dates: [Date] { get }
    var stationName :String { get }
    func changeDateType(dateType: DateType)
}

class TimeTableViewModel: NSObject, TimeTableViewModelProtocol {
    
    var timeTableDetails: Dynamic<[Date : [TimeTableDetails]]>
    var dates: [Date]
    var stationName :String {
        return city.description
    }
    
    private var dataService: BusScheduleApi
    private var city: City
    private var timeTable:TimeTable?
    private var dateType:DateType
    
    init(city:City, dataService:BusScheduleApi = BusScheduleService.sharedInstance, dateType:DateType = .arrival) {
        self.dataService = dataService
        self.city = city
        self.dateType = dateType
        self.timeTableDetails = Dynamic([:])
        self.dates = []
        self.timeTable = nil
        super.init()
        getTimeTableDetails()
    }
    
    private func getTimeTableDetails() {
        dataService.getTimeTable(city: city) { (timetable, error) in
            if let timetable = timetable {
                self.timeTable = timetable
                self.fillTimeTable()
            }
        }
    }
    
    private func fillTimeTable() {
        guard let timeTable = timeTable else { return }
        let tableDetails = dateType == .arrival ? timeTable.arrivals : timeTable.departures
        var tempTableDetails: [Date:[TimeTableDetails]] = [:]
        
        let uniqDates = Set(tableDetails.flatMap { $0.time?.timeStamp.dateFromTimeStamp })
        dates = Array(uniqDates).sorted()
        
        dates.forEach { date in
            let filteredTableDetail = tableDetails.filter { $0.time?.timeStamp.dateFromTimeStamp == date }
            tempTableDetails[date] = filteredTableDetail
        }
        
        timeTableDetails.value = tempTableDetails
    }
    
    func changeDateType(dateType: DateType) {
        self.dateType = dateType
        fillTimeTable()
    }
    
}

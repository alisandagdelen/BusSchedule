//
//  TimeTableViewModel.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift
import RxDataSources

enum DateType {
    case arrival, departure
}

protocol TimeTableViewModelProtocol {
    var timeTableDetails:Variable<[SectionModel<String, TimeTableDetails>]> { get }
    var selectedDateType: BehaviorSubject<DateType> { get }
    var stationName :String { get }
    func changeDateType()
}

final class TimeTableViewModel: NSObject, TimeTableViewModelProtocol {
    
    // MARK: Public Properties
    var timeTableDetails: Variable<[SectionModel<String, TimeTableDetails>]>
    var selectedDateType: BehaviorSubject<DateType>
    var stationName :String {
        return city.description
    }
    
    // MARK: Private Properties
    private var dataService: BusScheduleApi
    private var city: City
    private var timeTable:TimeTable?
    private var dateType:DateType {
        didSet {
            selectedDateType.onNext(dateType)
        }
    }
    
    // MARK: Initializer
    
    init(city:City, dataService:BusScheduleApi = BusScheduleService.sharedInstance, dateType:DateType = .departure) {
        self.dataService = dataService
        self.city = city
        self.selectedDateType = BehaviorSubject<DateType>(value: dateType)
        self.dateType = dateType
        self.timeTableDetails = Variable([])
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
        timeTableDetails.value = tempTableDetails
    }
    
    func changeDateType() {
        SVProgressHUD.show()
        dateType = dateType == .arrival ? .departure : .arrival
       
        let fillTimeTableGroup = DispatchGroup()
        fillTimeTableGroup.enter()
        DispatchQueue(label: "com.busSchedule.timeTable", qos: .background, attributes: .concurrent).async {
            self.fillTimeTable()
            fillTimeTableGroup.leave()
        }
        fillTimeTableGroup.notify(queue: .main) {
            SVProgressHUD.dismiss()
        }
        
        // Alternative with workItem
        
        /*
        let fillTimeTableWork = DispatchWorkItem {
            self.fillTimeTable()
        }
        
        let concurrentQueue = DispatchQueue(label: "com.busSchedule.timeTable", qos: .background, attributes: .concurrent)
        
        concurrentQueue.async(execute: fillTimeTableWork)
        
        fillTimeTableWork.notify(queue: .main) {
            SVProgressHUD.dismiss()
        }
         */
    }
}

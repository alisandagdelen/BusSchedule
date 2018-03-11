//
//  TimeTableMock.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
@testable import BusSchedule

class TimeTableMock {
    
    static var timeTableOne: TimeTable {
        
        let coordinates = Coordinates(latitude: 49.599221, longitude: 6.13304)
        let routeDetail = RouteDetails(id: 1, name: "nameTest", address: "addressTest", fullAddress: "fullAddressTest", coordinates: coordinates)
        let dateTimeArrival = DateTime(timeStamp: 1520703000, timeZone:"GMT+02")
        
        let timeTableDetailsArrivalOne = TimeTableDetails(lineNumber: "lineNumTestArrivalOne", direction: "directionTestArrivalOne", time:dateTimeArrival, briefRoute:"routeTestArrivalOne", routeDetails:[routeDetail,routeDetail])
        let timeTableDetailsArrivalTwo = TimeTableDetails(lineNumber: "lineNumTestArrivalTwo", direction: "directionTestArrivalTwo", time:dateTimeArrival, briefRoute:"routeTestArrivalTwo", routeDetails:[routeDetail,routeDetail,routeDetail])
        
        let timeTableDetailsDepartureOne = TimeTableDetails(lineNumber: "lineNumTestDepartureOne", direction: "directionTestDepartureOne", time:dateTimeArrival, briefRoute:"routeTestDepartureOne", routeDetails:[routeDetail,routeDetail,routeDetail])
        let timeTableDetailsDepartureTwo = TimeTableDetails(lineNumber: "lineNumTestDepartureTwo", direction: "directionTestDepartureTwo", time:dateTimeArrival, briefRoute:"routeTestDepartureTwo", routeDetails:[routeDetail,routeDetail,routeDetail])
        let timeTableDetailsDepartureThree = TimeTableDetails(lineNumber: "lineNumTestDepartureThree", direction: "directionTestDepartureThree", time:dateTimeArrival, briefRoute:"routeTestDepartureThree", routeDetails:[routeDetail,routeDetail,routeDetail])
        
        return TimeTable(arrivals: [timeTableDetailsArrivalOne, timeTableDetailsArrivalTwo], departures: [timeTableDetailsDepartureOne, timeTableDetailsDepartureTwo, timeTableDetailsDepartureThree])
    }
    
    static var timeTableTwo: TimeTable {
        let coordinates = Coordinates(latitude: 51.342207, longitude: 12.381141)
        let routeDetail = RouteDetails(id: 5, name: "nameTest", address: "addressTest", fullAddress: "fullAddressTest", coordinates: coordinates)
        let dateTimeArrival = DateTime(timeStamp: 1520703600, timeZone:"GMT+03")
        
        let timeTableDetailsArrivalOne = TimeTableDetails(lineNumber: "lineNumTestArrivalOne", direction: "directionTestArrivalOne", time:dateTimeArrival, briefRoute:"routeTestArrivalOne", routeDetails:[routeDetail])
        let timeTableDetailsArrivalTwo = TimeTableDetails(lineNumber: "lineNumTestArrivalTwo", direction: "directionTestArrivalTwo", time:dateTimeArrival, briefRoute:"routeTestArrivalTwo", routeDetails:[routeDetail,routeDetail])
        let timeTableDetailsArrivalThree = TimeTableDetails(lineNumber: "lineNumTestArrivalThree", direction: "directionTestArrivalThree", time:dateTimeArrival, briefRoute:"routeTestArrivalThree", routeDetails:[routeDetail,routeDetail,routeDetail])
        
        let timeTableDetailsDepartureOne = TimeTableDetails(lineNumber: "lineNumTestDepartureOne", direction: "directionTestDepartureOne", time:dateTimeArrival, briefRoute:"routeTestDepartureOne", routeDetails:[routeDetail,routeDetail,routeDetail])
        let timeTableDetailsDepartureTwo = TimeTableDetails(lineNumber: "lineNumTestDepartureTwo", direction: "directionTestDepartureTwo", time:dateTimeArrival, briefRoute:"routeTestDepartureTwo", routeDetails:[routeDetail,routeDetail,routeDetail])
        
        return TimeTable(arrivals: [timeTableDetailsArrivalOne, timeTableDetailsArrivalTwo, timeTableDetailsArrivalThree], departures: [timeTableDetailsDepartureOne, timeTableDetailsDepartureTwo])
    }
}

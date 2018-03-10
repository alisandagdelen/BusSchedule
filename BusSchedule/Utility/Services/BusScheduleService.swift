//
//  BusScheduleService.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

enum City: Int {
    case berlin = 1
    case munich = 10
    
    var description: String {
        switch self {
        case .berlin: return "Berlin ZOB"
        case .munich: return "Munich ZOB"
        }
    }
}

protocol BusScheduleApi {
    func getTimeTable(city: City, _ result:@escaping GenericObjectClosure<TimeTable>)
}

class BusScheduleService: BusScheduleApi {
    static let sharedInstance = BusScheduleService()
    
    private init() {
    }
    
    func getTimeTable(city: City, _ result: @escaping (TimeTable?, Error?) -> Void) {
        let pathUrl = String(format: ApiURL.getTimeTable, city.rawValue)
        
        WebService.sharedInstance.getObject(pathUrl: pathUrl) { (busScheduleResponse: BusScheduleResponse?, error:Error?) in
            result(busScheduleResponse?.timeTable, error)
        }
    }
}

//
//  DateExtension.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

extension Date {
    func calenderDateForTimeZone(_ timeZone:String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/YY"
        dateFormater.timeZone = TimeZone(abbreviation: timeZone)
        return dateFormater.string(from: self)
    }
    
    func hourForTimeZone(_ timeZone:String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        dateFormater.timeZone = TimeZone(abbreviation: timeZone)
        return dateFormater.string(from: self)
    }
}

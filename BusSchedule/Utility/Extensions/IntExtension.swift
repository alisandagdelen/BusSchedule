//
//  IntExtension.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

extension Int {
    // MARK: Return Date
    var dateFromTimeStamp: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

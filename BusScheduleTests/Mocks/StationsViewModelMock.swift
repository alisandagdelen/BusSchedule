//
//  StationsViewModelMock.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
@testable import BusSchedule

class StationsViewModelMock: StationsViewModelProtocol {
    
    var countries: [Country] {
        return [.germany]
    }
    var stations: [Country : [City]] {
        return [.germany:[.berlin, .munich]]
    }
}

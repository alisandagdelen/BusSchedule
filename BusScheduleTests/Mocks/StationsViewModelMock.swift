//
//  StationsViewModelMock.swift
//  BusScheduleTests
//
//  Created by alisandagdelen on 11.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

@testable import BusSchedule

class StationsViewModelMock: StationsViewModelProtocol {
    
    var stations = Variable([ SectionModel(model: Country.germany.description, items: [City.berlin, City.munich]) ])
    
}

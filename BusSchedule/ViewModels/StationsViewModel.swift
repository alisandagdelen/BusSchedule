//
//  StationsViewModel.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

enum Country {
    case germany
    
    var description: String {
        switch self {
        case .germany: return "Germany"
        }
    }
}

protocol StationsViewModelProtocol {
    var stations: Variable<[SectionModel<String, City>]> { get }
}

// There is no endpoint for stations because of this StationsViewModel is static.
final class StationsViewModel: NSObject, StationsViewModelProtocol {
    
    var stations: Variable<[SectionModel<String, City>]>
    
    override init() {
        stations = Variable([ SectionModel(model: Country.germany.description, items: [.berlin, .munich]) ])
        super.init()
    }
}

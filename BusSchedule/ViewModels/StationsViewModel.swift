//
//  StationsViewModel.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

enum Country {
    case germany
    
    var description: String {
        switch self {
        case .germany: return "Germany"
        }
    }
}

protocol StationsViewModelProtocol {
    var countries: [Country] { get }
    var stations: [Country:[City]] { get }
}

// There is no endpoint for stations because of this StationsViewModel is static.
class StationsViewModel: NSObject, StationsViewModelProtocol {
    
    var countries: [Country] {
        return [.germany]
    }
    var stations: [Country : [City]] {
        return [.germany:[.berlin, .munich]]
    }
}

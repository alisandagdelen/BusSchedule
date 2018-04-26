//
//  RouteDetails.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

struct RouteDetails: BaseModel {
    
    var id: Int = 0
    var name: String = ""
    var address: String = ""
    var fullAddress: String = ""
    var coordinates: Coordinates? = nil
    
    init(id: Int, name: String, address: String, fullAddress: String, coordinates: Coordinates) {
        self.id = id
        self.name = name
        self.address = address
        self.fullAddress = fullAddress
        self.coordinates = coordinates
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case fullAddress = "full_address"
        case coordinates
    }
}

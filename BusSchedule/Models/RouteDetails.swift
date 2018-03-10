//
//  RouteDetails.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import ObjectMapper

struct RouteDetails: BaseModel {
    
    var id: Int = 0
    var name: String = ""
    var address: String = ""
    var fullAddress: String = ""
    var coordinates: Coordinates? = nil
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id           <- map["id"]
        name         <- map["name"]
        address      <- map["address"]
        fullAddress  <- map["full_address"]
        coordinates  <- map["coordinates"]
    }
}

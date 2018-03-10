//
//  Coordinates.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation
import ObjectMapper

struct Coordinates: BaseModel {
   
    var latitude: Float = 0.0
    var longitude: Float = 0.0
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        latitude   <- map["latitude"]
        longitude  <- map["longitude"]
    }
}

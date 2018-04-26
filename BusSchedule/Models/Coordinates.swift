//
//  Coordinates.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation

struct Coordinates: BaseModel {
   
    var latitude: Float = 0.0
    var longitude: Float = 0.0
    
    init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

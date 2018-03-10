//
//  ApiConstants.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import Foundation


enum ApiURL {
    static let baseURL = "http://api.mobile.staging.mfb.io/"
    static let getTimeTable = "mobile/v1/network/station/%d/timetable"
}

enum ApiHeader {
    static let authHeaderKey = "X-Api-Authentication"
    static let authHeaderValue = "intervIEW_TOK3n"
}

//
//  PathDetail.swift
//  BaroMap
//
//  Created by 이소리 on 12/4/23.
//

import Foundation

class PathDetail {
    var departure: String
    var destination: String
    var eta: String
    var countDown: Int
    var stationsInfo = Array<StationInfo>()
    
    init(departure: String, destination: String, eta: String, countDown: Int, stationsInfo: Array<StationInfo>) {
        self.departure = departure
        self.destination = destination
        self.eta = eta
        self.countDown = countDown
        self.stationsInfo = stationsInfo
    }
}

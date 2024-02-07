//
//  Coordinate.swift
//  BaroMap
//
//  Created by 이소리 on 12/4/23.
//

import Foundation

class Coordinate {
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool{
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

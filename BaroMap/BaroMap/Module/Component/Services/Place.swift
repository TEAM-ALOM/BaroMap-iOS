//
//  Place.swift
//  BaroMap
//
//  Created by 이소리 on 12/4/23.
//

import Foundation

struct Place: Identifiable, Equatable {
    let id = UUID()
    let placeName: String
    let placeAddress: String
    let coord: Coordinate
    let distance: Double
    
    init(placeName: String, placeAddress: String, coord: Coordinate, distance: Double) {
        self.placeName = placeName
        self.placeAddress = placeAddress
        self.coord = coord
        self.distance = distance
    }
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.placeName == rhs.placeName && lhs.placeAddress == rhs.placeAddress && lhs.coord == rhs.coord && lhs.distance == rhs.distance
    }
}

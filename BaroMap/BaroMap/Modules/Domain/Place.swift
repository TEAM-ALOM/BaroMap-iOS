//
//  Place.swift
//  BaroMap
//
//  Created by 이소리 on 12/4/23.
//

import Foundation

class Place {
    let placeName: String
    let placeAddress: String
    let coord: Coordinate
    
    init(placeName: String, placeAddress: String, coord: Coordinate) {
        self.placeName = placeName
        self.placeAddress = placeAddress
        self.coord = coord
    }
}

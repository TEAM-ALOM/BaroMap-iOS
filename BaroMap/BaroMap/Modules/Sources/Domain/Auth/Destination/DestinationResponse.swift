//
//  DestinationRequest.swift
//  classPractice
//
//  Created by 이소리 on 11/22/23.
//

import Foundation
import Moya

struct DestinationResponse: Decodable {
    var type: String
    var data: Data
    
    struct Data: Decodable {
        var place: Place
        var distance: Int
        
        struct Place: Decodable {
            var placeName: String
            var placeAddress: String
            var coordinate: Coordinate
            
            struct Coordinate: Decodable {
                var latitude: Double
                var longitude: Double
            }
        }
    }
}


//
//  DestinationResponse.swift
//  classPractice
//
//  Created by 이소리 on 11/22/23.
//

import Foundation
import CombineMoya

// FIXME: - 변수명 및 coord
struct DestinationRequest: Codable {
    var station_name: String
    var latitude: Double
    var longitude: Double
}

//
//  DestinationRequest.swift
//  classPractice
//
//  Created by 이소리 on 11/22/23.
//

import Foundation
import Moya

struct DestinationResponse: Codable {
    var type: String
    var data: Data
    
    struct Data: Codable {
        var place: Place
        var distance: Int
    }
}


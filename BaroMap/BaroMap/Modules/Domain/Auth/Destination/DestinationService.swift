//
//  DestinationService.swift
//  classPractice
//
//  Created by 이소리 on 11/20/23.
//

import Foundation
import Moya

public enum DestinationService {
    case findDestinations(place_name: String, latitude: Double, longitude: Double)
}

extension DestinationService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://baromap.com")!
    }
    
    public var path: String {
        switch self {
        case .findDestinations:
            return "/places/directions/destination"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .findDestinations:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .findDestinations(let place_name, let latitude, let longitude):
            let place_name = place_name
            let latitude = latitude
            let longitude = longitude
            
            return Data( // ex
                """
                {
                    "type": "success",
                    "value": {
                        "id": 200
                        
                    }
                }
                """.utf8
            )
        }
    }

    public var task: Task {
        switch self {
        case .findDestinations(let place_name, let latitude, let longitude):
            let params: [String : Any] = [
                "place_name": place_name,
                "latitude": latitude,
                "longitude": longitude
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
}

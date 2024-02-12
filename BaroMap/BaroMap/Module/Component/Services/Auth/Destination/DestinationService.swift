//
//  DestinationService.swift
//  classPractice
//
//  Created by 이소리 on 11/20/23.
//

import Foundation
import Moya

public enum DestinationService {
    case findDestinations(placeName: String, latitude: Double, longitude: Double) // 인자로 역 이름, 현재 내 위치를 전달함
}

extension DestinationService: TargetType {
    public var baseURL: URL {
        return URL(string: "https://www.alom-baromap.co.kr")!
    }
    
    public var path: String {
        switch self {
        case .findDestinations:
            return "/places/destination"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .findDestinations:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .findDestinations(let placeName, let latitude, let longitude):
            let params: [String : Any] = [
                "placeName": placeName,
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


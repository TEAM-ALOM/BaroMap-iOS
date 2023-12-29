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
    public var baseURL: URL {  // 클라이언트->서버->api호출
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
    
    // 테스트 안 하면 없어도 됨
    public var sampleData: Data {
        switch self {
        case .findDestinations(let placeName, let latitude, let longitude):
            let placeName = placeName
            let latitude = latitude
            let longitude = longitude
            
            return Data(
                """
                {
                    "type": "success",
                    "data": {
                        "id": 200,
                        "placeName": "\(placeName)종합운동장,
                        "distance": 3.7,
                        "address": "서울 송파구 올림픽로 25(잠실동)"
                        "latitude": "\(latitude)",
                        "logitude": "\(longitude)"
                    }
                }
                """.utf8
            )
        }
    }
// 어떻게 데이터를 전송할 것이냐 -
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


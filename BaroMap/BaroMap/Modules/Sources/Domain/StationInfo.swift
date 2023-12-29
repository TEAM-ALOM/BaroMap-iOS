//
//  StationInfo.swift
//  BaroMap
//
//  Created by 이소리 on 12/4/23.
//

import Foundation

class StationInfo {
    var stationId: String
    var line: Line
    var stationName: String
    var coord: Coordinate
    var nextTime: Int
    
    init(stationId: String, line: Line, stationName: String, coord: Coordinate, nextTime: Int) {
        self.stationId = stationId
        self.line = line
        self.stationName = stationName
        self.coord = coord
        self.nextTime = nextTime
    }
}

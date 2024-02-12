//
//  SearchLocationCell.swift
//  BaroMap
//
//  Created by 이소리 on 1/26/24.
//

import SwiftUI
import Foundation


// MARK: extension 해야하는지?

extension SearchLocationView {
    
    enum PlaceSearchType: String {
        case searching
        case from
        case to
        
        var placeholder: String {
            switch self {
            case .searching:
                return "장소"
                
            case .from:
                return "출발지"
                
            case .to:
                return "도착지"
            }
        }
    }
}

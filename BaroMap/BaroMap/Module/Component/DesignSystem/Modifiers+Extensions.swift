//
//  Modifiers+Extensions.swift
//  BaroMap
//
//  Created by 이소리 on 11/21/23.
//

import SwiftUI

extension View {
    /**
     안테나 디자인 시스템 Shadow의 Medium 스케일
     */
    func mediumShadow() -> some View {
        modifier(MediumShadow())
    }
    
    /**
     안테나 디자인 시스템 Shadow의 Large 스케일
     주로 지도 위에 올라간 UI 컴포넌트들과 같이 구분감을 확실하게 주고 싶을때 사용합니다.
     */
    func largeShadow() -> some View {
        modifier(LargeShadow())
    }
}

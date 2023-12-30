//
//  Paddings+Extensions.swift
//  BaroMap
//
//  Created by 이소리 on 11/21/23.
//

import SwiftUI

extension CGFloat {
    /**
     안테나 디자인 시스템  Spacing, Padding의 Tiny사이즈
     */
    static public let tinyPadding = CGFloat(4)
    
    /**
     안테나 디자인 시스템  Spacing, Padding의 두번째 Small사이즈
     */
    static public let smallPadding2 = CGFloat(8)
    
    /**
     안테나 디자인 시스템  Spacing, Padding의 Smaill사이즈
     */
    static public let smallPadding = CGFloat(12)
    
    /**
     안테나 디자인 시스템  Spacing, Padding의 두번째  large사이즈
     */
    static public let largePadding2 = CGFloat(20)
    
    /**
     안테나 디자인 시스템  Spacing, Padding의 Large사이즈
     */
    static public let largePadding = CGFloat(24)
    
    /**
     안테나 디자인 시스템  Spacing, Padding의 Extra Large사이즈
     */
    static public let extraLargePadding = CGFloat(40)
    
    /**
     안테나 디자인 시스템 어플리케이션 최대 가로 사이즈
     디바이스 화면 크기에 상관없이 적용 되는 UI의 최대 가로 사이즈 이며,
     아이패드 혹은 아이폰 가로모드일 경우 UI 컴포넌트들이 무작정 늘어나는 것을 방지하기 위해 제한하는 사이즈 입니다.
     */
    static public let widthMaxSize = CGFloat(500)
}

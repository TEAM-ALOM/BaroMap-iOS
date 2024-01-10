//
//  Modifiers.swift
//  BaroMap
//
//  Created by 이소리 on 11/21/23.
//

import SwiftUI

struct MediumShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.05), radius: 5)
    }
}

struct LargeShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: 5)
    }
}

struct SearchTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundColor(.textQuaternary)
            .accentColor(.keyColor)
            .padding()
            .frame(height: 34)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.shapeSecondaryColor)
            }
    }
}

struct CustomViewModifier: ViewModifier {
    let padding: CGFloat
    let backgroundColor: Color
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

extension View { // 이렇게 해서 View를 extension 하는 것이 일반적이고 관용적인 접근이라고 함
    
    func asTextField() -> some View {
        modifier(SearchTextFieldModifier())
    }

    func frameStyle(backgroundColor: Color, cornerRadius: CGFloat, padding: CGFloat) -> some View {
        self.modifier(CustomViewModifier(padding: padding, backgroundColor: backgroundColor, cornerRadius: cornerRadius))
    }
}

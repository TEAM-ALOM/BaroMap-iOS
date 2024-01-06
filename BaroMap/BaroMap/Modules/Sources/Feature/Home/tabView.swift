//
//  tabView.swift
//  BaroMap
//
//  Created by 김휘선 on 1/5/24.
//

import SwiftUI

struct tabView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection : $selection){
            tabView_home2()
                .tabItem{
                    Image(systemName:"house.fill")
                    Text("홈")
                }
                .tag(0)
            
            Text("지도")
                .font(.system(size:30))
                .tabItem{
                    Image(systemName:"map.fill")
                    Text("지도")
                }
                .tag(1)
            
            Text("메뉴")
                .font(.system(size:30))
                .tabItem{
                    Image(systemName:"line.3.horizontal")
                    Text("메뉴")
                }
                .tag(2)
        }.accentColor(.green)
    }
}

#Preview {
    tabView()
}


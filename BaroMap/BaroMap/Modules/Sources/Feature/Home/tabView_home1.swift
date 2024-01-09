//
//  tabView_home1.swift
//  BaroMap
//
//  Created by 김휘선 on 1/5/24.
//

import SwiftUI

struct tabView_home1: View {
    var body: some View {
        VStack {
            HStack{
                VStack(spacing:20){
                    Text("안테나")
                        .font(.system(size:34))
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    Text("현재 경로")
                        .fontWeight(.bold)
                }
                Spacer()
            }
            Spacer()
            HStack{
                VStack(spacing:20){
                    Text("현재 안내 중인 경로가 없어요.")
                        .font(.system(size:20))
                        .fontWeight(.semibold)
                    Text("경로 찾으러가기")
                        .font(.system(size:20))
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    tabView_home1()
}

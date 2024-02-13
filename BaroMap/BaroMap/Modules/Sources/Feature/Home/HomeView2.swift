//
//  HomeView2.swift
//  BaroMap
//
//  Created by 김휘선 on 1/30/24.
//

import SwiftUI

struct HomeView2: View {
    var body: some View {
        VStack{
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
            }.padding()
            Spacer()
            HStack{
                VStack{
                    Text("현재 안내 중인 경로가 없어요.")
                        .padding(.bottom, 20)
                    Text("경로 찾으러가기")
                        .padding(.bottom,150)
                }
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView2()
}

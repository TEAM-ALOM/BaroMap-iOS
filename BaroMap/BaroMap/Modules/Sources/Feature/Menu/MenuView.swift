//
//  MenuView.swift
//  classPractice
//
//  Created by 이소리 on 12/27/23.
//

import SwiftUI
import ComposableArchitecture

struct MenuView: View {
    let store: StoreOf<MenuStore>
    
    @State private var showServiceTerms = false
    @State private var showPrivacyPolicy = false
    @State private var showStyleMenu = false
    @State private var selectedStyle: StyleOption? = nil

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                List {
                    Section(header: Text("앱 정보")) {
                        HStack {
                            Text("버전")
                            Spacer()
                            Text("1.0.0") // 실제 버전 번호로 대체
                        }

                        Button(action: {
                            self.showServiceTerms.toggle()
                        }) {
                            Text("서비스 이용약관")
                        }
                        .sheet(isPresented: $showServiceTerms) {
                            Text("서비스 이용약관 내용")
                        }
                        
                        Button(action: {
                            self.showPrivacyPolicy.toggle()
                        }) {
                            Text("개인정보 처리방침")
                        }
                        .sheet(isPresented: $showPrivacyPolicy) {
                            Text("개인정보 처리방침 내용")
                        }
                    }
                    
                    Section(header: Text("설정")) {
                        Button(action: {
                            self.showStyleMenu.toggle()
                        }) {
                            Text("화면 스타일")
                        }
                    }
                }
                .navigationBarTitle("메뉴")
                .actionSheet(isPresented: $showStyleMenu) {
                    ActionSheet(
                        title: Text("화면 스타일"),
                        buttons: [
                            .default(Text("시스템 기본값")) { selectedStyle = StyleOption(style: "시스템 기본값") },
                            .default(Text("라이트 모드")) { selectedStyle = StyleOption(style: "라이트 모드") },
                            .default(Text("다크 모드")) { selectedStyle = StyleOption(style: "다크 모드") },
                            .cancel(Text("취소"))
                        ]
                    )
                }
                .sheet(item: $selectedStyle) { styleOption in
                    Text("선택한 화면 스타일: \(styleOption.style)")
                }
                .accentColor(.keyColor)
            }
        }
    }
}

struct StyleOption: Identifiable {
    var id = UUID()
    var style: String
}


//#Preview {
//    MenuView()
//}

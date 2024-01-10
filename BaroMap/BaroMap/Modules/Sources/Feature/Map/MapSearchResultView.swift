//
//  MapSearchResultView.swift
//  BaroMap
//
//  Created by 이소리 on 1/7/24.
//

import SwiftUI
import ComposableArchitecture


// 각종 버튼 튕겨 올라오게 -> 버튼 커스텀필요

struct MapSearchResultView: View {
    let store: StoreOf<SearchDestinationStore>
        
    var locationName: String
    var locationAddress: String
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                MapView()
                MapView()
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 95)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.shapeColor)
                        .largeShadow()
                        .padding(1)
                        .overlay( // overlay 이유
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("\(locationName)")
                                        .font(.subheadline)
                                        .bold()
                                    
//                                    Spacer() 너무 내려감, linespacing도 X
                                    
                                    Text("\(locationAddress)")
                                        .font(.footnote)
                                }
                                
                                Spacer()
                                
                                Menu {
                                    Button("도착지로") {
//                                        viewStore.send(.cancelButtonTapped) -> 보라색 오류(TCA)
                                        print("\(locationName) 을/를 도착지로 설정함")
                                    }
                                    Button("출발지로") {
//                                        viewStore.send(.cancelButtonTapped) -> 보라색 오류(TCA)
                                        print("\(locationName) 을/를 출발지로 설정함")
                                    }
                                } label: {
                                    VStack {
                                        Image(systemName: "location.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundColor(.keyColor)
                                        
                                        Text("길찾기") // from 장소검색: menu(길찾기), 출발지: text(출발지로), 도착지: text(도착지로)
                                            .font(.footnote)
                                            .foregroundColor(.keyColor)
                                    }
                                }
                            }
                                .padding()
                        )
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
            .onAppear {
                viewStore.send(.toggleDetailView(true))
            }
            .onDisappear {
                viewStore.send(.toggleDetailView(false))
            }
        }
    }
}

//#Preview {
//    MapSearchResultView()
//}

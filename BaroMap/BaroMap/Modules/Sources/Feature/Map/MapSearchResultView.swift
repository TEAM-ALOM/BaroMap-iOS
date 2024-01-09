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
    
    @State var locationName = "name"
    @State var locationAddress = "address"
    
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
                        .shadow(radius: 1)
                        .padding(1)
                        .overlay( // overlay 이유
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(locationName)")
                                        .font(.system(size: 13))
                                        .bold()

                                    Text("\(locationAddress)")
                                        .font(.system(size: 12))
                                }
                                
                                Spacer()
                                
                                Menu {
                                    Button("도착지로") {
                                        print("@를 도착지로 설정함")
                                    }
                                    Button("출발지로") {
                                        print("@를 출발지로 설정함")
                                    }
                                } label: {
                                    VStack {
                                        Image(systemName: "location.circle.fill")
                                            .foregroundColor(.keyColor)
                                        
                                        Text("길찾기")
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

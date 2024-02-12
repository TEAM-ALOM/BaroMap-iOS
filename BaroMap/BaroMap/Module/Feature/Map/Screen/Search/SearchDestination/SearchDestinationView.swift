//
//  SearchDestinationView.swift
//  BaroMap
//
//  Created by 이소리 on 11/15/23.
//

import SwiftUI
import ComposableArchitecture
import Moya

struct SearchDestinationView: View {
    let store: StoreOf<SearchDestinationStore>
            
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("검색어 입력", text: viewStore.binding(
                                get: \.userInput,
                                send: SearchDestinationStore.Action.updateText
                            ))

                            Spacer()
                            
                            if !viewStore.userInput.isEmpty {
                                Button(action: {
                                    viewStore.send(.updateText(""))
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.shapeQuaternaryColor)
                                }
                                .buttonStyle(.borderless) 
                            } else {
                                EmptyView()
                            }
                        }
                        .asTextField()

                        ScrollView {
                            HStack {
                                Text("검색 결과")
                                    .bold()
                                    .padding(5)
                                
                                Spacer()
                            }
                            
                            // TODO: List
                            VStack(spacing: 10) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(height: 66)
                                        .frame(maxWidth: .infinity)
                                        .foregroundColor(.shapeColor)
                                        .shadow(radius: 1)
                                        .padding(1)
                                        .overlay(
                                            HStack {
                                                VStack {
                                                    Image(systemName: "mappin.circle.fill")
                                                        .foregroundColor(.keyColor)
                                                        .font(.title3)
                                                    
                                                    Spacer()
                                                    
                                                    Text(formatDistance(3421))
                                                        .foregroundColor(.keyTertiaryColor)
                                                        .font(.caption)
                                                }
                                                
                                                VStack(alignment: .leading) {
                                                    Text(highlightMatchedText(viewStore.placeName, viewStore.userInput))
                                                        .foregroundColor(.textColor)
                                                        .font(.subheadline)
                                                        .bold()
                                                    
                                                    Spacer()
                                                    
                                                    Text(highlightMatchedText(viewStore.placeAddress, viewStore.userInput))
                                                        .foregroundColor(.textQuaternaryColor)
                                                        .font(.footnote)
                                                        .lineLimit(nil)
                                                }
                                                
                                                Spacer()
                                                
                                                // FIXME: 2
                                                
//                                                ,
//                                                isActive: viewStore.binding(
//                                                    get: \.isDetailViewActive,
//                                                    send: SearchDestinationStore.Action.detailViewTapped
                                                
                                                NavigationLink(
                                                    destination: SearchMapResultView(store: self.store.scope(state: \.searchMapResult, action: SearchDestinationStore.Action.searchMapResult))
                                                ) {
                                                    Text("지도 보기")
                                                        .font(.footnote)
                                                        .foregroundColor(.keyColor)
                                                }
                                            }
                                                .padding()
                                        )
                                }
                        }
                    }
                    .padding()
                    .navigationTitle("\(viewStore.title.placeholder) 검색")
                    .toolbar {
                        Button(action: {
                            viewStore.send(.cancelButtonTapped)
                        }, label: {
                            Text("닫기")
                                .foregroundColor(.keyColor)
                        })
                }
            }
        }
    }
    
    private func formatDistance(_ meters: Int) -> String {
        if meters < 1000 {
            return "\(meters)m"
        } else {
            let kilometers = Double(meters) / 1000.0
            return "\(String(format: "%.1f", kilometers))km"
        }
    }

    private func highlightMatchedText(_ originalText: String, _ userInput: String) -> AttributedString {
        let attributedString = NSMutableAttributedString(string: originalText)
        let highlightedRange = originalText.lowercased().range(of: userInput.lowercased())
        let uiColor = UIColor(.keyColor)

        if let range = highlightedRange {
            let nsRange = NSRange(range, in: originalText)
            attributedString.addAttribute(.foregroundColor, value: uiColor, range: nsRange)
        }

        return AttributedString(attributedString)
    }
}

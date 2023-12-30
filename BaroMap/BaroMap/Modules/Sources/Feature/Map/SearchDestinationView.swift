//
//  SearchDestinationView.swift
//  classPractice
//
//  Created by 이소리 on 11/15/23.
//

import SwiftUI
import ComposableArchitecture
import Moya

struct SearchDestinationView: View {
    let store: StoreOf<SearchDestinationStore>
    
    @State var destination: String = ""
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("검색어 입력", text: $destination)
                            
                            Spacer()
                            
                            // FIXME: x 버튼 위치 살짝 우측으로 밀어야 함
                            if !destination.isEmpty {
                                Button(action: {
                                    self.destination = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.shapeQuaternaryColor) // shapeQuaternaryColor
                                }
                            } else {
                                EmptyView()
                            }
                        }
                        .asTextField()

                        ScrollView {
                            HStack {
                                Text("검색 결과") // 안에 있는 게 더 자연스러움
                                    .bold()
                                    .padding(5)
                                
                                Spacer()
                            }
                            
                            // 나중에 modifier
                            RoundedRectangle(cornerRadius: 20)
                                .frame(height: 66)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.shapeColor)
                                .shadow(radius: 1) // modifier 적용
                                .padding(1) // infinity 때문에 살짝 잘려서
                                .overlay(
                                    HStack {
                                        VStack {
                                            Image(systemName: "mappin.circle.fill")
                                                .foregroundColor(.keyColor)
                                            
                                            Spacer()
                                            
                                            Text("3.6km")
                                                .foregroundColor(.keyTertiaryColor)
                                                .font(.system(size: 12))
                                        }
                                        VStack(alignment: .leading) {
                                            Text("\(destination)")
                                                .font(.system(size: 13))
                                                .bold()
                                            
                                            Spacer()
                                            
                                            Text("서울 송파구 잠실동 1-1")
                                                .font(.system(size: 12))
                                        }
                                        
                                        Spacer()
                                        
                                        NavigationLink(destination: Text("장소 검색 결과 화면(지도)")) {
                                            Text("지도 보기")
                                                .font(.system(size: 13))
                                                .foregroundColor(.keyColor) // keyColor
                                            
                                        }
                                    }
                                        .padding()
                                )
                        }
                    }
                    .padding()
                    .navigationTitle("장소 검색")
                    .toolbar {
                        Button(action: {
                            viewStore.send(.cancelButtonTapped)
                        }, label: {
                            Text("닫기")
                                .foregroundColor(.keyColor) // keyColor
                        })
                }
            }
        }
    }
}

struct SearchTextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
            .foregroundColor(.textColor) // textQuatuernary
            .accentColor(.keyColor)
//            .underline(true)
            .padding()
            .frame(height: 34)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.shapeSecondaryColor) // shapeSecondary
            }
    }
}

extension View {
    
    func asTextField() -> some View {
        modifier(SearchTextFieldModifier()) // 이렇게 해서 View를 extension 하는 것이 일반적이고 관용적인 접근이라고 함
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var baboView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let provider = MoyaProvider<DestinationService>()
        provider.request(.findDestinations(placeName: "강남", latitude: 123.456, longitude: 789.012)) { (result) in
            switch result {
            case let .success(response):
                let result = try? response.map(DestinationResponse.self)
                self.baboView.text = result?.data.place.placeName
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

// 테스트 코드인데 실행 안됨
//func testExample() throws {
//
//      let disposeBag = DisposeBag()
//
//      //async 테스트를 위해 expectation 작성
//      let expectation = XCTestExpectation()
//
//
//      //moya에서 제공해주는 라이브러리로 실제 서버가 아닌 커스텀 엔드포인트를 만드는 과정이다.
//      let customEndpointClosure = { (target: DestinationService) -> Endpoint in
//          return Endpoint(url: URL(target: target).absoluteString,
//                          sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//                          method: target.method,
//                          task: target.task,
//                          httpHeaderFields: target.headers)
//      }
//
//      //provider 를 생성 할 때, 앞 서 작성한 커스텀 엔드 포인트를 넣어 준다.
//      //immediatelyStub는 서버의 반응이 즉각 적인 옵션이고 0.5초나 2초도 있다.
//      let testingProvider = MoyaProvider<DestinationService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
//
//    testingProvider.rx.request(.findDestinations(placeName: "강남", latitude: 123.456, longitude: 789.012))
//          .subscribe{ (result) in
//                      switch result {
//                      case .success(let response):
//                          let result = try? response.map(DestinationResponse.self)
//                          //응답 받은 값이 같은 지 확인 한다.
//                          XCTAssertEqual(result?.data.place.placeName, "잠실방배동" )
//
//                      case .failure(let error):
//                          print(error.localizedDescription)
//                      }
//                      //response 를 받으면 조건은 갖추어 진것으로 본다.
//                      expectation.fulfill()
//
//                  }
//                  .disposed(by: disposeBag)
//  }


//#Preview {
//    SearchDestinationView()
//}

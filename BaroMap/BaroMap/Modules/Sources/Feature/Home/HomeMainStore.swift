import Foundation
import ComposableArchitecture

struct HomeMainStore: Reducer {
    //도메인 + 상태
    struct State: Equatable{
        var count = 0   //0,1로 나누어서 화면 보여주기
    }

    //도메인 + 액션
    enum Action: Equatable{
        case nopath //path 없는 액션
        case yespath //path 있는 액션
    }
    
    var body: some Reducer<State, Action>{
        Reduce{ state, action in
            switch action {
            case .nopath:
                state.count = 1
                return .none
            case .yespath:
                state.count = 0
                return .none
            }
        }
    }

}



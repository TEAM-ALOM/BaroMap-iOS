//
//  tabView_home2.swift
//  BaroMap
//
//  Created by 김휘선 on 1/5/24.
//

import SwiftUI

struct tabView_home2: View {
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
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 353, height: 432)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
                VStack{
                    HStack{
                        Text("21:59 도착")
                            .font(.system(size:20))
                            .fontWeight(.bold)
                        Spacer()
                        Text("18분 남음")
                            .font(.system(size:20))
                            .fontWeight(.bold)
                    }
                    HStack{
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.red)
                            .padding(.leading,3)
                        Text("세종대학교")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack{
//                        VStack{
//                            Image(systemName: "figure.walk")
//                                .resizable()
//                                .frame(width: 12, height: 12)
//                                .foregroundColor(.brown)
//                            Image(systemName:"arrowtriangle.down.fill")
//                                .resizable()
//                                .frame(width: 8, height: 8)
//                                .foregroundColor(.brown)
//                        }
                        Image(systemName:"arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(.brown)
                            .padding(.leading, 5)
                        Text("걷기")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("도보 274m, 5분 소요")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "7.circle.fill")
                            .resizable()
                            .frame(width:20, height:20)
                            .foregroundColor(.brown)
                        Text("어린이대공원역 승차")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("석남(거북시장) 방면")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width:8, height:8)
                            .foregroundColor(.brown)
                            .padding(.leading, 5)
                        Text("빠른 환승 1-1")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width:8, height:8)
                            .foregroundColor(.brown)
                            .padding(.leading, 5)
                        Text("2분")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("1개역 이동")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "7.circle.fill")
                            .resizable()
                            .frame(width:20, height:20)
                            .foregroundColor(.brown)
                        Text("건대입구역 하차")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("8번 출구")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
//                        VStack{
//                            Image(systemName: "figure.walk")
//                                .resizable()
//                                .frame(width: 12, height: 12)
//                                .foregroundColor(.brown)
//                            Image(systemName:"arrowtriangle.down.fill")
//                                .resizable()
//                                .frame(width: 8, height: 8)
//                                .foregroundColor(.brown)
//                                .padding(.leading, 2)
//                        }
                        Image(systemName:"arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(.brown)
                            .padding(.leading, 5)
                        Text("걷기")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("도보 274m, 5분 소요")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "2.circle.fill")
                            .resizable()
                            .frame(width:20, height:20)
                            .foregroundColor(.green)
                        Text("건대입구역 승차")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("구의 방면")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width:8, height:8)
                            .foregroundColor(.green)
                            .padding(.leading, 5)
                        Text("빠른 하차 3-4, 9-3")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "arrowtriangle.down.fill")
                            .resizable()
                            .frame(width:8, height:8)
                            .foregroundColor(.green)
                            .padding(.leading, 5)
                        Text("13분")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        Text("6개역 이동")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                        Image(systemName: "chevron.down")
                        //누르면 역 리스트로 뜨게끔 하기
                            .resizable()
                            .frame(width:8, height: 4)
                            .foregroundColor(.brown)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "2.circle.fill")
                            .resizable()
                            .frame(width:20, height:20)
                            .foregroundColor(.green)
                        Text("종합운동장역 하차")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("8번 출구")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName:"arrowtriangle.down.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                            .foregroundColor(.green)
                            .padding(.leading, 5)
                        Text("걷기")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Text("도보 274m, 5분 소요")
                            .font(.system(size:11))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "circle.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.red)

                        Text("종합운동장역 2호선 도착")
                            .font(.system(size:13))
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .padding()
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    tabView_home2()
}

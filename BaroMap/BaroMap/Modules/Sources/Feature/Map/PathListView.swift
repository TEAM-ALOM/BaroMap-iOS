//
//  PathListView.swift
//  BaroMap
//
//  Created by 이소리 on 12/4/23.
//

import SwiftUI

struct searchLocation: View {
    @State private var departureText: String = ""
    @State private var destinationText: String = ""
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(width:393, height:180)
                    .background(.white)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 2.5, x: 0, y: 0)
                VStack{
                    HStack{
                        VStack {
                            TextField("출발지를 입력하세요", text: $departureText)
                                .frame(width: 324, height: 34)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                               // .foregroundColor(Color.blue)
                            TextField("도착지를 입력하세요", text: $destinationText)
                                .frame(width: 324, height: 34)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                        }
                        Image(systemName:"arrow.up.arrow.down")
                            .resizable()
                            .frame(width: 25, height: 20)
                            .foregroundColor(.pink)
                    }
                    
                    HStack{
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 113, height: 32)
                                .background(.green)
                                .cornerRadius(20)
                            HStack{
                                Image(systemName: "tram.fill")
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.white)
                                Text("대중교통")
                                    .font(.system(size:13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("+16")
                                    .font(.system(size:13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width:67, height: 32)
                                .background(.brown)
                                .cornerRadius(20)
                                
                            HStack{
                                Image(systemName:"figure.walk")
                                    .frame(width:16, height:16)
                                    .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
                                    .foregroundColor(.white)
                                Text("도보")
                                    .font(.system(size:13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                        HStack{
                            Text("오늘 9:41 출발")
                                .font(.system(size:12))
                                .foregroundColor(.gray)
                            Image(systemName:"chevron.up")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.gray)
                            Text("시간순")
                                .font(.system(size:12))
                                .foregroundColor(.gray)
                            Image(systemName:"chevron.up.chevron.down")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }.padding(.top,12)
                }
                .padding()
            }
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 353, height: 167)
                    .background(.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
                VStack{
                    HStack{
                        VStack{
                            HStack{
                                Image(systemName:"2.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.green)
                                    .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
                                    .padding(.leading,36)
                                if !departureText.isEmpty {
                                    Text(departureText)
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    }
                                else {
                                    Text("출발지") // 기본값
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    }
                                Spacer()
                            }
                            HStack{
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.green)
                               Spacer()
                            }.padding(.leading,42)
                            HStack{
                                Image(systemName:"7.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.brown)
                                    .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
                                    .padding(.leading,36)
                                Text("건대입구역")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack{
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.brown)
                               Spacer()
                            }.padding(.leading,42)
                            HStack{
                                Image(systemName: "circle.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.pink)
                                if !destinationText.isEmpty {
                                    Text(destinationText)
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    }
                                else {
                                    Text("도착지") // 기본값
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    }
                                Spacer()
                            }.padding(.leading,37)
                        }
                        Spacer()
                        VStack{
                            Text("25분 소요")
                                .font(.system(size:20))
                                .fontWeight(.bold)
                                .foregroundColor(.pink)
                                .padding(.trailing, 36)
                            Image(systemName:"arrow.triangle.turn.up.right.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.pink)
                            Text("길찾기")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .foregroundColor(.pink)
                        }
                    }
                    //.padding()
                    HStack(spacing:0){
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 48, height: 15)
                                .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                //.cornerRadius(5)
                            Image(systemName:"figure.walk")
                                .resizable()
                                .frame(width: 8, height: 8)
                                .foregroundColor(.brown)
                        }
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 16, height: 15)
                                .background(Color(red: 0.45, green: 0.5, blue: 0))
                            Text("7")
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                        }
                        ZStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 256, height: 15)
                                .background(Color(red: 0, green: 0.66, blue: 0.3))
                                //.cornerRadius(5)
                            Text("2")
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                        }
                    }
                }
            }
        }
        Spacer()
    }
}


//#Preview {
//    PathListView()
//}

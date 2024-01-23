//
//  date_time_test.swift
//  BaroMap
//
//  Created by 김휘선 on 1/11/24.
//

import SwiftUI

struct date_time_test: View {
    @State private var click = false
    @State private var isDatePickerVisible = false
    @State private var currentTime = Date()
    
    var body: some View {
        Button(action:{
            click.toggle()
        }){
            HStack{
                Text("\(formattedDate(currentTime)) 출발")
            }
        }
        .sheet(isPresented: $click){
            VStack{
                DatePicker("DatePicker", selection : $currentTime, displayedComponents: [.date, .hourAndMinute])
                    .datePickerStyle(.graphical)
                
                Button("Confirm"){
                    click.toggle()
                }.padding()
            }
            
            
        }
    }
    private func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM월 dd일 HH:mm"
            return dateFormatter.string(from: date)
        }
}

#Preview {
    date_time_test()
}

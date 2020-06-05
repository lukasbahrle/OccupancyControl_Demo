//
//  HistoryView.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var theme: Theme
    
    @State private(set) var selectedIndex: Int = 0
    var max: Int
    var data: [HistoryItemViewModel]
    var isIn: Bool
    
    var index: Int {
        return isIn ? selectedIndex : -1
    }
       
    private func data(for index: Int) -> [Double]{
        // TODO: don't hardcode the count
        if index < 0 {
            // if in loading state
            return Array(repeatElement(Double(1), count: 27))
        }
        else if self.data.count == 0 {
            // if no data
            return Array(repeatElement(Double(0), count: 27))
        }
        else{
            return self.data[index].values.map{Double($0) / Double(max)}
        }
    }
       
    private var vector:Vector {
       Vector(with: data(for: self.index))
    }
    
    private var graphPadding:EdgeInsets{
        EdgeInsets(top: 10, leading: self.isIn ? 35 : 20, bottom: 10, trailing: self.isIn ? 0 : 20)
    }

    var body: some View {
        GeometryReader { geometry in
       VStack(spacing: 0){
        
           ZStack{
                // lines showing the values
                VStack(spacing: 0){
                        ForEach(0 ..< 5){ index in
                            HistoryValueIndicator(value: 100 - index * 25)
    
                            if index < 4 {
                                Spacer()
                            }
                        }
                   }
                .opacity(self.isIn ? 1.0 : 0)
                   
               // graph
               GraphView(controlPoints: self.vector, closedArea: false, originBottomLeft: true)
                .stroke(self.isIn ? self.theme.tintColor: Color(.label), lineWidth: self.isIn ? self.theme.chartLineWidth : 1)
                .padding(self.graphPadding)
           }
           .animation(.interpolatingSpring(mass: 1, stiffness: 100, damping: self.isIn ? 10.0: 100.0, initialVelocity: 0))
           .cornerRadius(6)
           
           // navigation buttons
           HStack(alignment: .bottom){
                  ForEach(0 ..< 3){ buttonIndex in
                       if buttonIndex < self.data.count {
                           Button(action: {
                               self.selectedIndex = buttonIndex
                           }) {
                               Text(self.data[buttonIndex].label)
                           }
                           .buttonStyle(HistoryButtonStyle(isSelected : buttonIndex == self.selectedIndex))
                       }
                        if buttonIndex < 2 {
                            Spacer()
                        }
                   }
           }
           .frame(height: self.isIn ? 40 : 0)
           .padding(.leading, self.isIn ? 35 : 0)
           .opacity(self.isIn ? 1.0 : 1.0)
            
       }
       .padding(.leading, self.isIn ? 20 : 0)
       .padding(.trailing, self.isIn ? 20 : 0)
    }
    }
}



struct HistoryButtonStyle: ButtonStyle{
    var isSelected: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
         .foregroundColor(self.isSelected ? Color(.label) : Color(.systemGray2))
    }
}


struct HistoryValueIndicator: View {
    var value:Int
    
    var body: some View{
        HStack(spacing: 5){
            Text("\(value)")
                .font(.caption)
                .frame(width: 25, alignment: .trailing)
                
            HistoryLine()
                .stroke(Color(.systemGray3), lineWidth: 1)
                .frame(height: 20)
        }
    }
}


struct HistoryLine: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let startPoint = CGPoint(x: 0, y: rect.size.height * 0.5)
            path.move(to: startPoint)
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height * 0.5))
        }
    }
}



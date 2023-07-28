//
//  WelcView.swift
//  Cupcake Corner
//
//  Created by Yashraj jadhav on 28/07/23.
//

import SwiftUI

struct WelcView: View {
    @State var isActive : Bool = false
    
    var body: some View {
        
        if isActive {
            ContentView()
        }
        else
        {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 432, height: 932)
                .background(Color(red: 0.12, green: 0.7, blue: 0.65))
                .cornerRadius(22)
                .overlay(
                    VStack {
                        Image("Ellipse")
                            .frame(width: 95, height: 95)
                            .position(x: 320, y: 196)
                        
                        Image("Cake")
                            .frame(width: 144, height: 184)
                            .position(x: 215, y: 245)
                        
                        
                        VStack{
                            Text("Cupcake")
                            Text("Corner")
                        }
                        .font(Font.custom("Quitery", size: 41))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                        .position(x: 210, y: 250)
                        
                        Text("Oder now what you want to eat!")
                            .position(x: 210, y: 180)
                            .foregroundColor(Color(red: 0.96, green: 0.96, blue: 0.96))
                        
                        Image("Ellipse2")
                            .frame(width: 81, height: 81)
                            .position(x: 92, y: 199)
                        
                        Image("Ellipse3")
                            .frame(width: 81, height: 81)
                            .position(x: 340, y: 143)
                            
                       
                        
                        Image("Ellipse1")
                            .frame(width: 192, height: 192)
                            .position(x: 80, y: -699)
                    }
                )
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

struct WelcView_Previews: PreviewProvider {
    static var previews: some View {
        WelcView()
    }
}

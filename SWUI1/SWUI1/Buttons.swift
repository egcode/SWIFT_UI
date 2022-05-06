//
//  Buttons.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct Buttons: View {
    
    @State var myTitle: String = "This is my title"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(myTitle)
            
            Button("Press me!") {
                self.myTitle = "BUTTON #1 WAS PRESSED"
            }
            .accentColor(.red)
            
            
            Button(action: {
                self.myTitle = "BUTTON #2 WAS PRESSED"
            }, label: {
                Text("Save".uppercased())
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(
                        Color.blue
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    )
            })
            
            
            Button(action: {
                self.myTitle = "BUTTON #3 WAS PRESSED"
            }, label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 75, height: 75)
                    .shadow(radius: 10)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.red)
                    )
            })

            
            
            Button(action: {
                self.myTitle = "BUTTON #4 WAS PRESSED"
            }, label: {
                Text("Finish".uppercased())
                    .font(.caption)
                    .bold()
                    .foregroundColor(.gray)
                    .padding()
                    .padding(.horizontal, 10)
                    .background(
                        Capsule()
                            .stroke(Color.gray, lineWidth: 2.0)
                    )
            })

            
            
            
            
        }
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}

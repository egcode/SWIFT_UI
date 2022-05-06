//
//  BindingDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct BindingDemo: View {
    
    @State var someText = "Initial Text"
    
    var body: some View {
        Text(someText)
        
        SomeButton(someText: $someText)
    }
}


struct SomeButton: View {
    
    @Binding var someText: String
    
    var body: some View {
        Button(action: {
            self.someText = "The Text have Changed"
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

    }
    
}



struct BindingDemo_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BindingDemo()
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}

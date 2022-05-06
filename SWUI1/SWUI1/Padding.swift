//
//  Padding.swift
//  SWUI1
//
//  Created by Eugene G on 5/3/22.
//

import SwiftUI

struct Padding: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            Text("This is blah text description of wha we will do on this screen. It is multiple lines and we will align the text to the leadling edge.")
        }
        .padding()
        .padding(.vertical, 10)
        .background(
            Color.white
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.3),
                        radius: 10,
                        x: 0.0, y: 10)
        )
        .padding(.horizontal, 10)
    }
}

struct Padding_Previews: PreviewProvider {
    static var previews: some View {
        Padding()
    }
}

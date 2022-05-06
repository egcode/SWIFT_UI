//
//  SafeArea.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct SafeArea: View {
    var body: some View {
        ScrollView {
                VStack {
                    Text("Title goes here")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(0..<10) { Index in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.white)
                            .frame(height:150)
                            .shadow(radius: 10)
                            .padding(20)
                    }
            }
        }
        .background(
            Color.red
                .edgesIgnoringSafeArea(.bottom)
        )
    }
}

struct SafeArea_Previews: PreviewProvider {
    static var previews: some View {
        SafeArea()
    }
}

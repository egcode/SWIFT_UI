//
//  ContentView.swift
//  SWUI1
//
//  Created by Eugene G on 5/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world1- Zalupa!")
            .font(.title)
            .foregroundColor(Color.blue)
            .padding()
        Button("Button") {
            suka(blah: "Text from button")
        }
    }
    
    
    func suka(blah: String) {
        print("Blah method: - \(blah)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

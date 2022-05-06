//
//  NavigationDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct NavigationDemo: View {
    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink("Hello World",
                               destination: MyOtherScreen())
                Text("HEllo World 1")
                Text("HEllo World 2")
                Text("HEllo World 3")
                Text("HEllo World 4")
                Text("HEllo World 5")
            }
            .navigationTitle("All Inboxes")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarHidden(true)
            .navigationBarItems(
                leading:
                    HStack {
                        Image(systemName: "person.fill")
                        Image(systemName: "flame.fill")
                    }
                ,
                trailing:
                    NavigationLink(
                        destination: MyOtherScreen(),
                        label: {
                            Image(systemName: "gear")
                        })
                    .accentColor(.red)
            
            )
        }
    }
}

struct MyOtherScreen: View {
        
    @Environment(\.presentationMode) var presMode
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
                .navigationTitle("Green Screen")
//                .navigationBarHidden(true)
            
            VStack {
                Button("Back BUTTON") {
                    presMode.wrappedValue.dismiss()
                }
                
                NavigationLink("CLick here", destination: Text("3rd Screen!"))
            }
        }
        
    }
}


struct NavigationDemo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDemo()
    }
}

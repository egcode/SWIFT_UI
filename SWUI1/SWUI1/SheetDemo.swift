//
//  SheetDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct SheetDemo: View {
    
    @State var showNewScreen: Bool = false
    
    var body: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)
            
            Button {
                showNewScreen.toggle()
            } label: {
                Text("Button")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding(20)
                    .background(Color.white.cornerRadius(10))
            }
            
            
            // METHOD 1 - SHEET
            .sheet(isPresented: $showNewScreen) {
                //
            } content: {
                // DO NOT ADD CONTITIONAL LOGIC
                SecondView(showNewScreen: $showNewScreen)
            }

//            // METHOD 2 - TRANSITION
//            ZStack {
//                if showNewScreen {
//                        SecondView(showNewScreen: $showNewScreen)
//                            .padding(.top, 100)
//                            .transition(.move(edge: .bottom))
//                            .animation(.spring())
//                }
//            }
//            .zIndex(2.0)
            
//            // METHOD 3 - ANIMATION OFFSET
//            SecondView(showNewScreen: $showNewScreen)
//                .padding(.top, 100)
//                .offset(y: showNewScreen ? 0 : UIScreen.main.bounds.height)
//                .animation(.spring())

            
            
        }
    }
}


struct SecondView: View {
        
    @Environment(\.presentationMode) var presMode
    @Binding var showNewScreen: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.red
                .edgesIgnoringSafeArea(.all)
                
            Button {
                // METHOD 1 - SHEET
                presMode.wrappedValue.dismiss()
                
//                // METHOD 2-3 - TRANSITION or ANIMATION OFFSET
//                showNewScreen.toggle()
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding(20)
            }
        }
    }
}


struct SheetDemo_Previews: PreviewProvider {
    static var previews: some View {
        SheetDemo()
    }
}

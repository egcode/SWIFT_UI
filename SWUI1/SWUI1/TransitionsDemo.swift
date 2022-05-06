//
//  TransitionsDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct TransitionsDemo: View {
    
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Button("BUTTON") {
                    showView.toggle()
                }
                Spacer()
            }
            
            if showView {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal:AnyTransition.opacity.animation(.easeIn)))
                    .animation(.easeIn)
            }
            
        }
    }
}


struct TransitionsDemo_Previews: PreviewProvider {
    static var previews: some View {
        TransitionsDemo()
    }
}

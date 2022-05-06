//
//  AnimationDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/4/22.
//

import SwiftUI

struct AnimationDemo: View {
    
    @State var isAnimated: Bool = true
    @State var isAnimated2: Bool = true

    var body: some View {
        VStack {
            Button("Button") {
                withAnimation(Animation
                                .linear(duration: 0.5)
//                                .default
//                                .repeatForever(autoreverses: true)
                ){
                    isAnimated.toggle()
                }
            }
//            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y : isAnimated ? 300 : 0)
//                .animation(Animation
//                            .default
//                            .repeatForever(autoreverses: true)
//                )
            
            Spacer()
            Button("Button2") {
                isAnimated2.toggle()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimated2 ? 350 : 50, height: 100)
                .animation(.spring(
                    response: 0.7,
                    dampingFraction: 0.4,
                    blendDuration: 1.0))

        }
    }
}

struct AnimationDemo_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemo()
    }
}

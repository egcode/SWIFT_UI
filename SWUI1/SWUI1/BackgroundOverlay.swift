//
//  BackgroundOverlay.swift
//  SWUI1
//
//  Created by Eugene G on 5/3/22.
//

import SwiftUI

struct BackgroundOverlay: View {
    var body: some View {
        Image(systemName: "heart.fill")
            .font(.system(size: 40))
            .foregroundColor(Color.orange)
            .background(
                Circle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                    )
                    .frame(width: 100, height: 100)
                    .shadow(color: Color(#colorLiteral(red: 0.016, green: 0.19, blue: 0.3, alpha: 0.6)), radius: 10, x: 0.0, y: 10)
                    .overlay(
                        Circle()
                            .fill(Color.green)
                            .frame(width: 35, height: 35)
                            .overlay(
                                Text("5")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                            .shadow(color: Color(#colorLiteral(red: 0.016, green: 0.19, blue: 0.3, alpha: 0.6)), radius: 10, x: 0.0, y: 10)
                            
                        , alignment: .bottomTrailing)
            )
    }
}

struct BackgroundOverlay_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundOverlay()
    }
}

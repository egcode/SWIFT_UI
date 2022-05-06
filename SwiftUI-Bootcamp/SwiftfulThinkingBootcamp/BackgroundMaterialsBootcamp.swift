//
//  BackgroundMaterialsBootcamp.swift
//  SwiftfulThinkingBootcamp
//
//  Created by Nick Sarno on 11/14/21.
//

import SwiftUI

struct BackgroundMaterialsBootcamp: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 50, height: 4)
                    .padding()
                Spacer()
                Text("Hello Blah")
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(30)
            
/*
 regularMaterial
 thickMaterial      // A material that's more opaque than translucent.
 thinMaterial       // A material that's more translucent than opaque.
 ultraThinMaterial  // A mostly translucent material
 ultraThickMaterial // A mostly opaque material
 */
        }
        .ignoresSafeArea()
        .background(
            Image("therock")
        )
    }
}

struct BackgroundMaterialsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundMaterialsBootcamp()
    }
}

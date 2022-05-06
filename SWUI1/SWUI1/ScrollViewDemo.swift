//
//  ScrollViewDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/3/22.
//

import SwiftUI

struct ScrollViewDemo: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<100) { index in
                    ScrollView(.horizontal, showsIndicators: true, content: {
                        LazyHStack {
                            ForEach(0..<20) { ind in
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(Color.white)
                                    .frame(width: 200, height: 150)
                                    .shadow(radius: 10)
                                    .padding()
                            }
                        }
                    })
                }
            }
        }
    }
}

struct ScrollViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewDemo()
    }
}

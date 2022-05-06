//
//  FrameView.swift
//  SWUI1
//
//  Created by Eugene G on 5/3/22.
//

import SwiftUI

struct FrameView: View {
    var body: some View {
        Text("Hello, World! aa")
            .background(Color.blue)
//            .frame(width: 300, height: 300, alignment: .center)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.red)
            .overlay(
                Circle()
                    .fill(Color.green)
            )
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}

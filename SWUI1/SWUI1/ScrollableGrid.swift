//
//  ScrollableGrid.swift
//  SWUI1
//
//  Created by Eugene G on 5/3/22.
//

import SwiftUI

struct ScrollableGrid: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
    ]

    
    var body: some View {
        ScrollView {
            
            Rectangle()
                .fill(Color.orange)
                .frame(height: 400)
            
            // Section 1
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 6,
                      pinnedViews: [.sectionHeaders],
                      content: {
                Section(header:
                            Text("Section 1")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue)
                            .padding()
                ) {
                    ForEach(0..<20, content: { index in
                        Rectangle()
                            .fill(Color.purple)
                            .frame(height: 150)
                    })
                }
            })
            
            
            // Section 2
            LazyVGrid(columns: columns,
                      alignment: .center,
                      spacing: 6,
                      pinnedViews: [.sectionHeaders],
                      content: {
                Section(header:
                            Text("Section 2")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue)
                            .padding()
                ) {
                    ForEach(0..<20, content: { index in
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 150)
                    })
                }
            })

            
            
            
            
        }
        
        
    }
}

struct ScrollableGrid_Previews: PreviewProvider {
    static var previews: some View {
        ScrollableGrid()
    }
}

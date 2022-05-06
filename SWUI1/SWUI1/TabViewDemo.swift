//
//  TabViewDemo.swift
//  SWUI1
//
//  Created by Eugene G on 5/5/22.
//

import SwiftUI

struct TabViewDemo: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView (selection: $selectedTab) {
            HomeView(selectTab: $selectedTab)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            Text("BROWSE TAB")
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Browse")
                }
                .tag(1)
                .background(Color.yellow)
                .frame(width: .infinity,
                       height: .infinity)
            
            Text("PROFILE TAB")
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "globe")
                    Text("Browse")
                }
                .tag(2)

        }
        .background(.green)
        .accentColor(.orange)
//        .tabViewStyle(PageTabViewStyle()) // --- SCROLL PAGES
        .tabViewStyle(DefaultTabViewStyle())

        
    }
}

struct TabViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TabViewDemo()
    }
}


struct HomeView: View {
    
    @Binding var selectTab: Int
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("Home Tab")
                    .font(.largeTitle)
                .foregroundColor(.white)
                
                Button {
                    selectTab = 2
                } label: {
                    Text("Go to Profile")
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                }

            }
            
            
        }
    }
}

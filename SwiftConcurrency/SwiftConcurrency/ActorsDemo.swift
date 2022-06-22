//
//  ActorsDemo.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 6/21/22.
//

import SwiftUI

class MyDataManager {
    
    static let instance = MyDataManager()
    private init() {    }
    
    var data: [String] = []
    private let lock = DispatchQueue(label: "com.MyApp.MyDataManager")
    
    
    // THREAD RACE SOLVED
    func getRandomData(completionHandler: @escaping (_ title: String?) -> ()) {
        lock.async {
            self.data.append(UUID().uuidString)
            print(Thread.current)
            completionHandler(self.data.randomElement())
        }
    }
    
    // THREAD RACE
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }

}

actor MyActorDataManager {
    
    static let instance = MyActorDataManager()
    private init() {    }
    
    var data: [String] = []
    
    func getRandomData() -> String? {
        self.data.append(UUID().uuidString)
        print(Thread.current)
        return self.data.randomElement()
    }
    
    nonisolated func getSavedData() -> String {
        return "NEW DATA"
    }
}


struct HomeView: View {
    
//    let manager = MyDataManager.instance // Class
    let manager = MyActorDataManager.instance // Actor

    @State private var text: String = ""
    let timer = Timer.publish(every: 0.1, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onAppear(perform: {
            let newData = manager.getSavedData()
            print(newData)
        })
        .onReceive(timer) { _ in
            
            // THREAD RACE SOLVED WITH ACTOR
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }
            
//            // THREAD RACE
//            DispatchQueue.global(qos: .background).async {
//                if let data = manager.getRandomData() {
//                    DispatchQueue.main.async {
//                        self.text = data
//                    }
//                }
//            }
            
//            // THREAD RACE SOLVED
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
            
            
        }
        
    }
    
}



struct BrowseView: View {
    
//    let manager = MyDataManager.instance // Class
    let manager = MyActorDataManager.instance // Actor

    @State private var text: String = ""
    let timer = Timer.publish(every: 0.01, tolerance: nil, on: .main, in: .common, options: nil).autoconnect()
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.8).ignoresSafeArea()
            
            Text(text)
                .font(.headline)
        }
        .onReceive(timer) { _ in
            
            // THREAD RACE SOLVED WITH ACTOR
            Task {
                if let data = await manager.getRandomData() {
                    await MainActor.run(body: {
                        self.text = data
                    })
                }
            }

//            // THREAD RACE
//            DispatchQueue.global(qos: .background).async {
//                if let data = manager.getRandomData() {
//                    DispatchQueue.main.async {
//                        self.text = data
//                    }
//                }
//            }
            
//            // THREAD RACE SOLVED
//            DispatchQueue.global(qos: .background).async {
//                manager.getRandomData { title in
//                    if let data = title {
//                        DispatchQueue.main.async {
//                            self.text = data
//                        }
//                    }
//                }
//            }
            
            
        }
        
    }
    
}


struct ActorsDemo: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "magnifyingglass")
                }
        }
    }
}

struct ActorsDemo_Previews: PreviewProvider {
    static var previews: some View {
        ActorsDemo()
    }
}

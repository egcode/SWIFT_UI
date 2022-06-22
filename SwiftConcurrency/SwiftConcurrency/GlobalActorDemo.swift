//
//  GlobalActorDemo.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 6/21/22.
//

import SwiftUI

@globalActor final class MyFirstGlobalActor {
    static var shared = MyNewDataManager()
}

actor MyNewDataManager {
    func getDataFromDatabase() -> [String] {
        return ["One", "Two", "Three", "Four", "Five"]
    }
}

class GlobalActorDemoViewModel: ObservableObject {
    @MainActor @Published var dataArray: [String] = []
    
    let manager = MyFirstGlobalActor.shared
    
//  nonisolated
    @MyFirstGlobalActor func getData() {
        
        /*
         This method is not marked as async, but is async because it's
         marked as @MyFirstGlobalActor - global actor method
         */
        
        // HEAVY COMPLEX METHODS
        
        Task {
            let data = await manager.getDataFromDatabase()
            await MainActor.run(body: {
                self.dataArray = data
            })
        }
    }
    
}



struct GlobalActorDemo: View {
    
    @StateObject private var viewModel = GlobalActorDemoViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.dataArray, id: \.self) {
                    Text($0)
                        .font(.headline)
                }
            }
        }
        .task {
            await viewModel.getData()
        }
    }
}

struct GlobalActorDemo_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActorDemo()
    }
}

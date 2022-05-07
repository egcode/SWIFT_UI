//
//  AsyncAwait.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 5/6/22.
//

import SwiftUI

class AsyncAwaitViewModel: ObservableObject {
    
    @Published var dataArray = [String]()
    
    func addBlah() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let blah1 = "Blah111 : \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(blah1)
            
            let blah2 = "Blah222 : \(Thread.current)"
            self.dataArray.append(blah2)
        })
    }
    
    func addSomething() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        let something1 = "Something1 : \(Thread.current)"
        await MainActor.run(body: {
            self.dataArray.append(something1)
            
            let something2 = "Something2 : \(Thread.current)"
            self.dataArray.append(something2)
        })
    }
}


struct AsyncAwait: View {
    
    @StateObject private var viewModel = AsyncAwaitViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }
        .onAppear {
            Task {
                await viewModel.addBlah()
                await viewModel.addSomething()
                
                let FINAL = "FINAL : \(Thread.current)"
                self.viewModel.dataArray.append(FINAL)
            }
        }
        
    }
}

struct AsyncAwait_Previews: PreviewProvider {
    static var previews: some View {
        AsyncAwait()
    }
}

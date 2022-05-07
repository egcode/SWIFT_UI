//
//  TaskDemo.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 5/6/22.
//

import SwiftUI

class TaskDataModel : ObservableObject {
    
    @Published var image: UIImage?
    
    func fetchImage() async {
        
        do {
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            
            //Check for cancelation
            // if View where task is running if no longer on the screen
            // we need to check if Task is canceled
//            try Task.checkCancellation() // Throws
            if Task.isCancelled {
                print("||||Task is already canceled||||")
            }
            
            
            let url = URL(string: "https://picsum.photos/1000")!
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
                print("IMAGE RETURNED SUCCESSFULLY")
            })
        } catch {
            print(error.localizedDescription)
        }
    }

}

struct TaskDemoHomeView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("CLICK Me!") {
                    TaskDemo()
                }
            }
        }
    }
    
}



struct TaskDemo: View {
    
    @StateObject private var viewModel = TaskDataModel()
    
    var body: some View {
        VStack (spacing: 40) {
            
            if let im = viewModel.image {
                Image(uiImage: im)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                ProgressView()
            }
            
        }
        .task {
            await viewModel.fetchImage() // Will cancel Task if view No longer visible
        }
//        .onDisappear {
//            fetchImageTask.cancel()
//        }
//        .onAppear {
//
//            // One after another
//            Task {
//                await viewModel.fetchImage()
//            }
//
//
////            Task(priority: .high) {
////                print("\(Task.currentPriority)  high : \(Thread.current)")
////            }
////            Task(priority: .userInitiated) {
////                print("\(Task.currentPriority)  userInitiated : \(Thread.current)")
////            }
////            Task(priority: .medium) {
////                print("\(Task.currentPriority)  medium : \(Thread.current)")
////            }
////            Task(priority: .low) {
////                print("\(Task.currentPriority)  low : \(Thread.current)")
////            }
////            Task(priority: .utility) {
////                print("\(Task.currentPriority)  utility : \(Thread.current)")
////            }
////            Task(priority: .background) {
////                print("\(Task.currentPriority)  background : \(Thread.current)")
////            }
//
//
////            Task(priority: .low) {
////                print("\(Task.currentPriority)  parent : \(Thread.current)")
////                Task {
////                    print("\(Task.currentPriority)  child : \(Thread.current)")
////                }
////                Task.detached { // Don't use detached as apple said
////                    print("\(Task.currentPriority)  child detached : \(Thread.current)")
////                }
////            }
//        }
        
        
    }
}

struct TaskDemo_Previews: PreviewProvider {
    static var previews: some View {
        TaskDemo()
    }
}

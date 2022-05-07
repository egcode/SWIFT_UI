//
//  TaskDemo2.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 5/6/22.
//

import SwiftUI

struct TaskDemo2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TaskDemo2_Previews: PreviewProvider {
    static var previews: some View {
        TaskDemo2()
    }
}


//import SwiftUI
//
//class TaskDataModel : ObservableObject {
//
//    @Published var image1: UIImage?
//    @Published var image2: UIImage?
//    let url = URL(string: "https://picsum.photos/1000")!
//
//    func fetchImage1() async {
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
//            await MainActor.run(body: {
//                self.image1 = UIImage(data: data)
//            })
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    func fetchImage2() async {
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
//            await MainActor.run(body: {
//                self.image2 = UIImage(data: data)
//            })
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//
//}
//
//struct TaskDemoHomeView: View {
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                NavigationLink("CLICK Me!") {
//                    TaskDemo()
//                }
//            }
//        }
//    }
//
//}
//
//
//
//struct TaskDemo: View {
//
//    @StateObject private var viewModel = TaskDataModel()
//
//    var body: some View {
//        VStack (spacing: 40) {
//
//            if let im = viewModel.image1 {
//                Image(uiImage: im)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//            }
//
//            if let im = viewModel.image2 {
//                Image(uiImage: im)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 200, height: 200)
//            }
//
//
//        }
//        .onAppear {
//
//            // One after another
//            Task {
//                await viewModel.fetchImage1()
//                await viewModel.fetchImage2()
//            }
//
//            // At the same time
//            Task {
//                await viewModel.fetchImage1()
//            }
//            Task {
//                await viewModel.fetchImage2()
//            }
//
//
//
//
//
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
//
//
//
//
//
//        }
//
//
//    }
//}
//
//struct TaskDemo_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDemo()
//    }
//}

//
//  TaskDemo2.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 5/6/22.
//

import SwiftUI

class Task2DataModel : ObservableObject {

    @Published var images = [UIImage]()

    func fetchImage() async {
        do {
            
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
                if let im = UIImage(data: data) {
                    self.images.append(im)
                }
            })
        } catch {
            print(error.localizedDescription)
        }
    }

}

struct Task2DemoHomeView: View {

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("CLICK Me!") {
                    TaskDemo2()
                }
            }
        }
    }

}



struct TaskDemo2: View {

    @StateObject private var viewModel = Task2DataModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
        .navigationTitle("Grid of images")
        .task {
//            await viewModel.fetchImage()
            
            // One after another
//            Task {
//                await viewModel.fetchImage()
//                await viewModel.fetchImage()
//                await viewModel.fetchImage()
//                await viewModel.fetchImage()
//                await viewModel.fetchImage()
//            }

//            // In Parallel
//            Task {
//                await viewModel.fetchImage()
//            }
//            Task {
//                await viewModel.fetchImage()
//            }
//            Task {
//                await viewModel.fetchImage()
//            }
//            Task {
//                await viewModel.fetchImage()
//            }
//            Task {
//                await viewModel.fetchImage()
//            }

            
//            // One after another
//            await withTaskGroup(of: Void.self, body: { group in
//                for _ in 0..<15 {
//                    await viewModel.fetchImage()
//                }
//            })

            // In Parellel
            await withTaskGroup(of: Void.self, body: { group in
                for _ in 0..<15 {
                    group.addTask {
                        await viewModel.fetchImage()
                    }
                }
            })
            
            
        }


    }
}

struct TaskDemo2_Previews: PreviewProvider {
    static var previews: some View {
        TaskDemo2()
    }
}

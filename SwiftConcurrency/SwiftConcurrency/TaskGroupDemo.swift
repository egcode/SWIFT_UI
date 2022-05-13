//
//  TaskGroupDemo.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 5/13/22.
//

import SwiftUI

class TaskGroupDemoDataManager {
    
//    func fetchImagesWithAsyncLet() async throws -> [UIImage] {
//        async let fetchImage1 = fetchImage(urlString: "https://picsum.photos/1000")
//        async let fetchImage2 = fetchImage(urlString: "https://picsum.photos/1000")
//        async let fetchImage3 = fetchImage(urlString: "https://picsum.photos/1000")
//        async let fetchImage4 = fetchImage(urlString: "https://picsum.photos/1000")
//
//        let (image1, image2, image3, image4) = await (try fetchImage1, try fetchImage2, try fetchImage3, try fetchImage4)
//        return [image1, image2, image3, image4]
//    }
    
    
    func fetchImagesWithTaskGroup() async throws -> [UIImage] {
        let urlStrings: [String] =
        [
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000",
            "https://picsum.photos/1000"
        ]
        
        return try await withThrowingTaskGroup(of: UIImage.self) { group in
            var images: [UIImage] = []
            images.reserveCapacity(urlStrings.count)
            
            for urlString in urlStrings {
                group.addTask(priority: .high) {
                    try await self.fetchImage(urlString: urlString)
                }
            }
            
            for try await img in group {
                images.append(img)
            }
            return images
        }
        

    }
    
    
    private func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            if let image = UIImage(data: data) {
                return image
            } else {
                throw URLError(.badURL)
            }
        } catch {
            throw error
        }
    }
    
}


class TaskGroupDemoDataModel: ObservableObject {
    
    @Published var images: [UIImage] = []
    
    let manager = TaskGroupDemoDataManager()
    
    func getImages() async {
//        if let images = try? await manager.fetchImagesWithAsyncLet() {
        if let images = try? await manager.fetchImagesWithTaskGroup() {
            self.images.append(contentsOf: images)
        }
    }
    
}


// MARK: - UI

struct TaskGroupHomeView: View {

    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink("Download Images!") {
                    TaskGroupDemo()
                }
            }
        }
    }

}


struct TaskGroupDemo: View {
    
    @StateObject private var viewModel = TaskGroupDemoDataModel()
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
            await viewModel.getImages()
        }
    }
}

struct TaskGroupDemo_Previews: PreviewProvider {
    static var previews: some View {
        TaskGroupDemo()
    }
}

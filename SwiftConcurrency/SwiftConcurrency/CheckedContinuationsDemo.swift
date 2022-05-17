//
//  CheckedContinuationsDemo.swift
//  SwiftConcurrency
//
//  Created by Eugene G on 5/17/22.
//

import SwiftUI

class CheckedContinuationsDemoNetworkManager {
    
    // MARK: - Example 1
    
    func getData(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
            return data
        } catch {
            throw error
        }
    }
    
    /// Converted `completion` typed function into async/await type
    func getData2(url: URL) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    continuation.resume(returning: data)
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: URLError(.badURL))
                }
            }
            .resume()
        }
    }
    
    // MARK: - Example 2
    
    func getHeartImageFromDataBase(completionHandler: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            completionHandler(UIImage(systemName: "heart.fill")!)
        }
    }
    
    /// Converting completion blocked function into async/await
    func getHeartImageFromDataBaseContinuation() async -> UIImage {
       await withCheckedContinuation { continuation in
            self.getHeartImageFromDataBase { img in
                if let im = img {
                    continuation.resume(returning: im)
                } else {
                    continuation.resume(returning: UIImage(systemName: "cross.fill")!)
                }
            }
        }
    }

}

class CheckedContinuationsDemoViewModel: ObservableObject {
    
    private let networkManager = CheckedContinuationsDemoNetworkManager()
    
    @Published var image: UIImage? = nil
    
    // MARK: - Example 1
    
    func getImage() async {
        guard let url = URL(string: "https://picsum.photos/1000") else { return }
        
        do {
//            let data = try await networkManager.getData(url: url) // Original async/await
            let data = try await networkManager.getData2(url: url)   // Converted `completion` into async/await
            if let image = UIImage(data: data) {
                await MainActor.run(body: {
                    self.image = image
                })
            }
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Example 2
    
//    func getHeartImageCompletion() {
//        networkManager.getHeartImageFromDataBase {[weak self] image in
//            self?.image=image
//        }
//    }
    
    func getHeartImage() async {
        self.image = await networkManager.getHeartImageFromDataBaseContinuation()
    }
}


struct CheckedContinuationsDemo: View {
    
    @StateObject private var viewModel = CheckedContinuationsDemoViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.getImage() // Example 1
//            await viewModel.getHeartImage() // Example 2
        }
    }
}

struct CheckedContinuationsDemo_Previews: PreviewProvider {
    static var previews: some View {
        CheckedContinuationsDemo()
    }
}

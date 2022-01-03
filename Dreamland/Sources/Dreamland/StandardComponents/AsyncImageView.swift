//
//  AsyncImageView.swift
//  Taro
//
//  Created by DevMountain on 12/13/20.
//

import SwiftUI
import Combine

class AsyncImageLoader: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published public private(set) var image: Image? = nil
    @Published public private(set) var loading = true

    func load(_ url: URL?) {
        guard let url = url else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .compactMap { data, _ in data }
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .failure(let reason):
                    print("❌  Failed to fetch image in AsyncImageLoader \n\(reason)")
                    self.loading = false
                case .finished:
                    self.loading = false
                }
            } receiveValue: { image in
                self.image = Image(uiImage: image)
            }
            .store(in: &cancellables)
    }
    
    func cancel() {
        cancellables.forEach { $0.cancel() }
    }
    
    deinit {
        cancel()
    }
}

public struct AsyncImageView: View {
    
    @StateObject var loader = AsyncImageLoader()
    
    var imageURLString: String
    var size: CGSize
    
    private let cornerRadius: CGFloat = 8
    
    public init(url: String, size: CGSize) {
        self.imageURLString = url
        self.size = size
    }
    
    public var body: some View {
        ZStack {
            loader.image?
                .resizable()
                .frame(width: size.width, height: size.height)
                .cornerRadius(cornerRadius)
            
            if loader.loading {
                CardShimmerView()
                    .frame(width: size.width, height: size.height)
            }
            
        }
        .frame(width: size.width, height: size.height)
        .onAppear(perform: {
            self.loader.load(URL(string: imageURLString))
        })
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: "https://www.sciencenewsforstudents.org/wp-content/uploads/2020/02/1030_glacier.png",
                       size: CGSize(width: 200, height: 200))
    }
}


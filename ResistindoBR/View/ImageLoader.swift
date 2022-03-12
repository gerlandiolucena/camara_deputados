//
//  ImageLoader.swift
//  ResistindoBR
//
//  Created by Gerlandio Lucena on 07/03/22.
//

import Foundation
import Combine
import UIKit

class ImageLoader: ObservableObject {
    private var subscription: AnyCancellable?
    
    @Published private(set) var image: UIImage?
    
    func load(url: URL) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10.0)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        subscription = session.dataTaskPublisher(for: request)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        subscription?.cancel()
    }
}

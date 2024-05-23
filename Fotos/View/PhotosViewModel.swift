//
//  PhotosViewModel.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation

class PhotosViewModel {
    enum Status {
        case loading
        case ready([Photo])
        case error(Error)
    }
    
    var onUpdate: ((Status) -> Void)?
    
    private let photosLoader: PhotosLoader
    
    init(photosLoader: PhotosLoader) {
        self.photosLoader = photosLoader
    }
    
    @MainActor
    func search(query: String, page: Int) {
        Task {
            do {
                let resultBooks = try await photosLoader.search(query: query, page: page, perPage: 10)
                onUpdate?(.ready(resultBooks.results))
            } catch {
                onUpdate?(.error(error))
            }
        }
    }
}

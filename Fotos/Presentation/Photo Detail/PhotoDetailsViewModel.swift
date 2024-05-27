//
//  PhotoDetailsViewModel.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import Foundation

class PhotoDetailsViewModel {
    private let photo: Photo
    
    init(model: Photo) {
        self.photo = model
    }
    
    var title: String {
        let title = photo.tags.map { $0.title }.joined(separator: " ")
        return String(format: PhotosLocalized.titleForCell, title)
    }
    
    var source: String {
        let source = photo.tags.map { $0.source?.title ?? "" }.joined(separator: " ")
        return String(format: PhotosLocalized.sourceForCell, source)
    }
    
    var takenBy: String {
        return String(format: PhotosLocalized.userForCell, photo.user.name)
    }
}

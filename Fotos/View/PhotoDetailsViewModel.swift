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
        let sourceTitle = photo.tags.map { $0.title }.joined(separator: " ")
        return "Title: \(sourceTitle)"
    }
    
    var source: String {
        let sourceTitle = photo.tags.map { $0.source?.title ?? "" }.joined(separator: " ")
        return "Source: \(sourceTitle)"
    }
    
    var takenBy: String {
        return "Taken By: \(photo.user.name)"
    }
}

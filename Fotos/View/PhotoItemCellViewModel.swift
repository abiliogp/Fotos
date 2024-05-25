//
//  PhotoItemCellModel.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
import UIKit

class PhotoItemCellViewModel {
    enum Status {
        case loading
        case ready(UIImage)
        case error(Error)
    }
    
    var onUpdate: ((Status) -> Void)?
    
    private let photo: Photo
    private let imageProcessor: ImageProcessor
    
    init(model: Photo, imageProcessor: ImageProcessor) {
        self.photo = model
        self.imageProcessor = imageProcessor
        self.onUpdate?(.loading)
    }
    
    func loading() {
        onUpdate?(.loading)
    }
    
    func loadImage() {
        guard let url = URL(string: photo.links.download) else {
            return
        }
        Task {
            guard let data = try? await imageProcessor.downsample(imageAt: url, to: CGSize(width: 300, height: 300)) else {
                onUpdate?(.error(RemotePhotosLoader.Error.invalidData))
                return
            }
            onUpdate?(.ready(data))
        }
    }
}

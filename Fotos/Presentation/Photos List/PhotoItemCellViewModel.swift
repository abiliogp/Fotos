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
        case ready(CGImage)
        case error(Error)
    }
    
    var onUpdate: ((Status) -> Void)?
    
    private var photo: Photo
    private let imageProcessor: ImageProcessor
    private var task: Task<Void, Error>?
    
    init(model: Photo, imageProcessor: ImageProcessor) {
        self.photo = model
        self.imageProcessor = imageProcessor
    }
    
    func loading() {
        onUpdate?(.loading)
    }
    
    func loadImage() {
        guard let url = URL(string: photo.links.download) else {
            onUpdate?(.error(RemotePhotosLoader.Error.invalidData))
            return
        }
        task = Task {
            guard Task.isCancelled == false else {
                onUpdate?(.loading)
                return
            }
            do {
                let data = try await imageProcessor.downsample(imageAt: url, to: CGSize(width: 300, height: 300))
                if (photo.links.download != url.absoluteString) {
                    onUpdate?(.loading)
                } else {
                    onUpdate?(.ready(data))
                }
            } catch {
                onUpdate?(.error(error))
            }
        }
    }
    
    func cancelLoadImage() {
        self.task?.cancel()
    }
    
    func update(model: Photo) {
        self.photo = model
    }
}

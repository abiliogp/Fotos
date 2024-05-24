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
    
    let photo: Photo
    
    init(model: Photo) {
        self.photo = model
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
            guard let data = downsample(imageAt: url, to: CGSize(width: 300, height: 300)) else {
                onUpdate?(.error(RemotePhotosLoader.Error.invalidData))
                return
            }
            onUpdate?(.ready(data))
        }
    }
    
    
    func downsample(imageAt imageURL: URL,
                    to pointSize: CGSize,
                    scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        
        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            return nil
        }
        
        // Calculate the desired dimension
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as [CFString : Any] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
}

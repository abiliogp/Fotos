//
//  ImageProcessor.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 24/05/2024.
//

import Foundation
import UIKit

protocol ImageProcessor {
    func downsample(imageAt imageURL: URL, to pointSize: CGSize) async throws -> UIImage
}

actor RemoteImageProcessor: ImageProcessor {
    
    enum Error: Swift.Error {
        case imageSourceCreationFailed
        case downsamplingFailed
    }
    
    private let scale: CGFloat
    
    init(scale: CGFloat) {
        self.scale = scale
    }
    
    func downsample(imageAt imageURL: URL, to pointSize: CGSize) async throws -> UIImage {
        
        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            throw Error.imageSourceCreationFailed
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
            throw Error.downsamplingFailed
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
}

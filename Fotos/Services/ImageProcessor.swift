//
//  ImageProcessor.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 24/05/2024.
//

import Foundation
import UIKit

protocol ImageProcessor {
    func downsample(imageAt imageURL: URL, to pointSize: CGSize) async throws -> CGImage
}

actor RemoteImageProcessor: ImageProcessor {
    enum Error: Swift.Error {
        case imageSourceCreationFailed
        case downsamplingFailed
    }
    
    private let scale: CGFloat
    private let imageCacheService: ImageCacheService
    
    init(scale: CGFloat, imageCacheService: ImageCacheService) {
        self.scale = scale
        self.imageCacheService = imageCacheService
    }
    
    func downsample(imageAt imageURL: URL, to pointSize: CGSize) async throws -> CGImage {
        if let image = imageCacheService.get(key: imageURL.absoluteString) {
            return image
        }
        
        let imageSource = try await createImageSource(from: imageURL)
        let downsampledImage = try await downsampleImage(imageSource: imageSource, to: pointSize)
        
        imageCacheService.store(key: imageURL.absoluteString, image: downsampledImage)
        
        return downsampledImage
    }
    
    private func createImageSource(from imageURL: URL) async throws -> CGImageSource {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            throw Error.imageSourceCreationFailed
        }
        return imageSource
    }
    
    private func downsampleImage(imageSource: CGImageSource, to pointSize: CGSize) async throws -> CGImage {
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            throw Error.downsamplingFailed
        }
        return downsampledImage
    }
}

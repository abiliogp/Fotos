//
//  Error+Localized.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import Foundation

extension RemotePhotosLoader.Error: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidData:
            PhotosLocalized.invalidDataError
        case .invalidURL:
            PhotosLocalized.invalidUrlError
        case .other:
            PhotosLocalized.genericError
        }
    }
}

extension RemoteImageProcessor.Error: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .imageSourceCreationFailed:
            PhotosLocalized.imageDataError
        case .downsamplingFailed:
            PhotosLocalized.imageDownsamplingError
        }
    }
}

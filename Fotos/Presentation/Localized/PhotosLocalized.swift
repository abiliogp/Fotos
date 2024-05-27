//
//  PhotosLocalized.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import Foundation

class PhotosLocalized {
    static var photosTitle: String {
        localizedString(forKey: "PHOTOS_LIST_TITLE", comment: "Title for Photos List")
    }
    
    static var start: String {
        localizedString(forKey: "PHOTOS_LIST_START", comment: "First string for start")
    }
    
    static var empty: String {
        localizedString(forKey: "PHOTOS_LIST_EMPTY", comment: "String when list empty")
    }
    
    static var placeholder: String {
        localizedString(forKey: "PHOTOS_LIST_SEARCH_PLACEHOLDER", comment: "Search placeholder")
    }
    
    static var titleForPhotoDetail: String {
        localizedString(forKey: "PHOTO_DETAIL_TITLE", comment: "Title for Photo Detail")
    }
    
    static var titleForCell: String {
        localizedString(forKey: "PHOTO_DETAIL_TEXT", comment: "Title for details photos")
    }
    
    static var sourceForCell: String {
        localizedString(forKey: "PHOTO_DETAIL_SOURCE", comment: "Source for details photos")
    }
    
    static var userForCell: String {
        localizedString(forKey: "PHOTO_DETAIL_USER", comment: "User for details photos")
    }
    
    static var invalidDataError: String {
        localizedString(forKey: "REMOTE_LOADER_DATA_ERROR", comment: "Invalid data error")
    }
    
    static var invalidUrlError: String {
        localizedString(forKey: "REMOTE_LOADER_URL_ERROR", comment: "Invalid url error")
    }
    
    static var genericError: String {
        localizedString(forKey: "GENERIC_ERROR", comment: "Generic error")
    }
    
    static var imageDataError: String {
        localizedString(forKey: "IMAGE_LOADER_DATA_ERROR", comment: "Image loader error")
    }
    
    static var imageDownsamplingError: String {
        localizedString(forKey: "IMAGE_LOADER_DOWNSAMPLING_ERROR", comment: "Image downsampling error")
    }
    
    private static func localizedString(forKey key: String, comment: String) -> String {
        NSLocalizedString(
            key,
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: comment
        )
    }
}

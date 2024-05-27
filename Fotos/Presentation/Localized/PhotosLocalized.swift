//
//  PhotosLocalized.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import Foundation

class PhotosLocalized {
    static var photosTitle: String {
        NSLocalizedString(
            "PHOTOS_LIST_TITLE",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Title for Photos List")
    }
    
    static var start: String {
        NSLocalizedString(
            "PHOTOS_LIST_START",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "First string for start")
    }
    
    static var empty: String {
        NSLocalizedString(
            "PHOTOS_LIST_EMPTY",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "String when list empty")
    }
    
    static var placeholder: String {
        NSLocalizedString(
            "PHOTOS_LIST_SEARCH_PLACEHOLDER",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Search placeholder")
    }
    
    static var titleForCell: String {
        NSLocalizedString(
            "PHOTO_DETAIL_TITLE",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Title for details photos")
    }
    
    static var sourceForCell: String {
        NSLocalizedString(
            "PHOTO_DETAIL_SOURCE",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Source for details photos")
    }
    
    static var userForCell: String {
        NSLocalizedString(
            "PHOTO_DETAIL_USER",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "User for details photos")
    }
    
    static var invalidDataError: String {
        NSLocalizedString(
            "REMOTE_LOADER_DATA_ERROR",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Invalid data error")
    }
    
    static var invalidUrlError: String {
        NSLocalizedString(
            "REMOTE_LOADER_URL_ERROR",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Invalid url error")
    }
    
    static var genericError: String {
        NSLocalizedString(
            "GENERIC_ERROR",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Generic error")
    }
    
    static var imageDataError: String {
        NSLocalizedString(
            "IMAGE_LOADER_DATA_ERROR",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Image loader error")
    }
    
    static var imageDownsamplingError: String {
        NSLocalizedString(
            "IMAGE_LOADER_DOWNSAMPLING_ERROR",
            tableName: "Photos",
            bundle: Bundle(for: PhotosLocalized.self),
            comment: "Image downsampling error")
    }
}

//
//  PhotosLocalizedTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import XCTest
@testable import Fotos

final class PhotosLocalizedTests: XCTestCase {
    
    func testLocalizedPhotosList() {
        XCTAssertEqual(PhotosLocalized.photosTitle, "Photos")
        XCTAssertEqual(PhotosLocalized.start, "Please enter a search term!")
        XCTAssertEqual(PhotosLocalized.empty, "No items found. Please try a different search.")
        XCTAssertEqual(PhotosLocalized.placeholder, "Search...")
        XCTAssertEqual(PhotosLocalized.titleForPhotoDetail, "Photo Detail")
        XCTAssertEqual(PhotosLocalized.listHint, "List")
        XCTAssertEqual(PhotosLocalized.listLabel, "A list of images for the given search")
        XCTAssertEqual(PhotosLocalized.listSearchHint, "Search")
        XCTAssertEqual(PhotosLocalized.listSearchLabel, "Enter your search here")
        XCTAssertEqual(PhotosLocalized.listTextHint, "Status text")
        XCTAssertEqual(PhotosLocalized.listTextLabel, "A text with the given status of photos list")
    }
    
    func testLocalizedPhotoDetail() {
        XCTAssertEqual(PhotosLocalized.titleForCell, "Title: %@")
        XCTAssertEqual(PhotosLocalized.sourceForCell, "Source: %@")
        XCTAssertEqual(PhotosLocalized.userForCell, "Taken by: %@")
        XCTAssertEqual(PhotosLocalized.detailTextHint, "Title Text")
        XCTAssertEqual(PhotosLocalized.detailTextLabel, "A text with the given title of image")
        XCTAssertEqual(PhotosLocalized.detailSourceHint, "Source Text")
        XCTAssertEqual(PhotosLocalized.detailSourceLabel, "A text with the given source of image")
        XCTAssertEqual(PhotosLocalized.detailUserHint, "Taken by")
        XCTAssertEqual(PhotosLocalized.detailUserLabel, "A text with the given author of image")
    }
    
    func testLocalizedError() {
        XCTAssertEqual(PhotosLocalized.invalidDataError, "Invalid data. Please try again later.")
        XCTAssertEqual(PhotosLocalized.invalidUrlError, "Invalid URL. Please try again later.")
        XCTAssertEqual(PhotosLocalized.genericError, "Unable to connect to the server.")
        XCTAssertEqual(PhotosLocalized.imageDataError, "Please check your connection. Unable to create the image from the source.")
        XCTAssertEqual(PhotosLocalized.imageDownsamplingError, "Please check your connection. Unable to load the image.")
    }
}

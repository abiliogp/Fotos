//
//  PhotosLocalizedTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import XCTest
@testable import Fotos

final class PhotosLocalizedTests: XCTestCase {
    
    func testPhotosTitle() {
        XCTAssertEqual(PhotosLocalized.photosTitle, "Photos")
    }
    
    func testStart() {
        XCTAssertEqual(PhotosLocalized.start, "Please enter a search term!")
    }
    
    func testEmpty() {
        XCTAssertEqual(PhotosLocalized.empty, "No items found. Please try a different search.")
    }
    
    func testPlaceholder() {
        XCTAssertEqual(PhotosLocalized.placeholder, "Search...")
    }
    
    func testTitleForPhotoDetail() {
        XCTAssertEqual(PhotosLocalized.titleForPhotoDetail, "Photo Detail")
    }
    
    func testTitleForCell() {
        XCTAssertEqual(PhotosLocalized.titleForCell, "Title: %@")
    }
    
    func testSourceForCell() {
        XCTAssertEqual(PhotosLocalized.sourceForCell, "Source: %@")
    }
    
    func testUserForCell() {
        XCTAssertEqual(PhotosLocalized.userForCell, "Taken by: %@")
    }
    
    func testInvalidDataError() {
        XCTAssertEqual(PhotosLocalized.invalidDataError, "Invalid data. Please try again later.")
    }
    
    func testInvalidUrlError() {
        XCTAssertEqual(PhotosLocalized.invalidUrlError, "Invalid URL. Please try again later.")
    }
    
    func testGenericError() {
        XCTAssertEqual(PhotosLocalized.genericError, "Unable to connect to the server.")
    }
    
    func testImageDataError() {
        XCTAssertEqual(PhotosLocalized.imageDataError, "Please check your connection. Unable to create the image from the source.")
    }
    
    func testImageDownsamplingError() {
        XCTAssertEqual(PhotosLocalized.imageDownsamplingError, "Please check your connection. Unable to load the image.")
    }
    
}

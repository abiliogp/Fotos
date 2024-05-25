//
//  PhotoItemCellViewModelTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import XCTest
@testable import Fotos

final class PhotoItemCellViewModelTests: XCTestCase {
    
    func testLoadingStatus() {
        let photo = ListPhotos.make().result.results.first!
        let imageProcessor = MockImageProcessor()
        let viewModel = PhotoItemCellViewModel(model: photo, imageProcessor: imageProcessor)
        
        let expectation = expectation(description: "onUpdate called")
        
        viewModel.onUpdate = { status in
            if case .loading = status {
                expectation.fulfill()
            }
        }
        
        viewModel.loading()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoadImageSuccess() {
        let photo = ListPhotos.make().result.results.first!
        let image = UIImage(systemName: "photo")! // Use a system image for testing
        let imageProcessor = MockImageProcessor(image: image)
        let viewModel = PhotoItemCellViewModel(model: photo, imageProcessor: imageProcessor)
        
        let expectation = expectation(description: "onUpdate called with ready status")
        
        viewModel.onUpdate = { status in
            if case .ready(let receivedImage) = status {
                XCTAssertEqual(receivedImage, image)
                expectation.fulfill()
            }
        }
        
        viewModel.loadImage()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testLoadImageError() {
        let photo = ListPhotos.make().result.results.first!
        let imageProcessor = MockImageProcessor(shouldFail: true)
        let viewModel = PhotoItemCellViewModel(model: photo, imageProcessor: imageProcessor)
        
        let expectation = expectation(description: "onUpdate called with error status")
        
        viewModel.onUpdate = { status in
            if case .error(let error) = status {
                XCTAssertEqual(error as? RemotePhotosLoader.Error, RemotePhotosLoader.Error.invalidData)
                expectation.fulfill()
            }
        }
        
        viewModel.loadImage()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
}

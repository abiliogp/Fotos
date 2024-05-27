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
        
        expect(viewModel, expectedResult: .loading) {
            viewModel.loading()
        }
    }
    
    func testLoadImageSuccess() {
        let photo = ListPhotos.make().result.results.first!
        let image = CGImage.make()
        let imageProcessor = MockImageProcessor(image: image)
        let viewModel = PhotoItemCellViewModel(model: photo, imageProcessor: imageProcessor)
        
        expect(viewModel, expectedResult: .ready(image)) {
            viewModel.loadImage()
        }
    }
    
    func testLoadImageError() {
        let photo = ListPhotos.make().result.results.first!
        let imageProcessor = MockImageProcessor(shouldFail: true)
        let viewModel = PhotoItemCellViewModel(model: photo, imageProcessor: imageProcessor)
        
        expect(viewModel, expectedResult: .error(NSError())) {
            viewModel.loadImage()
        }
    }
    
    func testLoadImageErrorWhenURLNotValid() {
        var photo = ListPhotos.make().result.results.first!
        photo.links.download = ""
        let imageProcessor = MockImageProcessor()
        let viewModel = PhotoItemCellViewModel(model: photo, imageProcessor: imageProcessor)
        
        expect(viewModel, expectedResult: .error(NSError())) {
            viewModel.loadImage()
        }
    }
}

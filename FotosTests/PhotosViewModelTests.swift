//
//  PhotosViewModelTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 26/05/2024.
//

import XCTest
@testable import Fotos

final class PhotosViewModelTests: XCTestCase {
    
    func testStartStatusWhenStart() {
        let result = ListPhotos.make()
        let remotePhotoLoader = makeSUT(data: result.data)
        let viewModel = PhotosViewModel(photosLoader: remotePhotoLoader)
        
        expect(viewModel, expectedResult: .start) {
            viewModel.start()
        }
    }
    
    func testErrorStatusWhenDataInvalid() {
        let remotePhotoLoader = makeSUT(data: Data("invalid json".utf8))
        let viewModel = PhotosViewModel(photosLoader: remotePhotoLoader)
        
        expect(viewModel, expectedResult: .error(NSError())) {
            viewModel.load()
        }
    }
    
    func testUpdatePageWhenLoadCalled() {
        let result = ListPhotos.make()
        let remotePhotoLoader = makeSUT(data: result.data)
        let viewModel = PhotosViewModel(photosLoader: remotePhotoLoader)
        
        expect(viewModel, expectedResult: .ready(.none)) {
            viewModel.search(query: "123")
        }
        
        expect(viewModel, expectedResult: .ready(.none)) {
            viewModel.load()
        }
        
        XCTAssertEqual(viewModel.currentQuery, "123")
        XCTAssertEqual(viewModel.currentPage, 1)
    }
    
    func testUpdateCleanPageWhenSearchChanges() {
        let result = ListPhotos.make()
        let remotePhotoLoader = makeSUT(data: result.data)
        let viewModel = PhotosViewModel(photosLoader: remotePhotoLoader)
        
        expect(viewModel, expectedResult: .ready(.none)) {
            viewModel.search(query: "first search")
        }
        
        XCTAssertEqual(viewModel.currentQuery, "first search")
        
        expect(viewModel, expectedResult: .ready(.none)) {
            viewModel.search(query: "another search")
        }
        
        XCTAssertEqual(viewModel.currentQuery, "another search")
    }
    
    func testOpenViewCell() {
        let result = ListPhotos.make()
        let remotePhotoLoader = makeSUT(data: result.data)
        let viewModel = PhotosViewModel(photosLoader: remotePhotoLoader)
        let spyCoordinatorDelegate = SpyPhotosCoordinatorDelegate()
        
        waitForAction(viewModel) {
            viewModel.search(query: "123")
            let mockPhoto = result.result.results.first
            
            viewModel.openViewCell(for: 0)
            
            XCTAssertEqual(spyCoordinatorDelegate.openViewCellCallCount, 1)
            XCTAssertEqual(spyCoordinatorDelegate.openViewCellArguments.first, mockPhoto)
        }
    }
    
    func testUpdateCell() {
        let result = ListPhotos.make()
        let remotePhotoLoader = makeSUT(data: result.data)
        let viewModel = PhotosViewModel(photosLoader: remotePhotoLoader)
        let spyCoordinatorDelegate = SpyPhotosCoordinatorDelegate()
        
        waitForAction(viewModel) {
            let mockPhoto = result.result.results.first!
            
            let viewModelCell = PhotoItemCellViewModel(model: mockPhoto, imageProcessor: MockImageProcessor())
            
            viewModel.updateCell(for: 0, viewModel: viewModelCell)
            
            XCTAssertEqual(spyCoordinatorDelegate.updateCellCallCount, 1)
            XCTAssertEqual(spyCoordinatorDelegate.updateCellArguments.first?.0, mockPhoto)
        }
    }
}

//
//  PhotoDetailsViewModelTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import XCTest
@testable import Fotos

final class PhotoDetailsViewModelTests: XCTestCase {
    func testViewModelProperties() throws {
        let result = ListPhotos.make()

        let photo = result.result.results.first!
        let viewModel = PhotoDetailsViewModel(model: photo)
        
        XCTAssertEqual(viewModel.title, "Title: phone apple orchard road singapore")
        XCTAssertEqual(viewModel.source, "Source: Hd phone wallpapers  ")
        XCTAssertEqual(viewModel.takenBy, "Taken by: John Doe")
    }
}

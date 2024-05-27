//
//  LocalizedErrorTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 27/05/2024.
//

import XCTest
@testable import Fotos

final class LocalizedErrorTests: XCTestCase {
    func testLocalizedErrorForRemotePhotosLoader() throws {
        XCTAssertEqual(RemotePhotosLoader.Error.invalidData.localizedDescription, "Invalid data. Please try again later.")
        XCTAssertEqual(RemotePhotosLoader.Error.invalidURL.localizedDescription, "Invalid URL. Please try again later.")
        XCTAssertEqual(RemotePhotosLoader.Error.other.localizedDescription, "Unable to connect to the server.")
    }
    
    func testLocalizedErrorForRemoteImageProcessor() throws {
        XCTAssertEqual(RemoteImageProcessor.Error.imageSourceCreationFailed.localizedDescription, "Please check your connection. Unable to create the image from the source.")
        XCTAssertEqual(RemoteImageProcessor.Error.downsamplingFailed.localizedDescription, "Please check your connection. Unable to load the image.")
    }
}

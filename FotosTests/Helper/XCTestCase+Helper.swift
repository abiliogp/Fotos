//
//  XCTestCase+Helper.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import XCTest
@testable import Fotos

extension XCTest {
    func makeSUT(data: Data) -> RemotePhotosLoader {
        let result = HTTPResult(error: nil, data: data)
        let client = MockHTTPClient(result: result)
        return RemotePhotosLoader(client: client)
    }
}

// MARK: - PhotosViewModel
extension XCTest {
    func expect(_ viewModel: PhotosViewModel,
                expectedResult: PhotosViewModel.Status,
                action: @escaping () -> Void,
                file: StaticString = #filePath, line: UInt = #line
    ) {
        viewModel.onUpdate = { status in
            XCTAssertEqual(status, expectedResult, file: file, line: line)
        }
        action()
    }
    
    func waitForAction(_ viewModel: PhotosViewModel,
                       action: @escaping () -> Void
    ) {
        viewModel.onUpdate = { _ in
            action()
        }
    }
}

extension PhotosViewModel.Status: Equatable {
    public static func == (lhs: Fotos.PhotosViewModel.Status, rhs: Fotos.PhotosViewModel.Status) -> Bool {
        switch (lhs, rhs) {
        case (.start, .start),
            (.empty, .empty),
            (.loading, .loading),
            (.ready, .ready),
            (.error, .error):
            return true
        default:
            return false
        }
    }
}

// MARK: - PhotoItemCellViewModel
extension XCTest {
    func expect(_ viewModel: PhotoItemCellViewModel,
                expectedResult: PhotoItemCellViewModel.Status,
                action: @escaping () -> Void,
                file: StaticString = #filePath, line: UInt = #line
    ) {
        viewModel.onUpdate = { status in
            XCTAssertEqual(status, expectedResult, file: file, line: line)
        }
        action()
    }
}

extension PhotoItemCellViewModel.Status: Equatable {
    public static func == (lhs: Fotos.PhotoItemCellViewModel.Status, rhs: Fotos.PhotoItemCellViewModel.Status) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
            (.ready, .ready),
            (.error, .error):
            return true
        default:
            return false
        }
    }
}

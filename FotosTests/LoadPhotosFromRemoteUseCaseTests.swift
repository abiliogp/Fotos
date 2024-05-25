//
//  LoadPhotosFromRemoteUseCaseTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import XCTest
@testable import Fotos

final class LoadPhotosFromRemoteUseCaseTests: XCTestCase {

    func testSearchThrowsWithInvalidJSON() async {
        let invalidJSON = Data("invalid json".utf8)
        let sut = makeSUT(data: invalidJSON)
        
        expect(sut, expectedError: .invalidData)
    }
    
    func testSearchSuccess() async {
        let result = ListPhotos.make()
        let sut = makeSUT(data: result.data)
        
        expect(sut, expectedResult: result.result)
    }
}

private extension LoadPhotosFromRemoteUseCaseTests {
    func expect(_ sut: RemotePhotosLoader,
                expectedResult: ListPhotos? = nil,
                expectedError: RemotePhotosLoader.Error? = nil,
                file: StaticString = #filePath, line: UInt = #line
    ) {
        Task {
            do {
                let result = try await sut.search(query: "iphone", page: 0)
                XCTAssertEqual(result, expectedResult, file: file, line: line)
            } catch {
                XCTAssertEqual(error.localizedDescription, expectedError?.localizedDescription, file: file, line: line)
            }
        }
    }
}

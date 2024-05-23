//
//  LoadPhotosFromRemoteUseCaseTests.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import XCTest
@testable import Fotos

final class LoadPhotosFromRemoteUseCaseTests: XCTestCase {

    func test_search_throwsWithInvalidJSON() async {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: HTTPResult(error: RemotePhotosLoader.Error.invalidData, data: nil)) {
            let invalidJSON = Data("invalid json".utf8)
            client.result?.data = invalidJSON
        }
    }
    
    func test_search_success() async {
        let (sut, client) = makeSUT()
        let result = ListPhotos.make()
        
        expect(sut, toCompleteWith: HTTPResult(error: nil, data: result.data)) {
            client.result?.data = result.data
        }
    }
}

private extension LoadPhotosFromRemoteUseCaseTests {
    func expect(_ sut: RemotePhotosLoader, toCompleteWith: HTTPResult, action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        Task {
            do {
                let result = try await sut.search(query: "iphone", page: 0)
                XCTAssertNotNil(result, file: file, line: line)
            } catch {
                XCTAssertEqual(error.localizedDescription, RemotePhotosLoader.Error.invalidData.localizedDescription, file: file, line: line)
            }
        }
        action()
    }
}

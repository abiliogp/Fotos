//
//  XCTestCase+Helper.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import XCTest
@testable import Fotos

extension XCTest {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: RemotePhotosLoader, client: MockHTTPClient) {
        let client = MockHTTPClient()
        let sut = RemotePhotosLoader(client: client)
        return (sut, client)
    }
}

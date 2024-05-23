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

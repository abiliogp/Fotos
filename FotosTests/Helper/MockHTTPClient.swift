//
//  MockHTTPClient.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
@testable import Fotos

struct HTTPResult {
    var error: Error?
    var data: Data?
}

class MockHTTPClient: HTTPClient {
    let result: HTTPResult
    
    init(result: HTTPResult) {
        self.result = result
    }

    func get(from url: URL) async throws -> Data {
        guard let responseData = result.data else {
            throw result.error ?? RemotePhotosLoader.Error.other
        }
        return responseData
    }
}

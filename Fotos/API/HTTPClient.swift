//
//  HTTPClient.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL) async throws -> Data
}

class RemoteHTTPClient: HTTPClient {
    func get(from url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

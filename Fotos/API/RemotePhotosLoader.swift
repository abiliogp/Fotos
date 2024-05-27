//
//  RemotePhotosLoader.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation

public protocol PhotosLoader {
    func search(query: String, page: Int, perPage: Int) async throws -> ListPhotos
}

public final class RemotePhotosLoader: PhotosLoader {
    public enum Error: Swift.Error {
        case invalidData
        case invalidURL
        case other
    }

    private enum QueryParameter: String {
        case query = "query"
        case clientId = "client_id"
        case page = "page"
        case perPage = "per_page"
    }
    
    private let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func search(query: String, page: Int, perPage: Int = 10) async throws -> ListPhotos {
        guard var url = URL(string: Environment.getValue(for: .endpoint)) else {
            throw Error.invalidURL
        }
        let queryItems = [
            URLQueryItem(name: QueryParameter.query.rawValue, value: query),
            URLQueryItem(name: QueryParameter.clientId.rawValue, value: Environment.getValue(for: .apiID)),
            URLQueryItem(name: QueryParameter.page.rawValue, value: String(page)),
            URLQueryItem(name: QueryParameter.perPage.rawValue, value: String(perPage))
        ]
        url.append(queryItems: queryItems)
        let data = try await client.get(from: url)
        return try await PhotosMapper.map(data)
    }
}

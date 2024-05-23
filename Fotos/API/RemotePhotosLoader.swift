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
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case invalidData
        case invalidURL
        case other
    }
    
    private let clientId = "NHr5nmnvy4fJA0AtfpReQm_EI2SBnnvPajDObRtmYbY"
    private enum Endpoint: String {
        case search = "https://api.unsplash.com/search/photos"
    }

    private enum QueryParameter: String {
        case query = "query"
        case clientId = "client_id"
        case page = "page"
        case perPage = "per_page"
    }
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    public func search(query: String, page: Int, perPage: Int = 10) async throws -> ListPhotos {
        guard var url = URL(string: Endpoint.search.rawValue) else {
            throw Error.invalidURL
        }
        let queryItems = [
            URLQueryItem(name: QueryParameter.query.rawValue, value: query),
            URLQueryItem(name: QueryParameter.clientId.rawValue, value: clientId),
            URLQueryItem(name: QueryParameter.page.rawValue, value: String(page)),
            URLQueryItem(name: QueryParameter.perPage.rawValue, value: String(perPage))
        ]
        url.append(queryItems: queryItems)
        let data = try await client.get(from: url)
        return try await PhotosMapper.map(data)
    }
}

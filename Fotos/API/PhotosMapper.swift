//
//  PhotosMapper.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation

enum PhotosMapper {
    static func map(_ data: Data) async throws -> ListPhotos {
        guard let books = try? JSONDecoder().decode(ListPhotos.self, from: data) else {
             throw RemotePhotosLoader.Error.invalidData
        }

        return books
    }
}

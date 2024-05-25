//
//  Photos.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation

// MARK: - ListPhotos
public struct ListPhotos: Codable {
    let total: Int
    let totalPages: Int
    let results: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Photo
public struct Photo: Codable {
    let id: String
    let slug: String
    let width: Int
    let height: Int
    let description: String?
    let urls: PhotoUrls
    let links: ResultLinks
    let tags: [Tag]
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case width
        case height
        case description
        case urls
        case links
        case tags
        case user
    }
}

// MARK: - ResultLinks
public struct ResultLinks: Codable {
    let linksSelf: String
    let html: String
    let download: String
    let downloadLocation: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html
        case download
        case downloadLocation = "download_location"
    }
}

// MARK: - Tag
public struct Tag: Codable {
    let title: String
    let source: Source?
}

// MARK: - Source
public struct Source: Codable {
    let title: String
    let subtitle: String
    let description: String
    let metaTitle: String
    let metaDescription: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case description
        case metaTitle = "meta_title"
        case metaDescription = "meta_description"
    }
}

// MARK: - Urls
public struct PhotoUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - User
struct User: Codable {
    let username: String
    let name: String
    let firstName: String
    let lastName: String?
    let bio: String?
    let location: String?

    enum CodingKeys: String, CodingKey {
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
        case location
    }
}

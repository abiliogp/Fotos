//
//  ListPhotos+Maker.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
@testable import Fotos

extension ListPhotos {
    static func make() -> (data: Data, result: ListPhotos) {
        let listPhotos = ListPhotos(
            total: 10000,
            totalPages: 10000,
            results: [
                Photo(
                    id: "A6JxK37IlPo",
                    slug: "person-holding-space-gray-iphone-7-A6JxK37IlPo",
                    width: 6000,
                    height: 4000,
                    description: "I get a rare opportunity to try the iPhone X purchased directly from Apple Orchard. My friend stayed 2 nights in front of the Apple Store to be the first iPhone X user list in Singapore.",
                    urls: PhotoUrls(
                        raw: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA&ixlib=rb-4.0.3",
                        full: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?crop=entropy&cs=srgb&fm=jpg&ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA&ixlib=rb-4.0.3&q=85",
                        regular: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA&ixlib=rb-4.0.3&q=80&w=1080",
                        small: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA&ixlib=rb-4.0.3&q=80&w=400",
                        thumb: "https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA&ixlib=rb-4.0.3&q=80&w=200",
                        smallS3: "https://s3.us-west-2.amazonaws.com/images.unsplash.com/small/photo-1510557880182-3d4d3cba35a5"
                    ),
                    links: ResultLinks(
                        linksSelf: "https://api.unsplash.com/photos/person-holding-space-gray-iphone-7-A6JxK37IlPo",
                        html: "https://unsplash.com/photos/person-holding-space-gray-iphone-7-A6JxK37IlPo",
                        download: "https://unsplash.com/photos/A6JxK37IlPo/download?ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA",
                        downloadLocation: "https://api.unsplash.com/photos/A6JxK37IlPo/download?ixid=M3wzOTIyODV8MHwxfHNlYXJjaHwxfHxpcGhvbmV8ZW58MHx8fHwxNzE2NDU4MzQzfDA"
                    ),
                    tags: [
                        Tag(
                            title: "phone",
                            source: Source(
                                title: "Hd phone wallpapers",
                                subtitle: "Download free phone wallpapers",
                                description: "Take your phone style to the next level with gorgeous phone wallpapers from Unsplash. Our community of professional photographers have contributed thousands of beautiful images, and all of them can be downloaded for free.",
                                metaTitle: "Phone Wallpapers: Free HD Download [500+ HQ] | Unsplash",
                                metaDescription: "Choose from hundreds of free phone wallpapers. Download HD wallpapers for free on Unsplash."
                            )
                        ),
                        Tag(
                            title: "apple orchard road",
                            source: nil
                        ),
                        Tag(
                            title: "singapore",
                            source: nil
                        )
                    ], 
                    user:
                        User(
                            username: "johndoe",
                            name: "John Doe",
                            firstName: "John",
                            lastName: "Doe",
                            bio: "Software Developer",
                            location: "San Francisco, CA"
                        )
                )
            ]
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(listPhotos)
        
        return (data, listPhotos)
    }
}

// - MARK: Equatable
extension ListPhotos: Equatable {
    public static func == (lhs: ListPhotos, rhs: ListPhotos) -> Bool {
        return lhs.total == rhs.total &&
               lhs.totalPages == rhs.totalPages &&
               lhs.results == rhs.results
    }
}

extension Photo: Equatable {
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id &&
               lhs.slug == rhs.slug &&
               lhs.width == rhs.width &&
               lhs.height == rhs.height &&
               lhs.description == rhs.description
    }
}

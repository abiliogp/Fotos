//
//  MockImageProcessor.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import Foundation
import UIKit
@testable import Fotos

class MockImageProcessor: ImageProcessor {
    private let image: CGImage?
    private let shouldFail: Bool
    
    init(image: CGImage? = nil, shouldFail: Bool = false) {
        self.image = image
        self.shouldFail = shouldFail
    }
    
    func downsample(imageAt url: URL, to size: CGSize) async throws -> CGImage {
        if shouldFail {
            throw RemotePhotosLoader.Error.invalidData
        }
        return image ?? CGImage.make()
    }
}

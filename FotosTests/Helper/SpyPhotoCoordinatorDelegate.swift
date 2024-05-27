//
//  SpyPhotoCoordinatorDelegate.swift
//  FotosTests
//
//  Created by Abilio Gambim Parada on 26/05/2024.
//

import Foundation
@testable import Fotos

class SpyPhotosCoordinatorDelegate: PhotosCoordinatorDelegate {
    var configureCellCallCount = 0
    var configureCellArguments: [Photo] = []

    var openViewCellCallCount = 0
    var openViewCellArguments: [Photo] = []

    var updateCellCallCount = 0
    var updateCellArguments: [(Photo, PhotoItemCellViewModel)] = []

    func configureCell(model: Fotos.Photo) -> Fotos.PhotoItemCellViewModel {
        configureCellCallCount += 1
        configureCellArguments.append(model)
        return PhotoItemCellViewModel(model: model, imageProcessor: MockImageProcessor())
    }
    
    func openViewCell(model: Photo) {
        openViewCellCallCount += 1
        openViewCellArguments.append(model)
    }
    
    func updateCell(model: Photo, viewModel: PhotoItemCellViewModel) {
        updateCellCallCount += 1
        updateCellArguments.append((model, viewModel))
    }
}

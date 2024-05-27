//
//  PhotoCoordinator.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootController: UINavigationController { get }

    func start()
}

protocol PhotosCoordinatorDelegate: AnyObject {
    func configureCell(model: Photo) -> PhotoItemCellViewModel
    func updateCell(model: Photo, viewModel: PhotoItemCellViewModel)
    func openViewCell(model: Photo)
}

class PhotosCoordinator: Coordinator {
    let rootController: UINavigationController

    let remotePhotosLoader: RemotePhotosLoader
    let imageCacheService: ImageCacheService

    init(window: UIWindow?) {
        self.rootController = UINavigationController()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        self.remotePhotosLoader = RemotePhotosLoader(client: RemoteHTTPClient())
        self.imageCacheService = LocalImageCacheService()
    }
    
    func start() {
        let viewModel = PhotosViewModel(photosLoader: remotePhotosLoader)
        viewModel.coordinatorDelegate = self
        rootController.setViewControllers([PhotosViewController(viewModel: viewModel)], animated: true)
    }
}

extension PhotosCoordinator: PhotosCoordinatorDelegate {
    func configureCell(model: Photo) -> PhotoItemCellViewModel {
        let imageProcessor = RemoteImageProcessor(scale: UIScreen.main.scale, imageCacheService: imageCacheService)
        return PhotoItemCellViewModel(model: model, imageProcessor: imageProcessor)
    }
    
    func updateCell(model: Photo, viewModel: PhotoItemCellViewModel) {
        viewModel.cancelLoadImage()
        viewModel.update(model: model)
    }
    
    func openViewCell(model: Photo) {
        let viewModel = PhotoDetailsViewModel(model: model)
        let viewController = PhotoDetailsViewController(viewModel: viewModel)
        rootController.pushViewController(viewController, animated: true)
    }
}

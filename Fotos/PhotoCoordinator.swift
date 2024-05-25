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

protocol PhotoCoordinatorDelegate: AnyObject {
    func configureCell(model: Photo) -> PhotoItemCellViewModel
    func openViewCell(model: Photo)
}

class PhotoCoordinator: Coordinator {
    let rootController: UINavigationController

    let remotePhotosLoader: RemotePhotosLoader
    let imageProcessor: ImageProcessor

    init(window: UIWindow?) {
        self.rootController = UINavigationController()
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        self.remotePhotosLoader = RemotePhotosLoader(client: RemoteHTTPClient())
        self.imageProcessor = RemoteImageProcessor(scale: window?.screen.scale ?? UIScreen.main.scale)
    }
    
    func start() {
        let viewModel = PhotosViewModel(photosLoader: remotePhotosLoader)
        viewModel.coordinatorDelegate = self
        rootController.setViewControllers([PhotosViewController(viewModel: viewModel)], animated: true)
    }
}

extension PhotoCoordinator: PhotoCoordinatorDelegate {
    func configureCell(model: Photo) -> PhotoItemCellViewModel {
        return PhotoItemCellViewModel(model: model, imageProcessor: imageProcessor)
    }
    
    func openViewCell(model: Photo) {
        let viewModel = PhotoDetailsViewModel(model: model)
        let viewController = PhotoDetailsViewController(viewModel: viewModel)
        rootController.pushViewController(viewController, animated: true)
    }
}

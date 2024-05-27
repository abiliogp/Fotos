//
//  PhotosViewModel.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation

class PhotosViewModel {
    enum Status {
        case start
        case empty
        case loading
        case ready([IndexPath]?)
        case error(Error)
    }
    
    var onUpdate: ((Status) -> Void)?
    weak var coordinatorDelegate: PhotosCoordinatorDelegate?

    private let photosLoader: PhotosLoader
    private var photos = [Photo]()
    
    private(set) var currentPage = 1
    private(set) var total = 0
    private(set) var currentQuery = ""
    private(set) var isNewDataLoading = false
    
    init(photosLoader: PhotosLoader) {
        self.photosLoader = photosLoader
    }
    
    func start() {
        onUpdate?(.start)
    }
    
    private func clear() {
        currentPage = 1
        total = 0
        currentQuery = ""
        photos.removeAll()
        isNewDataLoading = false
        onUpdate?(.ready(.none))
    }
    
    func search(query: String) {
        guard currentQuery != query else { return }
        clear()
        currentQuery = query
        load()
    }
    
    func load() {
        guard isNewDataLoading == false else {
            return
        }
        isNewDataLoading = true
        
        Task {
            do {
                let resultPhotos = try await photosLoader.search(query: currentQuery, page: currentPage, perPage: 10)
                
                guard resultPhotos.total != 0 else {
                    onUpdate?(.empty)
                    return
                }
                
                photos.append(contentsOf: resultPhotos.results)
                total = photos.count
                
                if currentPage > 1 {
                    let indexPhats = indexPathsToReload(from: resultPhotos.results)
                    onUpdate?(.ready(indexPhats))
                } else {
                    onUpdate?(.ready(.none))
                }
                currentPage += 1
            } catch {
                onUpdate?(.error(error))
            }
        }
        isNewDataLoading = false
    }
    
    func configureCell(for row: Int) -> PhotoItemCellViewModel? {
        guard row < photos.count else { return .none }
        let photo = photos[row]
        return coordinatorDelegate?.configureCell(model: photo)
    }
    
    func openViewCell(for row: Int) {
        guard row < photos.count else { return }
        let photo = photos[row]
        coordinatorDelegate?.openViewCell(model: photo)
    }
    
    func updateCell(for row: Int, viewModel: PhotoItemCellViewModel) {
        guard row < photos.count else { return }
        let photo = photos[row]
        coordinatorDelegate?.updateCell(model: photo, viewModel: viewModel)
    }

    private func indexPathsToReload(from newPhotos: [Photo]) -> [IndexPath] {
        let startIndex = photos.count - newPhotos.count
        let endIndex = startIndex + newPhotos.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

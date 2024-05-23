//
//  PhotoItemCellModel.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation


class PhotoItemCellViewModel {
    enum Status {
        case loading
        case ready
        case error(Error)
    }
    
    var onUpdate: ((Status) -> Void)?
    
    let photo: Photo
    
    init(model: Photo) {
        self.photo = model
        self.onUpdate?(.loading)
    }
}

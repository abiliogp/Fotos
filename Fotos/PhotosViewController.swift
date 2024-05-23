//
//  PhotosViewController.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
import UIKit

class PhotosViewController: UINavigationController {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        activityIndicator.startAnimating()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
}

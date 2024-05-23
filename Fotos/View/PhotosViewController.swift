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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotoItemCell.self, forCellReuseIdentifier: PhotoItemCell.reuseIdentifier)
        return tableView
    }()
    
    private let cellHeight: CGFloat = 132
    private var photos = [Photo]()
    
    private var viewModel: PhotosViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupMVVM()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(activityIndicator)
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func setupMVVM() {
        let remotePhotosLoader = RemotePhotosLoader(client: RemoteHTTPClient())
        viewModel = PhotosViewModel(photosLoader: remotePhotosLoader)
        viewModel?.onUpdate = { [weak self] status in
            guard let self = self else {return}
            switch status {
            case .loading:
                self.tableView.isHidden = true
                self.activityIndicator.startAnimating()
            case let .ready(photos):
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.photos.append(contentsOf: photos)
                self.tableView.reloadData()

            case let .error(error):
                self.activityIndicator.stopAnimating()
                // add error handle
            }
        }
        
        viewModel?.search(query: "iphone", page: 0)
    }
    
}

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoItemCell.reuseIdentifier) as? PhotoItemCell {
            let photo = photos[indexPath.row]
            let cellViewModel = PhotoItemCellViewModel(model: photo)
            cell.setViewModel(with: cellViewModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

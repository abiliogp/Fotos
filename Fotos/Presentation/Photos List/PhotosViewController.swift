//
//  PhotosViewController.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.accessibilityHint = "List"
        tableView.accessibilityLabel = "A list of images for the given search"
        tableView.isAccessibilityElement = true
        tableView.register(PhotoItemCell.self, forCellReuseIdentifier: PhotoItemCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = PhotosLocalized.placeholder
        searchBar.accessibilityHint = "Search"
        searchBar.accessibilityLabel = "Enter your search here"
        searchBar.isAccessibilityElement = true
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var textItem: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.accessibilityHint = "Status text"
        label.accessibilityLabel = "A text with the given status of photos list"
        label.isAccessibilityElement = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cellHeight: CGFloat = 316
    private let padding: CGFloat = 16

    private var viewModel: PhotosViewModel
    
    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupMVVM()
    }
    
    private func setupView() {
        self.title = PhotosLocalized.photosTitle
        self.view.addSubview(activityIndicator)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        self.view.addSubview(textItem)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textItem.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            textItem.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            textItem.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            safeArea.trailingAnchor.constraint(equalTo: textItem.trailingAnchor, constant: padding),
        ])
        
        textItem.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        textItem.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
    }
    
    private func setupMVVM() {
        viewModel.onUpdate = { [weak self] status in
            DispatchQueue.main.async {
                guard let self = self else {return}
                switch status {
                case .start:
                    self.showText()
                    self.textItem.text = PhotosLocalized.start

                case .empty:
                    self.showText()
                    self.textItem.text = PhotosLocalized.empty
                    
                case .loading:
                    self.showLoading()

                case let .ready(indexPaths):
                    self.showTableView()
                    if let newIndexPaths = indexPaths {
                        self.tableView.insertRows(at: newIndexPaths, with: .automatic)
                    } else {
                        self.tableView.setContentOffset(.zero, animated: true)
                        self.tableView.reloadData()
                    }

                case let .error(error):
                    self.showText()
                    self.textItem.text = error.localizedDescription
                }
            }
        }
        viewModel.start()
    }
    
    private func showTableView() {
        self.activityIndicator.stopAnimating()
        self.textItem.isHidden = true
        self.tableView.isHidden = false
    }
    
    private func showText() {
        self.activityIndicator.stopAnimating()
        self.tableView.isHidden = true
        self.textItem.isHidden = false
    }
    
    private func showLoading() {
        self.activityIndicator.startAnimating()
        self.tableView.isHidden = true
        self.textItem.isHidden = true
    }
}

extension PhotosViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let photoItemCell = tableView.dequeueReusableCell(withIdentifier: PhotoItemCell.reuseIdentifier) as? PhotoItemCell {
            if let cellViewModel = photoItemCell.viewModel {
                viewModel.updateCell(for: indexPath.row, viewModel: cellViewModel)
                cellViewModel.loading()
            } else if let cellViewModel = viewModel.configureCell(for: indexPath.row){
                photoItemCell.viewModel = cellViewModel
                cellViewModel.loading()
            }
            return photoItemCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let photoItemCell = cell as? PhotoItemCell
        photoItemCell?.viewModel?.loadImage()
        if indexPath.row == viewModel.total - 1 {
            viewModel.load()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.prepareForReuse()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openViewCell(for: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension PhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            viewModel.search(query: text)
        }
        searchBar.endEditing(true)
    }
}

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
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.register(PhotoItemCell.self, forCellReuseIdentifier: PhotoItemCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.delegate = self
        searchBar.showsScopeBar = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search Here..."
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var textItem: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fontSize: CGFloat = 18
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
        self.view.addSubview(activityIndicator)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        self.view.addSubview(textItem)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
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
                case .empty:
                    self.activityIndicator.stopAnimating()
                    self.tableView.isHidden = true
                    self.textItem.isHidden = false
                    self.textItem.text = "No items for that search, please try another one!"
                    
                case .loading:
                    self.tableView.isHidden = true
                    self.textItem.isHidden = true
                    self.activityIndicator.startAnimating()
                    
                case let .ready(indexPaths):
                    guard let newIndexPaths = indexPaths else {
                        self.activityIndicator.stopAnimating()
                        self.tableView.isHidden = false
                        self.tableView.reloadData()
                        return
                    }
                    self.activityIndicator.stopAnimating()
                    self.tableView.isHidden = false
                    self.tableView.insertRows(at: newIndexPaths, with: .automatic)

                case let .error(error):
                    self.activityIndicator.stopAnimating()
                    self.textItem.isHidden = false
                    self.textItem.text = error.localizedDescription
                }
            }
        }
    }
}

extension PhotosViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoItemCell.reuseIdentifier) as? PhotoItemCell,
           let cellViewModel = viewModel.configureCell(for: indexPath.row){
            cell.setViewModel(with: cellViewModel)
            cellViewModel.loading()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cellViewModel = viewModel.configureCell(for: indexPath.row) else { return }
        cellViewModel.loadImage()
        if indexPath.row == viewModel.total - 1 {
            viewModel.load()
        }
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

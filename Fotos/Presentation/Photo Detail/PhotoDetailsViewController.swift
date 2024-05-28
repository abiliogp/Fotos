//
//  PhotoDetailsView.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import Foundation
import UIKit

class PhotoDetailsViewController: UIViewController {
    // MARK: - Properties
    private let padding: CGFloat = 16
    
    private lazy var textTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = PhotosLocalized.detailTextHint
        label.accessibilityLabel = PhotosLocalized.detailTextLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textSource: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = PhotosLocalized.detailSourceHint
        label.accessibilityLabel = PhotosLocalized.detailSourceLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textTakenBy: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = PhotosLocalized.detailUserHint
        label.accessibilityLabel = PhotosLocalized.detailUserLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel: PhotoDetailsViewModel
    
    // MARK: - Initializers
    init(viewModel: PhotoDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupMVVM()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = PhotosLocalized.titleForPhotoDetail

        view.addSubview(textTitle)
        view.addSubview(textSource)
        view.addSubview(textTakenBy)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            textTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: padding),
            textTitle.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            safeArea.trailingAnchor.constraint(equalTo: textTitle.trailingAnchor, constant: padding),
        ])
        
        NSLayoutConstraint.activate([
            textSource.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: padding),
            textSource.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            safeArea.trailingAnchor.constraint(equalTo: textSource.trailingAnchor, constant: padding),
        ])
        
        NSLayoutConstraint.activate([
            textTakenBy.topAnchor.constraint(equalTo: textSource.bottomAnchor, constant: padding),
            textTakenBy.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: padding),
            safeArea.trailingAnchor.constraint(equalTo: textTakenBy.trailingAnchor, constant: padding),
        ])
    }
    
    private func setupMVVM() {
        textTitle.text = viewModel.title
        textSource.text = viewModel.source
        textTakenBy.text = viewModel.takenBy
    }
}

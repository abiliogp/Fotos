//
//  PhotoDetailsView.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 25/05/2024.
//

import Foundation
import UIKit

class PhotoDetailsViewController: UIViewController {
    private let padding: CGFloat = 16
    
    private lazy var textTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Title Text"
        label.accessibilityLabel = "A text with the given title of image"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textSource: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Source Text"
        label.accessibilityLabel = "A text with the given source of image"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textTakenBy: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Taken By Text"
        label.accessibilityLabel = "A text with the given author of image"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel: PhotoDetailsViewModel
    
    init(viewModel: PhotoDetailsViewModel) {
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
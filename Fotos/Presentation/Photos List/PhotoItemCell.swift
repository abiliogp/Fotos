//
//  PhotoItemCell.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
import UIKit

class PhotoItemCell: UITableViewCell {
    // MARK: - Properties
    static let reuseIdentifier = "PhotoItemCell"
    
    var viewModel: PhotoItemCellViewModel? {
        didSet {
            setupViewBind()
        }
    }
    
    private let padding: CGFloat = 16
    private let cornerRadius: CGFloat = 8
    private let imageSize = 300
    
    private lazy var textItem: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isAccessibilityElement = true
        label.accessibilityHint = "Status text"
        label.accessibilityLabel = "Status of the photo cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageItem: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = cornerRadius
        image.isAccessibilityElement = true
        image.accessibilityHint = "Image"
        image.accessibilityLabel = "Image from search result"
        image.translatesAutoresizingMaskIntoConstraints = false
        image.sizeThatFits(CGSize.init(width: imageSize, height: imageSize))
        return image
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Initializers
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Methods
    private func setupViewBind() {
        self.viewModel?.onUpdate = { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateView(for: status)
            }
        }
    }
    
    private func updateView(for status: PhotoItemCellViewModel.Status) {
        switch status {
        case .loading:
            showLoading()
        case .ready(let image):
            showImage(image)
        case .error(let error):
            showText(error.localizedDescription)
        }
    }
    
    private func showLoading() {
        self.activityIndicator.startAnimating()
        self.imageItem.isHidden = true
        self.textItem.isHidden = true
    }
    
    private func showImage(_ cgImage: CGImage) {
        self.activityIndicator.stopAnimating()
        self.imageItem.isHidden = false
        self.textItem.isHidden = true
        self.imageItem.image = UIImage(cgImage: cgImage)
    }
    
    private func showText(_ text: String) {
        self.activityIndicator.stopAnimating()
        self.textItem.isHidden = false
        self.textItem.text = text
    }

    private func setupViews() {
        addSubview(textItem)
        addSubview(imageItem)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageItem.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: imageItem.bottomAnchor, constant: padding),
            imageItem.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageItem.widthAnchor.constraint(equalToConstant: CGFloat(imageSize)),
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: self.imageItem.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.imageItem.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textItem.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textItem.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textItem.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: textItem.trailingAnchor, constant: padding),
        ])
        
        textItem.setContentHuggingPriority(.defaultLow + 1, for: .vertical)
        textItem.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
    }
}

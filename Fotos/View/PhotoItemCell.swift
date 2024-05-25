//
//  PhotoItemCell.swift
//  Fotos
//
//  Created by Abilio Gambim Parada on 23/05/2024.
//

import Foundation
import UIKit

class PhotoItemCell: UITableViewCell {
    
    static let reuseIdentifier = "PhotoItemCell"
    
    var viewModel: PhotoItemCellViewModel?
    
    private let padding: CGFloat = 16
    private let cornerRadius: CGFloat = 8
    private let imageSize = 300
    private let fontSize: CGFloat = 18
    
    private lazy var textItem: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageItem: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        image.sizeThatFits(CGSize.init(width: imageSize, height: imageSize))
        return image
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    public func setViewModel(with modelView: PhotoItemCellViewModel) {
        self.viewModel = modelView
        setupViewBind()
    }
    
    private func setupViewBind() {
        self.viewModel?.onUpdate = { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch status {
                case .loading:
                    self.activityIndicator.startAnimating()
                    self.imageItem.isHidden = true
                    self.textItem.isHidden = true
                    
                case let .ready(data):
                    self.activityIndicator.stopAnimating()
                    self.imageItem.isHidden = false
                    self.textItem.isHidden = true
                    self.imageItem.image = data
                    
                case let .error(error):
                    self.activityIndicator.stopAnimating()
                    self.textItem.text = error.localizedDescription
                    self.textItem.isHidden = false
                }
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        viewModel = nil
    }
    
    private func setupViews() {
        addSubview(textItem)
        addSubview(imageItem)
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        //add code here to layout views
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

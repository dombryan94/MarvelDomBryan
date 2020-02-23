//
//  ComicCell.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

final class ComicCell: UITableViewCell {
    
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let comicTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private let comicDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private let labelStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    static let reuseIdentifier = "ComicCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - Add Data
extension ComicCell {
    func update(with comic: Comics, imageService: ImageService = MarvelImageService()) {
        comicImageView.image = nil
        comicTitleLabel.text = comic.title
        comicDetailLabel.text = comic.description
        
        guard let url = comic.imageURL else { return }
        imageService.fetchImage(request: URLRequest(url: url)) { [weak self] (image, error) in
            self?.comicImageView.image = image
        }
        updateConstraints()
    }
}

// MARK: - View Setup
extension ComicCell {
    private func setupView() {
        labelStack.addArrangedSubview(comicTitleLabel)
        labelStack.addArrangedSubview(comicDetailLabel)
        containerStack.addArrangedSubview(comicImageView)
        containerStack.addArrangedSubview(labelStack)
        addSubview(containerStack)
        
        let constraints: [NSLayoutConstraint] = [
            comicImageView.widthAnchor.constraint(equalToConstant: 100),
            
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

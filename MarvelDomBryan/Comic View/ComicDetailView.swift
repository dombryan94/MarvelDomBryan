//
//  ComicDetailView.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 23/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

class ComicDetailView: UIView {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16.0
        stackView.axis = .vertical
        return stackView
    }()
    
    private let comicTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let comicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        imageView.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
        return imageView
    }()
    
    private let comicDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private let viewModel: ComicDetailViewable
    
    init(viewModel: ComicDetailViewable) {
        self.viewModel = viewModel
        super.init(frame: UIScreen.main.bounds)
        setupView()
        addData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(stackView)
        stackView.addArrangedSubview(comicTitleLabel)
        stackView.addArrangedSubview(comicImageView)
        stackView.addArrangedSubview(comicDescriptionLabel)
        
        let constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -25),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    private func addData(imageService: ImageService = MarvelImageService()) {
        comicTitleLabel.text = viewModel.comicTitle()
        comicDescriptionLabel.text = viewModel.comicDescription()
        viewModel.comicImage({ [weak self] image in
            self?.comicImageView.image = image
        })
    }
}

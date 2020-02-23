//
//  ComicDetailController.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

final class ComicDetailController: UIViewController {
    
    private let viewModel: ComicDetailViewable
    
    init(viewModel: ComicDetailViewable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = ComicDetailView(viewModel: viewModel)
    }
}

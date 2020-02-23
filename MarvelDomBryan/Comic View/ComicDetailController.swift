//
//  ComicDetailController.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

class ComicDetailController: UIViewController {
    
//    private let viewModel: HomeViewModelProtocol
    private let comic: Comics
    
    init(comic: Comics) {
//        self.viewModel = viewModel
        self.comic = comic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = comic.title
        view.backgroundColor = .systemGray
    }
}

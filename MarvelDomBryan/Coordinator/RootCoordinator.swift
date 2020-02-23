//
//  RootCoordinator.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

protocol RootNavigationDelegate: class {
    func didSelect(comic: Comics?)
}

final class RootCoordinator: Coordinator {

    var navigationController: UINavigationController
    var homeController: HomeController {
        let service = MarvelService()
        let viewModel = HomeViewModel(marvelService: service)
        return HomeController(viewModel: viewModel)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = homeController
        viewController.navigationDelegate = self
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension RootCoordinator: RootNavigationDelegate {
    func didSelect(comic: Comics?) {
        guard let comic = comic else { return }
        let viewModel = ComicDetailViewModel(comic: comic)
        let detailsViewController = ComicDetailController(viewModel: viewModel)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}

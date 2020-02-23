//
//  Coordinator.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

//
//  HomeController.swift
//  MarvelDomBryan
//
//  Created by Dom Bryan on 22/02/2020.
//  Copyright © 2020 Dom Bryan. All rights reserved.
//

import UIKit

enum HomeTableViewState {
    case loading
    case loaded
    case failed
}

final class HomeController: UITableViewController {
    
    weak var navigationDelegate: RootNavigationDelegate?
    
    private let viewModel: HomeViewModelProtocol
    
    private lazy var searchController: UISearchController = createSearchController()
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(ComicCell.self, forCellReuseIdentifier: ComicCell.reuseIdentifier)
        navigationItem.searchController = searchController
        searchController.delegate = self
        title = "Comics"
        setupActivityIndicator()
        render(.loading)
        viewModel.fetchComics(then: { [weak self] state in
            DispatchQueue.main.async {
                self?.render(state)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Render view
extension HomeController {
    private func render(_ state: HomeTableViewState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .loaded:
            self.tableView.reloadData()
            activityIndicator.stopAnimating()
        case .failed:
            activityIndicator.stopAnimating()
        }
    }
    
    private func setupActivityIndicator() {
        tableView.addSubview(activityIndicator)
        let constraints: [NSLayoutConstraint] = [
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: TableView DataSource
extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredComics.count
        }
        return viewModel.comics?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let comics = viewModel.comics else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ComicCell.reuseIdentifier, for: indexPath) as? ComicCell
            else { return UITableViewCell() }
        
        let comic: Comics
        if isFiltering {
            comic = viewModel.filteredComics[indexPath.row]
        } else {
          comic = comics[indexPath.row]
        }
        
        cell.update(with: comic)
        return cell
    }
    
    
    // MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comic: Comics?
        if isFiltering {
            comic = viewModel.filteredComics[indexPath.row]
        } else {
          comic = viewModel.comics?[indexPath.row]
        }
        navigationDelegate?.didSelect(comic: comic)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - Search Controller
extension HomeController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        render(.loading)
        let searchBar = searchController.searchBar
        viewModel.filterContentForSearchText(searchBar.text!) { [weak self] state in
            DispatchQueue.main.async {
                self?.render(state)
            }
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        render(.loaded)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    private func createSearchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Comics"
        definesPresentationContext = true
        return searchController
    }
}

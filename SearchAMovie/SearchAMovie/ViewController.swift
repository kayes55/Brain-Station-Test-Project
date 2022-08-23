//
//
// SearchAMovie
// Running on MacOS Version 12.4
// Swift Version 5.0
// Created by kayes on 8/12/22
// Copyright © IMRUL KAYES. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var emptyStateView: UIView!
    
    @IBOutlet weak var emptyStateLabel: UILabel!
    
    @IBOutlet weak var emptyStateImageView: UIImageView!
    
    
    // MARK: - ViewModel, Views & SearchController
    var viewModel: SearchMoviesViewModel = SearchMoviesViewModel()
    
    
    private let searchController = UISearchController(searchResultsController: nil)
        
    
    // MARK: - Lifecycle/Configuration/Setup Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureSearchController()
        configEmptyUI()
    }


    
    private func configureDelegates() {
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configEmptyUI() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.emptyStateLabel.text = Constants.Search.emptyStateWelcomeText
            self?.emptyStateView.isHidden = false
            self?.emptyStateImageView.image = UIImage(named: Constants.Icons.appLogo)
        }
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.Search.placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
   
}

// MARK: - UITableViewDelegate/DataSource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.MovieCell,
            for: indexPath
        ) as! MovieCell
                
        if let movie = viewModel.getMovie(at: indexPath) {
            cell.title.text = movie.title
            cell.body.text = movie.overview
            cell.imageForMovie.loadImage(from: viewModel.backdropImageURL(of: movie))
        }
        
        return cell
    }
    
}




// MARK: - UISearchResultsUpdating Methods
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputTextByUser = searchController.searchBar.text else { return }
        if !inputTextByUser.isEmpty {
            tableView.tableHeaderView = createSpinner()
        }
        self.viewModel.searchMovies(with: inputTextByUser)  
    }
    
    private func createSpinner() -> UIView {
        let spinnerView = UIView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        )
        
        let spinner = UIActivityIndicatorView()
        spinner.center = spinnerView.center
        spinner.startAnimating()
        
        spinnerView.addSubview(spinner)
        
        return spinnerView
    }
}

extension ViewController: SearchMoviesViewModelDelegate {
    func showNoResultsState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.tableHeaderView = nil
            self?.emptyStateLabel.text = Constants.Search.emptyStateNoResultsText
            self?.emptyStateView.isHidden = false
            self?.emptyStateImageView.image = UIImage(named: Constants.Search.noResultsImage)
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.emptyStateLabel.text = Constants.Search.emptyStateWelcomeText
            self?.emptyStateView.isHidden = false
            self?.emptyStateImageView.image = UIImage(named: Constants.Icons.appLogo)
        }
    }
    
    func didFindMovies() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.tableHeaderView = nil
            self?.emptyStateView.isHidden = true
        }
    }
    
    func didFail(error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.tableHeaderView = nil
            self?.showAlert(message: error.customMessage)
        }
    }
}

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
    // MARK: - ViewModel, Views & SearchController
    
    
    private let searchController = UISearchController(searchResultsController: nil)
        
    var allRes = [Result]()

    
    // MARK: - Lifecycle/Configuration/Setup Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configureDelegates()
        configureSearchController()
        getMovies()
    }


    
    private func configureDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.Search.placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
    
    func getMovies() {
        guard let base = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=38e61227f85671163c275f9bd95a8803&query=spider") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: base) { data, response, error in
            guard error == nil else {
                print("error BS \(String(describing: error))")
                return}
            guard let data = data else {
                return
            }
            
            do {
                 let decoder = JSONDecoder()
                 let response = try decoder.decode(Movies.self, from: data)
                 self.allRes = response.results
                 DispatchQueue.main.async {
                   self.tableView.reloadData()
                 }

            } catch {
                print(error)
            }
            
        }
        task.resume()
        
        
    }
    
   
}

// MARK: - UITableViewDelegate/DataSource Methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allRes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.MovieCell,
            for: indexPath
        ) as! MovieCell
                
        
        cell.title.text = allRes[indexPath.row].title
        cell.body.text = allRes[indexPath.row].overview
        cell.imageForMovie.image = UIImage(named: "NoResults")
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
        print("User input text \(inputTextByUser)")
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


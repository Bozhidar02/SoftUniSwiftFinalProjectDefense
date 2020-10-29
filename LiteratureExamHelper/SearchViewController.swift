//
//  ViewController.swift
//  LiteratureExamHelper
//
//  Created by Bozhidat Goranov on 29.10.20.
//

import UIKit

class SearchViewController: UIViewController {
    //MARK: - Constants
    enum TableView{
        enum CellIdentifier: String{
            case searchCell = "SearchResultCell"
            case noResultsCell = "NoResultCell"
            case loadingCell = "LoadingCell"
        }
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var authors: [Author] = []
    var searchResults: [SearchResult] = []
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 0, right: 0)
    }

}

extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var at = Author(name: "Иван Вазов", mainThemes: "")
        authors.append(at)
        searchResults = []
        
        for i in authors{
            if searchBar.text == i.name{
                let searchResult = SearchResult(authors: i)
                searchResults.append(searchResult)
            }
        }
        tableView.reloadData()
    }
}
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifier.searchCell.rawValue, for: indexPath) as! SearchResultCell
        
        if searchResults.isEmpty{
            return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifier.noResultsCell.rawValue, for: indexPath)
        }
        let searchResult = searchResults[indexPath.row]
        cell.authorNameLabel.text = searchResult.authors.name
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.isEmpty{
            return nil
        }
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


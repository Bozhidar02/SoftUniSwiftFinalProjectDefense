//
//  ViewController.swift
//  LiteratureExamHelper
//
//  Created by Bozhidat Goranov on 29.10.20.
//

import UIKit

class SearchViewController: UIViewController{
    
    //MARK: - Constants
    enum TableView{
        enum CellIdentifier: String{
            case searchCell = "SearchResultCell"
            case noResultsCell = "NoResultCell"
        }
    }
    
    //MARK: - IBOutlets
    @IBAction func details(_ sender: Any) {
        performSegue(withIdentifier: "Details", sender: self)
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let searchResultNib = UINib(nibName: "SearchResultCell", bundle: nil)
            tableView.register(searchResultNib, forCellReuseIdentifier: "SearchResultCell")
        }
    }
    
    //MARK: - Properties
    var authors: [Author] = []
    var searchResult: Author = Author(name: "", mainThemes: "")
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 0, right: 0)
        var at = Author(name: "Христо Ботев", mainThemes: "")
        authors.append(at)
        at = Author(name: "Иван Вазов", mainThemes: "")
        authors.append(at)
        at = Author(name: "Алеко Констаниов", mainThemes: "")
        authors.append(at)
        
    }
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
}


extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let empty = Author(name: "", mainThemes: "")
        searchResult = empty
        
        for i in authors{
            if i.name == searchBar.text{
                searchResult = i
                break
            }
        }
        if searchResult.name == ""{
            let empty = Author(name: "Няма такъв автор", mainThemes: "")
            searchResult = empty
        }
        tableView.reloadData()
    }
}
extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResult.name == ""{
            return authors.count
        }
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell1", for: indexPath) //as! SearchResultCell
        if searchResult.name == ""{
            cell.textLabel!.text = authors[indexPath.row].name
            //cell.themesLabel.text = authors[indexPath.row].name
        }else{
            cell.textLabel!.text = searchResult.name
            //cell.authorNameLabel.text = searchResult.name
            //cell.themesLabel.text = searchResult.mainThemes
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResult.name == ""{
            return nil
            
        }
        return indexPath
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}


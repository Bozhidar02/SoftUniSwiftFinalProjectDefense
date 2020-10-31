//
//  ViewController.swift
//  LiteratureExamHelper
//
//  Created by Bozhidat Goranov on 29.10.20.
//

import UIKit

class SearchViewController: UIViewController, DetailViewControllerDelegate{
    func detailViewControllerDidCancel(_ controller: DetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func detailViewController(_ controller: DetailViewController, didFinishAdding item: Author) {
        let newRowIndex = authors.count
        authors.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func detailViewController(_ controller: DetailViewController, didFinishEditing item: Author) {
        if let index = authors.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) /*as? SearchResultCell */{
                cell.textLabel?.text = ""
            }
          }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Properties
    var authors: [Author] = [Author(name: "Христо Ботев", mainThemes: "Основни теми - свободата(индивидуална, национална, универсална), робското страдание, борбата срещу робството."),
        Author(name: "Иван Вазов", mainThemes: "Основни теми - българският език като стълб на националната идентичност, красотата на родната природа, възпяването на героизния подвиг на борците за свобода и тяхното безсмъртие."),
        Author(name: "Алеко Констаниов", mainThemes: "Основни теми - потъпкването на възрожденските ценности, различията в българската и европейската култура, кризата в духовната сфера."),
        Author(name: "Пенчо Славейков", mainThemes: "Основни теми - самотата, откъсваща човека от шума и суетата на всекидневието, избраничеството, страданието, извисяващо човешкия дух."),
        Author(name: "Пейо Яворов", mainThemes: "Основни теми - страданието, обречеността и надеждата, лишението от сигурното битие на човека, любовта като спаение, любовната съдба и страдание, двойността на света"),
        Author(name: "Димчо Дебелянов", mainThemes: "Основни теми - носталгията по миналото детство, неизживяния живот, загубената младост, затворът обгръщаш човека от всякъде, войната и нейното безмислие")]
    var searchResult: Author = Author(name: "", mainThemes: "")
    var index = 0
    //var dest: Any = nil
    
    //MARK: - Constants
    enum TableView{
        enum CellIdentifier: String{
            case searchCell = "SearchResultCell"
            case noResultsCell = "NoResultCell"
        }
    }
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            let searchResultNib = UINib(nibName: "SearchResultCell", bundle: nil)
            tableView.register(searchResultNib, forCellReuseIdentifier: "SearchResultCell")
        }
    }

   //MARK: - IBActions
    @IBAction func openDetails(_ sender: UIButton) {
        var superview = sender.superview
         while let view = superview, !(view is UITableViewCell) {
             superview = view.superview
         }
         guard let cell = superview as? UITableViewCell else {
             print("button is not contained in a table view cell")
             return
         }
         guard let indexPath = tableView.indexPath(for: cell) else {
             print("failed to get index path for cell containing button")
             return
         }
         print("1 - button is in row \(indexPath.row)")
        index = indexPath.row
   
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destination = (segue.destination as? DetailViewController)!
    let button = sender as? UIButton
    destination.delegate = self
    var correctAuthor: Author? = nil
    if searchResult.name != ""{
        for i in authors{
            if i.name == searchResult.name{
                correctAuthor = i
            }
        }
        destination.author = correctAuthor
    }else{
        destination.author = authors[index]
    }
    
//    dest = destination
       /* if let indexPath = tableView.indexPath(for: cell!) {
            destination!.author = authors[indexPath.row]
        }*/
}
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 0, right: 0)
    }
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
}

//MARK: - SearchView
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
            let empty = Author(name: "", mainThemes: "")
            searchResult = empty
        }
        tableView.reloadData()
    }
}

//MARK: - TableView
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


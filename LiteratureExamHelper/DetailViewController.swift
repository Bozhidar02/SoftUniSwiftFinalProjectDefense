//
//  DetailViewController.swift
//  LiteratureExamHelper
//
//  Created by Bozhidat Goranov on 31.10.20.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func detailViewControllerDidCancel(_ controller: DetailViewController)
    func detailViewController(_ controller: DetailViewController, didFinishAdding item: Author)
    func detailViewController(_ controller: DetailViewController, didFinishEditing item: Author)
}
class DetailViewController: UIViewController {

    
    //MARK: - IBOutlets
    @IBOutlet public weak var nameLabel: UILabel!
    @IBOutlet weak var detail: UITextView!
    
    // MARK: - Properties
    weak var delegate: DetailViewControllerDelegate?
    var author: Author?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = author?.name
        detail.text = author?.mainThemes

    }
    

}

//
//  Author.swift
//  LiteratureExamHelper
//
//  Created by Bozhidat Goranov on 29.10.20.
//

import Foundation

class Author: NSObject{
    var name: String = ""
    //var timePeriod = ""
    var mainThemes: String = ""
    //var works: [Works] = []
    init(name: String, mainThemes: String) {
        self.name = name
        self.mainThemes = mainThemes
    }
}

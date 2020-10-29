//
//  Author.swift
//  LiteratureExamHelper
//
//  Created by Bozhidat Goranov on 29.10.20.
//

import Foundation

class Author{
    var name: String = ""
    //var yearOfBirth: Int = 0
    //var yearOfDeath: Int = 0
    var mainThemes: String = ""
    //var works: [Works] = []
    init(name: String, mainThemes: String) {
        self.name = name
        self.mainThemes = mainThemes
    }
}

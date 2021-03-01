//
//  WrongAnswer.swift
//  FiszkiApp
//
//  Created by Leopold on 02/02/2021.
//

import UIKit

class WrongAnswerItem {
    var term: String?
    var definition: String?
    
    convenience init(term: String, definition: String) {
        self.init()
        self.term = term
        self.definition = definition
    }
}

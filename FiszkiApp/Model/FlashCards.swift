//
//  FlashCards.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit

class FlashCards {
    var term: String?
    var definition: String?
    
    convenience init(term: String, definition: String) {
        self.init()
        self.term = term
        self.definition = definition
    }
}

//
//  FlashCardGroups.swift
//  fiszki
//
//  Created by Leopold on 18/01/2021.
//

import UIKit

class Group {
    var title: String?
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}

//
//  FlashCardItem+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//
//

import UIKit
import CoreData

@objc(FlashCardItem)
public class FlashCardItem: NSManagedObject {
    
    var rightAnswers: [RightAnswer]? {
        return self.rawRightAnswers?.array as? [RightAnswer]
    }
    
    var wrongAnswers: [WrongAnswer]? {
        return self.rawWrongAnswers?.array as? [WrongAnswer]
    }
    
    convenience init?(term: String, definition: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: FlashCardItem.entity(), insertInto: context)
        
        self.term = term
        self.definition = definition
        
    }
    
}

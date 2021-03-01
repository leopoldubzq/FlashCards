//
//  FlashCardItem+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import UIKit
import CoreData

@objc(FlashCardItem)
public class FlashCardItem: NSManagedObject {
    
    convenience init?(term: String, definition: String, didAnswerCorrectly: Bool, hasBeenUsed: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: FlashCardItem.entity(), insertInto: context)
        
        self.term = term
        self.definition = definition
        self.didAnswerCorrectly = didAnswerCorrectly
        self.hasBeenUsed = hasBeenUsed
    }
    
}

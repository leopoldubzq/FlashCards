//
//  FlashCardItem+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 29/01/2021.
//
//

import UIKit
import CoreData

@objc(FlashCardItem)
public class FlashCardItem: NSManagedObject {
    
    convenience init?(term: String, definition: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: FlashCardItem.entity(), insertInto: context)
        
        self.term = term
        self.definition = definition
        
    }
    
}

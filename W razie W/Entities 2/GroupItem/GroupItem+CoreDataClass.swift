//
//  GroupItem+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//
//

import UIKit
import CoreData

@objc(GroupItem)
public class GroupItem: NSManagedObject {
    
    var flashCards: [FlashCardItem]? {
        return self.rawFlashCards?.array as? [FlashCardItem]
    }
    
    convenience init?(name: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: GroupItem.entity(), insertInto: context)
        
        self.name = name
    }
    
}

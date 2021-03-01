//
//  LastRightAnswer+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 04/02/2021.
//
//

import UIKit
import CoreData

@objc(LastRightAnswer)
public class LastRightAnswer: NSManagedObject {
    
    convenience init?(term: String, definition: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: LastRightAnswer.entity(), insertInto: context)
        
        self.term = term
        self.definition = definition
        
    }
    
}

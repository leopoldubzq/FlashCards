//
//  Answer+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import UIKit
import CoreData

@objc(Answer)
public class Answer: NSManagedObject {
    
    convenience init?(term: String, definition: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: Answer.entity(), insertInto: context)
        
        self.term = term
        self.definition = definition
        
    }
    
}

//
//  WrongAnswer+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import UIKit
import CoreData

@objc(WrongAnswer)
public class WrongAnswer: NSManagedObject {
    
    convenience init?(term: String, definition: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: WrongAnswer.entity(), insertInto: context)
        
        self.term = term
        self.definition = definition
    }
}

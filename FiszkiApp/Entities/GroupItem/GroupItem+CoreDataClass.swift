//
//  GroupItem+CoreDataClass.swift
//  FiszkiApp
//
//  Created by Leopold on 04/02/2021.
//
//

import UIKit
import CoreData

@objc(GroupItem)
public class GroupItem: NSManagedObject {
    
    var flashCards: [FlashCardItem]? {
        return self.rawFlashCards?.array as? [FlashCardItem]
    }
    
    var rightAnswers: [CorrectAnswer]? {
        return self.rawCorectAnswers?.array as? [CorrectAnswer]
    }
    
    var wrongAnswers: [WrongAnswer]? {
        return self.rawWrongAnswers?.array as? [WrongAnswer]
    }
    
    var answers: [Answer]? {
        return self.rawAnswers?.array as? [Answer]
    }
    
    var lastScore: [LastScore]? {
        return self.rawLastScore?.array as? [LastScore]
    }
    
    var lastRightAnswer: [LastRightAnswer]? {
        return self.rawLastRightAnswers?.array as? [LastRightAnswer]
    }
    
    convenience init?(name: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else { return nil }
        
        self.init(entity: GroupItem.entity(), insertInto: context)
        
        self.name = name
    }
    
}

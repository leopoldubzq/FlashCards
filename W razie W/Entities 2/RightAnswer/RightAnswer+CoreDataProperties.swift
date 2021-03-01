//
//  RightAnswer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//
//

import Foundation
import CoreData


extension RightAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RightAnswer> {
        return NSFetchRequest<RightAnswer>(entityName: "RightAnswer")
    }

    @NSManaged public var definition: String?
    @NSManaged public var term: String?
    @NSManaged public var flashCard: FlashCardItem?

}

extension RightAnswer : Identifiable {

}

//
//  WrongAnswer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//
//

import Foundation
import CoreData


extension WrongAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WrongAnswer> {
        return NSFetchRequest<WrongAnswer>(entityName: "WrongAnswer")
    }

    @NSManaged public var definition: String?
    @NSManaged public var term: String?
    @NSManaged public var flashCard: FlashCardItem?

}

extension WrongAnswer : Identifiable {

}

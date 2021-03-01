//
//  FlashCardItem+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import Foundation
import CoreData


extension FlashCardItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCardItem> {
        return NSFetchRequest<FlashCardItem>(entityName: "FlashCardItem")
    }

    @NSManaged public var definition: String?
    @NSManaged public var didAnswerCorrectly: Bool
    @NSManaged public var hasBeenUsed: Bool
    @NSManaged public var term: String?
    @NSManaged public var group: GroupItem?

}

extension FlashCardItem : Identifiable {

}

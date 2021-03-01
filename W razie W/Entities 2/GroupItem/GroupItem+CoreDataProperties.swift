//
//  GroupItem+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//
//

import Foundation
import CoreData


extension GroupItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupItem> {
        return NSFetchRequest<GroupItem>(entityName: "GroupItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var rawFlashCards: NSOrderedSet?

}

// MARK: Generated accessors for rawFlashCards
extension GroupItem {

    @objc(insertObject:inRawFlashCardsAtIndex:)
    @NSManaged public func insertIntoRawFlashCards(_ value: FlashCardItem, at idx: Int)

    @objc(removeObjectFromRawFlashCardsAtIndex:)
    @NSManaged public func removeFromRawFlashCards(at idx: Int)

    @objc(insertRawFlashCards:atIndexes:)
    @NSManaged public func insertIntoRawFlashCards(_ values: [FlashCardItem], at indexes: NSIndexSet)

    @objc(removeRawFlashCardsAtIndexes:)
    @NSManaged public func removeFromRawFlashCards(at indexes: NSIndexSet)

    @objc(replaceObjectInRawFlashCardsAtIndex:withObject:)
    @NSManaged public func replaceRawFlashCards(at idx: Int, with value: FlashCardItem)

    @objc(replaceRawFlashCardsAtIndexes:withRawFlashCards:)
    @NSManaged public func replaceRawFlashCards(at indexes: NSIndexSet, with values: [FlashCardItem])

    @objc(addRawFlashCardsObject:)
    @NSManaged public func addToRawFlashCards(_ value: FlashCardItem)

    @objc(removeRawFlashCardsObject:)
    @NSManaged public func removeFromRawFlashCards(_ value: FlashCardItem)

    @objc(addRawFlashCards:)
    @NSManaged public func addToRawFlashCards(_ values: NSOrderedSet)

    @objc(removeRawFlashCards:)
    @NSManaged public func removeFromRawFlashCards(_ values: NSOrderedSet)

}

extension GroupItem : Identifiable {

}

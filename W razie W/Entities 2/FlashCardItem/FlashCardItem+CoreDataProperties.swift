//
//  FlashCardItem+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 30/01/2021.
//
//

import Foundation
import CoreData


extension FlashCardItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCardItem> {
        return NSFetchRequest<FlashCardItem>(entityName: "FlashCardItem")
    }

    @NSManaged public var definition: String?
    @NSManaged public var groupName: String?
    @NSManaged public var term: String?
    @NSManaged public var group: GroupItem?
    @NSManaged public var rawRightAnswers: NSOrderedSet?
    @NSManaged public var rawWrongAnswers: NSOrderedSet?

}

// MARK: Generated accessors for rawRightAnswers
extension FlashCardItem {

    @objc(insertObject:inRawRightAnswersAtIndex:)
    @NSManaged public func insertIntoRawRightAnswers(_ value: RightAnswer, at idx: Int)

    @objc(removeObjectFromRawRightAnswersAtIndex:)
    @NSManaged public func removeFromRawRightAnswers(at idx: Int)

    @objc(insertRawRightAnswers:atIndexes:)
    @NSManaged public func insertIntoRawRightAnswers(_ values: [RightAnswer], at indexes: NSIndexSet)

    @objc(removeRawRightAnswersAtIndexes:)
    @NSManaged public func removeFromRawRightAnswers(at indexes: NSIndexSet)

    @objc(replaceObjectInRawRightAnswersAtIndex:withObject:)
    @NSManaged public func replaceRawRightAnswers(at idx: Int, with value: RightAnswer)

    @objc(replaceRawRightAnswersAtIndexes:withRawRightAnswers:)
    @NSManaged public func replaceRawRightAnswers(at indexes: NSIndexSet, with values: [RightAnswer])

    @objc(addRawRightAnswersObject:)
    @NSManaged public func addToRawRightAnswers(_ value: RightAnswer)

    @objc(removeRawRightAnswersObject:)
    @NSManaged public func removeFromRawRightAnswers(_ value: RightAnswer)

    @objc(addRawRightAnswers:)
    @NSManaged public func addToRawRightAnswers(_ values: NSOrderedSet)

    @objc(removeRawRightAnswers:)
    @NSManaged public func removeFromRawRightAnswers(_ values: NSOrderedSet)

}

// MARK: Generated accessors for rawWrongAnswers
extension FlashCardItem {

    @objc(insertObject:inRawWrongAnswersAtIndex:)
    @NSManaged public func insertIntoRawWrongAnswers(_ value: WrongAnswer, at idx: Int)

    @objc(removeObjectFromRawWrongAnswersAtIndex:)
    @NSManaged public func removeFromRawWrongAnswers(at idx: Int)

    @objc(insertRawWrongAnswers:atIndexes:)
    @NSManaged public func insertIntoRawWrongAnswers(_ values: [WrongAnswer], at indexes: NSIndexSet)

    @objc(removeRawWrongAnswersAtIndexes:)
    @NSManaged public func removeFromRawWrongAnswers(at indexes: NSIndexSet)

    @objc(replaceObjectInRawWrongAnswersAtIndex:withObject:)
    @NSManaged public func replaceRawWrongAnswers(at idx: Int, with value: WrongAnswer)

    @objc(replaceRawWrongAnswersAtIndexes:withRawWrongAnswers:)
    @NSManaged public func replaceRawWrongAnswers(at indexes: NSIndexSet, with values: [WrongAnswer])

    @objc(addRawWrongAnswersObject:)
    @NSManaged public func addToRawWrongAnswers(_ value: WrongAnswer)

    @objc(removeRawWrongAnswersObject:)
    @NSManaged public func removeFromRawWrongAnswers(_ value: WrongAnswer)

    @objc(addRawWrongAnswers:)
    @NSManaged public func addToRawWrongAnswers(_ values: NSOrderedSet)

    @objc(removeRawWrongAnswers:)
    @NSManaged public func removeFromRawWrongAnswers(_ values: NSOrderedSet)

}

extension FlashCardItem : Identifiable {

}

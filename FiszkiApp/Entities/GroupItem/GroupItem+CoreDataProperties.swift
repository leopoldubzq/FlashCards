//
//  GroupItem+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 04/02/2021.
//
//

import Foundation
import CoreData


extension GroupItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupItem> {
        return NSFetchRequest<GroupItem>(entityName: "GroupItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var rawAnswers: NSOrderedSet?
    @NSManaged public var rawCorectAnswers: NSOrderedSet?
    @NSManaged public var rawFlashCards: NSOrderedSet?
    @NSManaged public var rawLastScore: NSOrderedSet?
    @NSManaged public var rawWrongAnswers: NSOrderedSet?
    @NSManaged public var rawLastRightAnswers: NSOrderedSet?

}

// MARK: Generated accessors for rawAnswers
extension GroupItem {

    @objc(insertObject:inRawAnswersAtIndex:)
    @NSManaged public func insertIntoRawAnswers(_ value: Answer, at idx: Int)

    @objc(removeObjectFromRawAnswersAtIndex:)
    @NSManaged public func removeFromRawAnswers(at idx: Int)

    @objc(insertRawAnswers:atIndexes:)
    @NSManaged public func insertIntoRawAnswers(_ values: [Answer], at indexes: NSIndexSet)

    @objc(removeRawAnswersAtIndexes:)
    @NSManaged public func removeFromRawAnswers(at indexes: NSIndexSet)

    @objc(replaceObjectInRawAnswersAtIndex:withObject:)
    @NSManaged public func replaceRawAnswers(at idx: Int, with value: Answer)

    @objc(replaceRawAnswersAtIndexes:withRawAnswers:)
    @NSManaged public func replaceRawAnswers(at indexes: NSIndexSet, with values: [Answer])

    @objc(addRawAnswersObject:)
    @NSManaged public func addToRawAnswers(_ value: Answer)

    @objc(removeRawAnswersObject:)
    @NSManaged public func removeFromRawAnswers(_ value: Answer)

    @objc(addRawAnswers:)
    @NSManaged public func addToRawAnswers(_ values: NSOrderedSet)

    @objc(removeRawAnswers:)
    @NSManaged public func removeFromRawAnswers(_ values: NSOrderedSet)

}

// MARK: Generated accessors for rawCorectAnswers
extension GroupItem {

    @objc(insertObject:inRawCorectAnswersAtIndex:)
    @NSManaged public func insertIntoRawCorectAnswers(_ value: CorrectAnswer, at idx: Int)

    @objc(removeObjectFromRawCorectAnswersAtIndex:)
    @NSManaged public func removeFromRawCorectAnswers(at idx: Int)

    @objc(insertRawCorectAnswers:atIndexes:)
    @NSManaged public func insertIntoRawCorectAnswers(_ values: [CorrectAnswer], at indexes: NSIndexSet)

    @objc(removeRawCorectAnswersAtIndexes:)
    @NSManaged public func removeFromRawCorectAnswers(at indexes: NSIndexSet)

    @objc(replaceObjectInRawCorectAnswersAtIndex:withObject:)
    @NSManaged public func replaceRawCorectAnswers(at idx: Int, with value: CorrectAnswer)

    @objc(replaceRawCorectAnswersAtIndexes:withRawCorectAnswers:)
    @NSManaged public func replaceRawCorectAnswers(at indexes: NSIndexSet, with values: [CorrectAnswer])

    @objc(addRawCorectAnswersObject:)
    @NSManaged public func addToRawCorectAnswers(_ value: CorrectAnswer)

    @objc(removeRawCorectAnswersObject:)
    @NSManaged public func removeFromRawCorectAnswers(_ value: CorrectAnswer)

    @objc(addRawCorectAnswers:)
    @NSManaged public func addToRawCorectAnswers(_ values: NSOrderedSet)

    @objc(removeRawCorectAnswers:)
    @NSManaged public func removeFromRawCorectAnswers(_ values: NSOrderedSet)

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

// MARK: Generated accessors for rawLastScore
extension GroupItem {

    @objc(insertObject:inRawLastScoreAtIndex:)
    @NSManaged public func insertIntoRawLastScore(_ value: LastScore, at idx: Int)

    @objc(removeObjectFromRawLastScoreAtIndex:)
    @NSManaged public func removeFromRawLastScore(at idx: Int)

    @objc(insertRawLastScore:atIndexes:)
    @NSManaged public func insertIntoRawLastScore(_ values: [LastScore], at indexes: NSIndexSet)

    @objc(removeRawLastScoreAtIndexes:)
    @NSManaged public func removeFromRawLastScore(at indexes: NSIndexSet)

    @objc(replaceObjectInRawLastScoreAtIndex:withObject:)
    @NSManaged public func replaceRawLastScore(at idx: Int, with value: LastScore)

    @objc(replaceRawLastScoreAtIndexes:withRawLastScore:)
    @NSManaged public func replaceRawLastScore(at indexes: NSIndexSet, with values: [LastScore])

    @objc(addRawLastScoreObject:)
    @NSManaged public func addToRawLastScore(_ value: LastScore)

    @objc(removeRawLastScoreObject:)
    @NSManaged public func removeFromRawLastScore(_ value: LastScore)

    @objc(addRawLastScore:)
    @NSManaged public func addToRawLastScore(_ values: NSOrderedSet)

    @objc(removeRawLastScore:)
    @NSManaged public func removeFromRawLastScore(_ values: NSOrderedSet)

}

// MARK: Generated accessors for rawWrongAnswers
extension GroupItem {

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

// MARK: Generated accessors for rawLastRightAnswers
extension GroupItem {

    @objc(insertObject:inRawLastRightAnswersAtIndex:)
    @NSManaged public func insertIntoRawLastRightAnswers(_ value: LastRightAnswer, at idx: Int)

    @objc(removeObjectFromRawLastRightAnswersAtIndex:)
    @NSManaged public func removeFromRawLastRightAnswers(at idx: Int)

    @objc(insertRawLastRightAnswers:atIndexes:)
    @NSManaged public func insertIntoRawLastRightAnswers(_ values: [LastRightAnswer], at indexes: NSIndexSet)

    @objc(removeRawLastRightAnswersAtIndexes:)
    @NSManaged public func removeFromRawLastRightAnswers(at indexes: NSIndexSet)

    @objc(replaceObjectInRawLastRightAnswersAtIndex:withObject:)
    @NSManaged public func replaceRawLastRightAnswers(at idx: Int, with value: LastRightAnswer)

    @objc(replaceRawLastRightAnswersAtIndexes:withRawLastRightAnswers:)
    @NSManaged public func replaceRawLastRightAnswers(at indexes: NSIndexSet, with values: [LastRightAnswer])

    @objc(addRawLastRightAnswersObject:)
    @NSManaged public func addToRawLastRightAnswers(_ value: LastRightAnswer)

    @objc(removeRawLastRightAnswersObject:)
    @NSManaged public func removeFromRawLastRightAnswers(_ value: LastRightAnswer)

    @objc(addRawLastRightAnswers:)
    @NSManaged public func addToRawLastRightAnswers(_ values: NSOrderedSet)

    @objc(removeRawLastRightAnswers:)
    @NSManaged public func removeFromRawLastRightAnswers(_ values: NSOrderedSet)

}

extension GroupItem : Identifiable {

}

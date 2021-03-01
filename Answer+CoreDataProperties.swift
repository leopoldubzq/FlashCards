//
//  Answer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import Foundation
import CoreData


extension Answer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answer> {
        return NSFetchRequest<Answer>(entityName: "Answer")
    }

    @NSManaged public var definition: String?
    @NSManaged public var didAnswerCorrectly: Bool
    @NSManaged public var term: String?
    @NSManaged public var group: GroupItem?

}

extension Answer : Identifiable {

}

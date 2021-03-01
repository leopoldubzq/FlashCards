//
//  CorrectAnswer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import Foundation
import CoreData


extension CorrectAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CorrectAnswer> {
        return NSFetchRequest<CorrectAnswer>(entityName: "CorrectAnswer")
    }

    @NSManaged public var definition: String?
    @NSManaged public var term: String?
    @NSManaged public var group: GroupItem?

}

extension CorrectAnswer : Identifiable {

}

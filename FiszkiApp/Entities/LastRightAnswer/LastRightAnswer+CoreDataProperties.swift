//
//  LastRightAnswer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 04/02/2021.
//
//

import Foundation
import CoreData


extension LastRightAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastRightAnswer> {
        return NSFetchRequest<LastRightAnswer>(entityName: "LastRightAnswer")
    }

    @NSManaged public var term: String?
    @NSManaged public var definition: String?
    @NSManaged public var group: GroupItem?

}

extension LastRightAnswer : Identifiable {

}

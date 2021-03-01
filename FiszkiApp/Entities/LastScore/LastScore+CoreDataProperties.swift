//
//  LastScore+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 03/02/2021.
//
//

import Foundation
import CoreData


extension LastScore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastScore> {
        return NSFetchRequest<LastScore>(entityName: "LastScore")
    }

    @NSManaged public var term: String?
    @NSManaged public var definition: String?
    @NSManaged public var group: GroupItem?

}

extension LastScore : Identifiable {

}

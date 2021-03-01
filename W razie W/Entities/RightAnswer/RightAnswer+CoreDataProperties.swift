//
//  RightAnswer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 29/01/2021.
//
//

import Foundation
import CoreData


extension RightAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RightAnswer> {
        return NSFetchRequest<RightAnswer>(entityName: "RightAnswer")
    }

    @NSManaged public var term: String?
    @NSManaged public var definition: String?

}

extension RightAnswer : Identifiable {

}

//
//  WrongAnswer+CoreDataProperties.swift
//  FiszkiApp
//
//  Created by Leopold on 29/01/2021.
//
//

import Foundation
import CoreData


extension WrongAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WrongAnswer> {
        return NSFetchRequest<WrongAnswer>(entityName: "WrongAnswer")
    }

    @NSManaged public var term: String?
    @NSManaged public var definition: String?

}

extension WrongAnswer : Identifiable {

}

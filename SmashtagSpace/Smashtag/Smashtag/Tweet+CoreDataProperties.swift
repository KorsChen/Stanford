//
//  Tweet+CoreDataProperties.swift
//  Smashtag
//
//  Created by 陈志鹏 on 12/21/16.
//  Copyright © 2016 陈志鹏. All rights reserved.
//

import Foundation
import CoreData


extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet");
    }

    @NSManaged public var posted: Date?
    @NSManaged public var text: String?
    @NSManaged public var unique: String?
    @NSManaged public var tweeter: TwitterUser?

}

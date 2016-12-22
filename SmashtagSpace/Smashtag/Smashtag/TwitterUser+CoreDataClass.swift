//
//  TwitterUser+CoreDataClass.swift
//  Smashtag
//
//  Created by 陈志鹏 on 12/21/16.
//  Copyright © 2016 陈志鹏. All rights reserved.
//

import Foundation
import CoreData
import Twitter

@objc(TwitterUser)
public class TwitterUser: NSManagedObject
{
    class func twitterUserWithTwitterInfo(_ twitterInfo: Twitter.User, inManagedObjectContext context: NSManagedObjectContext) -> TwitterUser? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TwitterUser")
        request.predicate = NSPredicate(format: "screenName = %@", twitterInfo.screenName)
        if let twitterUser = (try? context.fetch(request))?.first as? TwitterUser {
            return twitterUser
        } else if let twitterUser = NSEntityDescription.insertNewObject(forEntityName: "TwitterUser", into: context) as?  TwitterUser {
            twitterUser.screenName = twitterInfo.screenName
            twitterUser.name = twitterInfo.name
            return twitterUser
        }
        
        return nil
    }
}

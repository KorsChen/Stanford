//
//  Tweet+CoreDataClass.swift
//  Smashtag
//
//  Created by 陈志鹏 on 12/21/16.
//  Copyright © 2016 陈志鹏. All rights reserved.
//

import Foundation
import CoreData
import Twitter

@objc(Tweet)
public class Tweet: NSManagedObject
{
    class func tweetWithTwitterInfo(_ twitterInfo: Twitter.Tweet, inManagedObjectContext context: NSManagedObjectContext) -> Tweet?
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tweet")
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id)
        if let tweet = (try? context.fetch(request))?.first as? Tweet {
            return tweet
        } else if let tweet = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: context) as? Tweet {
            tweet.unique = twitterInfo.id
            tweet.text = twitterInfo.text
            tweet.posted = twitterInfo.created
            tweet.tweeter = TwitterUser.twitterUserWithTwitterInfo(twitterInfo.user, inManagedObjectContext: context)
        }
        return nil
    }
}

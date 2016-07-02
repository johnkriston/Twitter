//
//  Tweet.swift
//  TwitterDemo
//
//  Created by John Kriston on 6/28/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import PrettyTimestamp


class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0 //retweet count
    var favoritesCount: Int = 0 //Like count or favorite count
    var twitterTimeStamp: String?
    var user: User?
    var idStr: String?
    var status: String?
    
    
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        idStr = dictionary["id_str"] as? String
        status = dictionary["status"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            twitterTimeStamp = timestamp?.prettyTimestampSinceNow()
        }
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    

}

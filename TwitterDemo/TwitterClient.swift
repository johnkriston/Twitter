//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by John Kriston on 6/28/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "LGiWhri7Mm3PuKtktfl8TkC85", consumerSecret: "iTGgkt8M8KfRPx6aZhUwdyeLWdoDCJpm5lHjaQmSEzmjZacmjq")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () ->(), failure: (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }

    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        
        
    }
    
    func handleOpenUrl(url: NSURL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
            })
        }) { (error: NSError!) -> Void in
            print("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }

    }
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()){
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })

        
    }
    
    func currentAccount(success: (User) -> (), failure: (NSError) -> ()){
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            /*print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagline)")
 */
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
    }
    
    func retweet(id : String, success: (Tweet) -> (), failure: (NSError) -> ()){
        print("1.1/statuses/retweet/\(id).json")
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: userDictionary)
            
            success(tweet)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
        
       
        

    }
 
    
    
    func favorite(id: String, success: (Tweet) -> (), failure: (NSError) -> ()){
        print("1.1/favorites/create.json?id=\(id)")
        POST("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let userDictionary = response as! NSDictionary
            let tweet = Tweet(dictionary: userDictionary)
            print("succeeded")
            success(tweet)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
                failure(error)
        })
        
        
    }
    
    func makeTweet(status: String, success: () -> (), failure: (NSError) -> ()){
        
        let params = ["status": status]
        
        print("1.1/statuses/udpate.json")
        POST("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("success")

            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("error: \(error.localizedDescription)")
        })
        
    
}
}

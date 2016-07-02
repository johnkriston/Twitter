//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by John Kriston on 6/28/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)


        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
           self.tweets = tweets
            for tweet in tweets {
                
            
            self.tableView.reloadData()
            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
    })
        // Do any additional setup after loading the view.
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets {
                
                self.tableView.reloadData()
                refreshControl.endRefreshing()
            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTweetButton(sender: AnyObject) {
         self.performSegueWithIdentifier("tweetSegue", sender: nil)
    }
    
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let tweets = tweets{
            return tweets.count
        } else{
            return 0
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("TwitterCell", forIndexPath: indexPath) as! TableViewCell
        
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        

        cell.tweetLabel.text = tweet.text as? String
        cell.timestampLabel.text = tweet.twitterTimeStamp
        cell.usernameLabel.text = tweet.user?.screenname as? String
        
        
        cell.nameLabel.text = tweet.user?.name as? String
       cell.posterView.setImageWithURL(tweet.user!.profileUrl!)
        
        cell.retweetLabel.text = String(tweet.retweetCount)
        cell.favoriteLabel.text = String(tweet.favoritesCount)

        
       
        
        
        
        
        //cell.textLabel!.text =
        return cell
    }

   @IBAction func onPosterViewTap(sender: AnyObject) {
        //performSegueWithIdentifier("randomProfileSegue", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "detailSegue" {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let tweet = tweets![indexPath!.row]
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        
        detailViewController.tweet = tweet
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    } else if segue.identifier == "randomProfileSegue" {
            
            let button = sender as! UIButton
            let contentView = button.superview
            let cell = contentView?.superview as! TableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            
            let randomProfileViewController = segue.destinationViewController as! RandomProfileViewController
            
            
            randomProfileViewController.tweet = tweet
        }
 
    
    }
}

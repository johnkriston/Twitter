//
//  RandomProfileViewController.swift
//  TwitterDemo
//
//  Created by John Kriston on 6/29/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit

class RandomProfileViewController: UIViewController {
    
    

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var taglineLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = tweet.user!.name as? String
        
        
        
        usernameLabel.text = tweet.user!.screenname as? String
        taglineLabel.text = tweet.user!.tagline as? String
        
        posterView.setImageWithURL((tweet.user!.profileUrl)!)
    
        if let fc = tweet.user?.followingCount{
            followingLabel.text = String(fc)
        }
        
        if let follc = tweet.user?.followersCount{
            followersLabel.text = String(follc)
        }
        
        if let tc = tweet.user?.tweetsCount{
            tweetLabel.text = String(tc)
        }
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

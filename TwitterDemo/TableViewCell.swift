//
//  TableViewCell.swift
//  TwitterDemo
//
//  Created by John Kriston on 6/29/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    var tweet: Tweet!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func retweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet.idStr!,
        success: {
            (tweet: Tweet) in
                self.retweetLabel.text = String(tweet.retweetCount)
        }){
            (error: NSError) in
                print(error)
        }
    }
    
    
    
    
    @IBAction func favorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet.idStr!,
        success: {
            (tweet: Tweet) in
                self.favoriteLabel.text = String(tweet.favoritesCount)
        }){
            (error: NSError) in
            print(error)
        }
    }


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

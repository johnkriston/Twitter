//
//  WriteTweetViewController.swift
//  TwitterDemo
//
//  Created by John Kriston on 6/29/16.
//  Copyright © 2016 John Kriston. All rights reserved.
//

import UIKit

class WriteTweetViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var text: UITextField!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Tweet(sender: AnyObject) {
        
     TwitterClient.sharedInstance.makeTweet(text.text!, success: { Void in
        
     }) { (Error: NSError) in
            print("error: \(Error.localizedDescription)")
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
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

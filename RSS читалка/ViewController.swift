//
//  ViewController.swift
//  RSS читалка
//
//  Created by Diy2210 on 03.11.14.
//  Copyright (c) 2014 Diy2210. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var feedURL = ""
    
    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.loadRequest(NSURLRequest(URL: NSURL(string: feedURL)!))
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

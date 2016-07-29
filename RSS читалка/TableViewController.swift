//
//  TableViewController.swift
//  RSS читалка
//
//  Created by Diy2210 on 03.11.14.
//  Copyright (c) 2014 Diy2210. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 70
        feeds = []
        let url: NSURL = NSURL(string:"http://www.pravda.com.ua/rus/rss/view_news/")!
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
        
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        element = elementName
        if (element as NSString).isEqualToString("item") {
            elements = NSMutableDictionary()
            elements = [:]
            ftitle = NSMutableString()
            ftitle = ""
            link = NSMutableString()
            link = ""
            fdescription = NSMutableString()
            fdescription = ""
            
        }
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if (elementName as NSString).isEqualToString("item") {
            
            if ftitle != "nil" {
                elements.setObject(ftitle, forKey: "title")
            }
            
            if link != "nil" {
                elements.setObject(link, forKey: "link")
            }
            if fdescription != "nil" {
                elements.setObject(fdescription, forKey: "description")
            }
            
            feeds.addObject(elements)
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if element.isEqualToString("title") {
           ftitle.appendString(string)
        } else if element.isEqualToString("link") {
           link.appendString(string)
        } else if element.isEqualToString("description") {
           fdescription.appendString(string)
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        
        self.tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return feeds.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = feeds.objectAtIndex(indexPath.row).objectForKey("title") as? String
        cell.detailTextLabel?.numberOfLines = 3
        cell.detailTextLabel?.text = feeds.objectAtIndex(indexPath.row).objectForKey("description") as? String
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "openPage" {
            
            let fwpvc: ViewController = segue.destinationViewController as! ViewController
            element =  element.stringByReplacingOccurrencesOfString("", withString:"")
            element =  element.stringByReplacingOccurrencesOfString("\n", withString:"")
            fwpvc.feedURL = element as String
            
}
}
}
//
//  BRTableViewController.swift
//  Light-NASA-RSS-Reader
//
//  Created by Павел Коюшев on 15.10.16.
//  Copyright © 2016 Павел Коюшев. All rights reserved.
//

import UIKit

class BRTableViewController: UITableViewController, XMLParserDelegate {

    var parser: XMLParser = XMLParser()
    var blogPosts: [Post] = []
    var postTitle: String = String()
    var postLink: String = String()
    var eName: String = String()
    
        var descriptions: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url:URL = URL(string: "https://www.nasa.gov/rss/dyn/breaking_news.rss")!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        eName = elementName
        if elementName == "item" {
            postTitle = String()
            postLink = String()
            descriptions = String()
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty) {
            if eName == "title" {
                postTitle += data
            } else if eName == "link" {
                postLink += data
            } else if eName == "description" {
                descriptions += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let blogPost: Post = Post()
            blogPost.postTitle = postTitle
            blogPost.postLink = postLink
            blogPost.descriptions = descriptions
            blogPosts.append(blogPost)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blogPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        let blogPost: Post = blogPosts[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = blogPost.postTitle
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)  {
        if segue.identifier == "viewpost" {
            let selectedRow = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row
            let blogPost: Post = blogPosts[selectedRow!]
            let viewController = segue.destination as! PostViewController
            viewController.postLink = blogPost.postLink
            
            let viewCont = segue.destination as! PostViewController
            viewCont.descriptions = blogPost.descriptions
        }
    }
}

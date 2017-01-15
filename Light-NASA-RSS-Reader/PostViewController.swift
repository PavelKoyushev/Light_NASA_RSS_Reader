//
//  PostViewController.swift
//  Light-NASA-RSS-Reader
//
//  Created by Павел Коюшев on 15.10.16.
//  Copyright © 2016 Павел Коюшев. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var desc: UITextView!
    
    var postLink: String = String()
    var descriptions: String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        let descript: String = String(descriptions)
        desc.text = "\(descript)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

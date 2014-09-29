//
//  URLController.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/28/14.
//
//

import UIKit

class URLController: UIViewController {
    var webView: UIWebView!
    var url: String!
    
    override func loadView() {
        super.loadView()
        self.webView = UIWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadURL()
    }
    
    func loadURL() {
        println(self.url)
        let requestUrl = NSURL(string: self.url)
        let request = NSURLRequest(URL: requestUrl)
        self.webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
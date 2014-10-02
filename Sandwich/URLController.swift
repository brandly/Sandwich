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
        self.webView = UIWebView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadURL()
    }
    
    func loadURL() {
        let requestUrl = NSURL(string: self.url)
        let request = NSURLRequest(URL: requestUrl)
        self.webView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
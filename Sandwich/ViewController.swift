//
//  ViewController.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/27/14.
//
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var postData = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Table view stuff
        let topBarHeight: CGFloat = 20
        self.tableView = UITableView(frame: CGRectMake(0, topBarHeight, self.view.bounds.width, self.view.bounds.height - topBarHeight), style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.view.addSubview(self.tableView)
        
        Reddit.getPosts("youtubehaiku", done: self.setPostData)
    }
    
    func setPostData(data: [NSDictionary]) {
        self.postData = data
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Table view data source delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        let post = self.postData[indexPath.row]
        newCell.textLabel?.text = post["title"] as? String
        
        // TODO: why doesn't this work
        if let ups = post["ups"] as? Int {
            newCell.detailTextLabel?.text = String(ups)
        }

        return newCell
    }
}


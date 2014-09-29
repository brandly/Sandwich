//
//  SubredditListController.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/28/14.
//
//

import UIKit

class SubredditListController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var textField: UITextField!
    var subreddits = [String]()
    var storageKey: String = "SubredditList"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "sandwich"
        
        // Table view stuff
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.view.addSubview(self.tableView)
        
        self.textField = UITextField(frame: CGRectMake(0, 0, self.view.bounds.width, 40))
        self.textField.placeholder = "Add a subreddit"
        self.textField.delegate = self
        
        self.tableView.tableHeaderView = self.textField
        
        // Goooooooo
        self.loadSubreddits()
    }
    
    func loadSubreddits() {
        var defaults = NSUserDefaults.standardUserDefaults()
        if let storedSubreddits = defaults.objectForKey(self.storageKey) as? [String] {
            self.subreddits = storedSubreddits
        } else {
            self.subreddits = []
        }
    }
    
    func addSubreddit(subreddit: String) {
        self.subreddits.append(subreddit)
        self.tableView.reloadData()
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(self.subreddits, forKey: self.storageKey)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table view data source delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subreddits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = self.subreddits[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let subreddit = self.subreddits[indexPath.row]
        let controller = SubredditController()
        controller.subreddit = subreddit
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.addSubreddit(textField.text)
        textField.text = ""
        return true
    }
}


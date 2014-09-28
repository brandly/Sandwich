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
    var refreshControl: UIRefreshControl!
    var textField: UITextField!
    var posts = [RedditPost]()
    var subreddit: String = "youtubehaiku"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sizing
        let topBarHeight: CGFloat = 20
        let textFieldHeight: CGFloat = 60
        let spaceAboveTableView: CGFloat = topBarHeight + textFieldHeight
        let textFieldPadding: CGFloat = 15
        
        
        // Table view stuff
        self.tableView = UITableView(frame: CGRectMake(0, spaceAboveTableView, self.view.bounds.width, self.view.bounds.height - spaceAboveTableView), style: UITableViewStyle.Plain)
        self.tableView.registerClass(DetailTableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.view.addSubview(self.tableView)
        
        
        // Refresh stuff
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.addSubview(refreshControl)
        
        
        // Text field stuff
        self.textField = UITextField(frame: CGRectMake(textFieldPadding, topBarHeight, (self.view.bounds.width - textFieldPadding * 2), spaceAboveTableView))
        self.textField.text = self.subreddit
        self.textField.delegate = self
        
        self.view.addSubview(self.textField)
        
        
        // Goooooooo
        self.loadPosts()
    }
    
    func loadPosts() {
        self.refreshControl.beginRefreshing()
        Reddit.getPosts(self.subreddit, done: self.setPosts)
    }
    
    func setPosts(data: [RedditPost]) {
        self.refreshControl.endRefreshing()
        self.posts = data
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Table view data source delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        let post = self.posts[indexPath.row]
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = "+" + String(post.score)

        return cell
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.subreddit = textField.text
        textField.resignFirstResponder()
        self.loadPosts()
        return true
    }
    
    // When refreshControl fires
    func refresh(sender: AnyObject) {
        self.loadPosts()
    }
}


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
    var posts = [RedditPost]()
    var refreshControl: UIRefreshControl!
    var subreddit: String = "youtubehaiku"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Table view stuff
        let topBarHeight: CGFloat = 20
        self.tableView = UITableView(frame: CGRectMake(0, topBarHeight, self.view.bounds.width, self.view.bounds.height - topBarHeight), style: UITableViewStyle.Plain)
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
        let newCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        let post = self.posts[indexPath.row]
        
        newCell.textLabel?.text = post.title
        newCell.detailTextLabel?.text = "+" + String(post.score)

        return newCell
    }
    
    func refresh(sender: AnyObject) {
        self.loadPosts()
    }
}

class DetailTableViewCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


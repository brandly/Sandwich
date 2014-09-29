//
//  ViewController.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/27/14.
//
//

import UIKit

class SubredditController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var posts = [RedditPost]()
    var subreddit: String! {
        didSet {
            self.title = self.subreddit
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Table view stuff
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Plain)
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
        self.tableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let post = self.posts[indexPath.row]
        let controller = PostController()
        controller.post = post
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // When refreshControl fires
    func refresh(sender: AnyObject) {
        self.loadPosts()
    }
}


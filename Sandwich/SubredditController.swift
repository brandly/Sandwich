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
    
    var loadingPosts = false

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
        if self.loadingPosts {
            return
        }
        
        self.loadingPosts = true
        if self.posts.isEmpty {
            self.getFrontPage()
        } else {
            self.getMorePosts()
        }
    }
    
    func getFrontPage() {
        self.refreshControl.beginRefreshing()
        Reddit.getPosts(self.subreddit, success: self.setPosts)
    }
    
    func loadNewPosts() {
        self.posts.removeAll()
        self.getFrontPage()
    }
    
    func setPosts(data: [RedditPost]) {
        self.refreshControl.endRefreshing()
        self.posts = data
        self.tableView.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        self.doneSettingPosts()
    }
    
    func getMorePosts() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        spinner.startAnimating()
        spinner.frame = CGRectMake(0, 0, 320, 44)
        self.tableView.tableFooterView = spinner
        
        Reddit.getPosts(self.subreddit, afterPost: self.posts.last, success: self.setMorePosts)
    }
    
    func setMorePosts(data: [RedditPost]) {
        self.posts += data
        self.tableView.tableFooterView = nil
        self.doneSettingPosts()
    }
    
    func doneSettingPosts() {
        self.tableView.reloadData()
        self.loadingPosts = false
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

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let actualPosition: CGFloat = scrollView.contentOffset.y
        let contentHeight: CGFloat = scrollView.contentSize.height - (self.view.bounds.size.height + 100)
        if (actualPosition >= contentHeight) {
            self.loadPosts()
        }
    }
    
    // When refreshControl fires
    func refresh(sender: AnyObject) {
        self.loadNewPosts()
    }
}


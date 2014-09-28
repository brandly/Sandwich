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
        
        Reddit.getPosts("youtubehaiku", done: self.setPosts)
    }
    
    func setPosts(data: [RedditPost]) {
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
}

class DetailTableViewCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//
//  ViewController.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/27/14.
//
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    var tableViewData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Table view stuff
        let topBarHeight: CGFloat = 20
        self.tableView = UITableView(frame: CGRectMake(0, topBarHeight, self.view.bounds.width, self.view.bounds.height - topBarHeight), style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.view.addSubview(self.tableView)
        
        self.loadData("youtubehaiku")
    }
    
    func loadData(subreddit: String) {
        var url = "http://www.reddit.com/r/" + subreddit + "/.json"
        Alamofire.request(.GET, url)
            .responseJSON { (_, _, responseData, error) in
                if let error = error {
                    println("ERROR", error);
                } else {
                    var allData: AnyObject? = responseData?["data"]
                    var childrenData: AnyObject? = allData?["children"]
                    
                    if var children = childrenData as? [NSDictionary] {
                        func parsePost(post: NSDictionary) -> NSDictionary {
                            return post["data"] as NSDictionary
                        }
                        var postData: [NSDictionary] = children.map(parsePost)
                        self.setPostData(postData)
                    }
                }
            }
    }
    
    func setPostData(data: [NSDictionary]) {
        func getTitle(post: NSDictionary) -> String {
            return post["title"] as String
        }
        self.tableViewData = data.map(getTitle)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Table view data source delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        newCell.textLabel?.text = self.tableViewData[indexPath.row]
        return newCell
    }
}


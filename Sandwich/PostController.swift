//
//  PostController.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/28/14.
//
//

import UIKit

//var author: String
//var domain: String
//var is_self: Bool
//var num_comments: UInt
//var over_18: Bool
//var score: Int
//var subreddit: String
//var subreddit_id: String
//var thumbnail: String
//var title: String
//var url: String

class PostController: UIViewController {
    var post: RedditPost!
    var titleLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        let padding: CGFloat = 15
        
        // I can't seem to assign it directly. There's probably a better way
        var headerHeight: CGFloat = 0
        if let height = self.navigationController?.navigationBar.frame.size.height {
            headerHeight = height + 20.0
        }

        self.titleLabel = UILabel(frame: CGRectMake(padding, headerHeight + padding, (self.view.bounds.width - padding * 2), 10))
        self.titleLabel.numberOfLines = 0
        
        // author, score, num_comments, thumbnail, link to url
        
        self.view.addSubview(self.titleLabel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleLabel.text = self.post.title
        self.titleLabel.autoresize()
    }
    
    func viewLink() {
        let controller = URLController()
        controller.url = self.post.url
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
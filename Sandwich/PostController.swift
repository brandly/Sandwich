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
    var thumbnailView: UIImageView!
    
    let padding: CGFloat = 15
    let thumbnailSize: CGFloat = 60
    
    override func loadView() {
        super.loadView()
        
        // I can't seem to assign it directly. There's probably a better way
        var headerHeight: CGFloat = 0
        if let height = self.navigationController?.navigationBar.frame.size.height {
            headerHeight = height + 20.0
        }

        let spaceLeftOfTitle: CGFloat = padding * 2 + thumbnailSize
        self.titleLabel = UILabel(frame: CGRectMake(spaceLeftOfTitle, headerHeight + padding, (self.view.bounds.width - spaceLeftOfTitle - padding), 10))
        self.titleLabel.numberOfLines = 0
        self.view.addSubview(self.titleLabel)

        // author, score, num_comments, thumbnail, link to url
        
        // Assume there's a thumbnail
        let linkButton: UIButton = UIButton(frame: CGRectMake(padding, headerHeight + thumbnailSize + padding, thumbnailSize, 50))
        linkButton.backgroundColor = UIColor.clearColor()
        linkButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        linkButton.titleLabel!.font =  UIFont(name: "Helvetica", size: 14)
        linkButton.setTitle("View Link", forState: UIControlState.Normal)
        linkButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(linkButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.titleLabel.text = self.post.title
 
        if let url: NSURL = self.post.getValidThumbnailURL() {
            var err: NSError?
            let imageData :NSData = NSData.dataWithContentsOfURL(url, options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &err)
            let thumbnailImage = UIImage(data: imageData)
            
            self.thumbnailView = UIImageView(image: thumbnailImage)
            self.thumbnailView.frame = CGRectMake(padding, self.titleLabel.frame.minY, thumbnailSize, thumbnailSize)
            self.view.addSubview(self.thumbnailView)
        } else { // No thumbnail
            let frame = self.titleLabel.frame
            self.titleLabel.frame = CGRectMake(padding, CGRectGetMinY(frame), (self.view.bounds.width - padding * 2), 10)
            self.titleLabel.autoresize()
            
        }
        self.titleLabel.autoresize()
    }
    
    func buttonAction(sender:UIButton!) {
        self.viewLink()
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
//
//  Reddit.swift
//  Sandwich
//
//  Created by Matthew Brandly on 9/27/14.
//
//

import Foundation
import Alamofire

class Reddit {
    class func getPostFullname(post: RedditPost) -> String {
        return "t3_\(post.id)"
    }
    
    class func getPosts(subreddit: String, success: (([RedditPost]) -> Void)) {
        Reddit.getPosts(subreddit, afterPost: nil, success: success)
    }
    
    class func getPosts(subreddit: String, afterPost: RedditPost?, success: (([RedditPost]) -> Void)) {
        var url = "http://www.reddit.com/r/" + subreddit + "/.json"
        var params = [String: AnyObject]()
        if let afterPost = afterPost {
            params = ["after": Reddit.getPostFullname(afterPost)]
        }
        Alamofire.request(.GET, url, parameters: params)
            .responseJSON { (_, _, responseData, error) in
                if let error = error {
                    println("ERROR", error);
                } else {
                    var allData: AnyObject? = responseData?["data"]
                    var childrenData: AnyObject? = allData?["children"]
                    
                    if var children = childrenData as? [NSDictionary] {
                        func parsePost(post: NSDictionary) -> RedditPost {
                            let postDictionary = post["data"] as NSDictionary
                            return RedditPost(data: postDictionary)
                        }
                        var postData: [RedditPost] = children.map(parsePost)
                        success(postData)
                    }
                }
        }
    }
}

class RedditPost {
    var author: String
    var domain: String
    var is_self: Bool
    var id: String
    var num_comments: UInt
    var over_18: Bool
    var score: Int
    var subreddit: String
    var subreddit_id: String
    var thumbnail: String?
    var title: String
    var url: String
    
    init(data: NSDictionary) {
        self.author = data["author"] as String
        self.domain = data["domain"] as String
        self.id = data["id"] as String
        self.is_self = data["is_self"] as Bool
        self.num_comments = data["num_comments"] as UInt
        self.over_18 = data["over_18"] as Bool
        self.score = data["score"] as Int
        self.subreddit = data["subreddit"] as String
        self.subreddit_id = data["subreddit_id"] as String
        self.title = data["title"] as String
        self.url = data["url"] as String
        
        // Reddit returns "self" for self posts, which isn't a url
        let thumbnail = data["thumbnail"] as String
        self.thumbnail = thumbnail != "self" ? thumbnail : nil
    }
}

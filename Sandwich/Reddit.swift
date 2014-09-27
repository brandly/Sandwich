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
    class func getPosts(subreddit: String, done: (([NSDictionary]) -> Void)) {
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
                        done(postData)
                    }
                }
        }
    }
}
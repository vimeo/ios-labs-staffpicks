//
//  VimeoClient.swift
//  StaffPicks
//
//  Created by Hanssen, Alfie on 6/18/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

typealias ServerResponseCallback = (videos: Array<Video>?, error: NSError?) -> Void

let BaseURL = "https://api.vimeo.com/"
let StaffPicksEndpoint = "channels/staffpicks/videos"
let AccessToken = "ccc022b6c3c6dcd2025cb92d7294dc07"

import Foundation

class VimeoClient {
    
    static func staffpicks(callback: ServerResponseCallback) {

        let staffpicksURL = NSURL(string: BaseURL + StaffPicksEndpoint)

        if let constStaffPicksURL = staffpicksURL
        {
            var request = NSMutableURLRequest(URL: constStaffPicksURL)
            request.addValue("Bearer " + AccessToken, forHTTPHeaderField: "Authorization")
            request.HTTPMethod = "GET"
            
            var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
                
                if error != nil
                {
                    println("request failed")
                    
                    callback(videos: nil, error: error)
                    
                    return
                }
                
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                println("data is \(dataString)")
                
                var JSONError: NSError?
                let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &JSONError) as? [String:AnyObject]
                
                println("dictionary is \(jsonDictionary)")
                
                if let constJsonDictionary = jsonDictionary
                {
                    let videos = constJsonDictionary["data"] as? [[String:AnyObject]]
                    
                    if let constVideos = videos
                    {
                        for jsonVideo in constVideos
                        {
                            // TODO 
                        }
                    }
                }
                
                
                callback(videos: [], error: nil)
            })
            
            task.resume()
        }
    }
    
}
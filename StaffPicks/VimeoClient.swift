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
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        callback(videos: nil, error: error)
                    })
                    
                    return
                }
                
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                var JSONError: NSError?
                let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &JSONError) as? [String:AnyObject]
                
                if let constJsonDictionary = jsonDictionary
                {
                    let videos = constJsonDictionary["data"] as? [[String:AnyObject]]
                    
                    if let constVideos = videos
                    {
                        var videoObjects: [Video] = []

                        for jsonVideo in constVideos
                        {
                            let title = jsonVideo["name"] as? String ?? "Untitled"
                            
                            if let user = jsonVideo["user"] as? [String:AnyObject], let name = user["name"] as? String
                            {
                                // TODO: use name
                            }
                            
                            var video = Video(title: title)
                                                        
                            videoObjects.append(video)
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            callback(videos: videoObjects, error: nil)
                        })
                        
                        return
                    }
                }
                
                let error = NSError(domain: "VimeoClient", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something is messed up with our JSON"])
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    callback(videos: nil, error: error)
                })
            })
            
            task.resume()
        }
    }
    
}
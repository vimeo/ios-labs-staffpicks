//
//  VimeoClient.swift
//  StaffPicks
//
//  Created by Hanssen, Alfie on 6/18/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

typealias ServerResponseCallback = (videos: Array<Video>?, error: NSError?) -> Void
typealias ServerLikeResponseCallback = (error: NSError?) -> Void

let BaseURL = "https://api.vimeo.com/"
let StaffPicksEndpoint = "channels/staffpicks/videos"
let MyVideosEndpoint = "me/videos"
let AccessToken = "GENERATE_AN_ACCESS_TOKEN"

import Foundation

class VimeoClient {
    
    static func staffpicks(callback: ServerResponseCallback) {
        self.requestEndpoint(StaffPicksEndpoint, callback: callback)
    }
    
    static func myVideos(callback: ServerResponseCallback) {
        self.requestEndpoint(MyVideosEndpoint, callback: callback)
    }
    
    static func likeVideo(video: Video, callback: ServerLikeResponseCallback) {
        if let likeVideoEndpoint = video.likeURI {
            self.requestEndpoint(likeVideoEndpoint, method: "PUT") { (videos, error) -> Void in
                callback(error: error)
            }
        }
        else {
            callback(error: NSError(domain: "NoLikeURIDomain", code: 0, userInfo: nil))
        }
    }
    
    static func requestEndpoint(endpoint: String, callback: ServerResponseCallback) {
        self.requestEndpoint(endpoint, method: "GET", callback: callback)
    }
    
    static func requestEndpoint(endpoint: String, method: String, callback: ServerResponseCallback) {
        
        let endpointURL = NSURL(string: BaseURL + endpoint)
        
        if let constEndpointURL = endpointURL
        {
            var request = NSMutableURLRequest(URL: constEndpointURL)
            request.addValue("Bearer " + AccessToken, forHTTPHeaderField: "Authorization")
            request.HTTPMethod = method
            
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
                            var video = Video(json: jsonVideo)
                            
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

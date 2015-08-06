//
//  Video.swift
//  StaffPicks
//
//  Created by Hanssen, Alfie on 6/18/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

import Foundation

class Video {
    
    var title: String
    var link: String?
    var playbackLink: String?
    
    init(json: [String:AnyObject]) {
        
        self.title = json["name"] as? String ?? "Untitled"
        
        var pictures = json["pictures"] as? [String:AnyObject]
        if let constPictures = pictures {
            
            var sizes = constPictures["sizes"] as? Array<[String:AnyObject]>
            
            if let constSizes = sizes where constSizes.count > 0 {
                
                var picture = constSizes[0]
                    
                self.link = picture["link"] as? String
            }
        }
        
        var files = json["files"] as? [[String:AnyObject]]
        if let files = files
        {
            if let firstFile = files.first
            {
                self.playbackLink = firstFile["link"] as? String
            }
        }
    }
}
//
//  VimeoClient.swift
//  StaffPicks
//
//  Created by Hanssen, Alfie on 6/18/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

typealias ServerResponseCallback = (videos: Array<Video>?, error: NSError?) -> Void

import Foundation

class VimeoClient {
    
    static func staffpicks(callback: ServerResponseCallback) {
        
        callback(videos: [], error: nil)
        
    }
    
}
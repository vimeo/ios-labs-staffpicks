//
//  VideoCell.swift
//  StaffPicks
//
//  Created by Hanssen, Alfie on 6/18/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    static let CellIdentifier = "VideoCellIdentifier"
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    var thumbnailRequest: NSURLSessionTask?
    
    var video: Video? {
        
        didSet {
            
            if let constVideo = video {
                
                self.videoTitleLabel.text = constVideo.title
                
                self.setupImageView()
                
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.thumbnailRequest?.cancel()
        
        self.videoTitleLabel.text = ""
        self.thumbnailImageView.image = nil
    }
    
    private func setupImageView() {
        
        if let imageLink = video?.link, let imageURL = NSURL(string: imageLink)
        {
            self.thumbnailRequest = NSURLSession.sharedSession().dataTaskWithURL(imageURL, completionHandler: { [weak self] (data, response, error) -> Void in
                
                if let strongSelf = self where strongSelf.video?.link == imageLink
                {
                    if error != nil
                    {
                        return
                    }
                    
                    if let imageData = data
                    {
                        let image = UIImage(data: imageData)
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            if let strongSelf = self where strongSelf.video?.link == imageLink
                            {
                                strongSelf.thumbnailImageView.image = image
                            }
                        })
                    }
                }
                
            })
            
            self.thumbnailRequest?.resume()
        }
    }
    
    deinit
    {
        self.thumbnailRequest?.cancel()
    }
}

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
        
        self.videoTitleLabel.text = ""
        
    }
    
    private func setupImageView() {
        
    }
    
}

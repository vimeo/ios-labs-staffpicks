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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor.magentaColor()
        
    }

}

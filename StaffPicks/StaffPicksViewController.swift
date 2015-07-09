//
//  StaffPicksViewController.swift
//  StaffPicks
//
//  Created by Zetterstrom, Kevin on 6/4/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {
        
    var items: [Video] = []

    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
  
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        
        self.tableView?.registerNib(nib, forCellReuseIdentifier: VideoCell.CellIdentifier)

        self.tableView?.dataSource = self
        
        VimeoClient.staffpicks { [weak self] (videos, error) -> Void in
            
            if let strongSelf = self {

                if let constError = error {
                    
                    println("Error fetching staffpicks! \(constError.localizedDescription)")
                    
                    return
                }
                
                assert(videos != nil, "videos array should never be nil")
                
                if let constVideos = videos {
                    
                    strongSelf.items = constVideos
                    
                    strongSelf.tableView?.reloadData()
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(VideoCell.CellIdentifier) as! VideoCell
        
        let index = indexPath.row
        let video = self.items[index]
        
        cell.textLabel?.text = video.title
        cell.detailTextLabel?.text = video.title
        
        return cell
    }
}

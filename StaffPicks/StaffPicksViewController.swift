//
//  StaffPicksViewController.swift
//  StaffPicks
//
//  Created by Zetterstrom, Kevin on 6/4/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {
    
    let cellIdentifier = "VideoCellIdentifier"
    
    var strings = ["one", "two", "three"]

    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView?.dataSource = self
    
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.strings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell
        
        let index = indexPath.row
        
        cell.textLabel?.text = strings[index]
        
        return cell
    }
}

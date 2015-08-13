//
//  VideoMetadataViewController.swift
//  StaffPicks
//
//  Created by Huebner, Rob on 8/6/15.
//  Copyright (c) 2015 Zetterstrom, Kevin. All rights reserved.
//

import UIKit
import MediaPlayer

class VideoMetadataViewController: UIViewController {
    
    var video: Video?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playerContainerView: UIView!
    
    var player: MPMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = video?.title
        
        self.setupPlayer()
    }
    
    private func setupPlayer() {
        
        if let playbackLink = self.video?.playbackLink,
            let playbackURL = NSURL(string: playbackLink)
        {
            let player = MPMoviePlayerController(contentURL: playbackURL)
            player.prepareToPlay()
            
            player.view.frame = self.playerContainerView.bounds
            
            self.playerContainerView.addSubview(player.view)
            
            self.player = player
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

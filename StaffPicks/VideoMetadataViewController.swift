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
        self.setupLikeButton()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.player?.play()
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
    
    private func setupLikeButton() {
        let likeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: Selector("likeButtonTapped"))
        self.navigationItem.rightBarButtonItem = likeButton
    }
    
    func likeButtonTapped() {
        let likeAlert = UIAlertController(title: "Like Video", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let likeAction = UIAlertAction(title: "Yes!", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            self.likeVideo()
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Destructive) { (action) -> Void in
            // do nothing
        }
        likeAlert.addAction(likeAction)
        likeAlert.addAction(cancelAction)
        self.presentViewController(likeAlert, animated: true, completion: nil)
    }
    
    private func likeVideo() {
        if let video = self.video {
            VimeoClient.likeVideo(video, callback: { (error) -> Void in
                print("\(error)")
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

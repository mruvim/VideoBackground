//
//  ExampleController.swift
//  VideoBackground
//
//  Created by Ruvim on 02/16/2017.
//  Copyright (c) 2017 Ruvim. All rights reserved.
//

import UIKit
import VideoBackground

class ExampleController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoView()
    }
    
    private func setupVideoView() {
        
        guard let videoPath = Bundle.main.path(forResource: "bg-video", ofType: "mov"),
            let imagePath = Bundle.main.path(forResource: "videoFirstFrame", ofType: "jpg") else {
                return
        }
        
        let options = VideoOptions(pathToVideo: videoPath, pathToImage: imagePath, isMuted: true, shouldLoop: true)
        let videoView = VideoBackground(frame: view.frame, options: options)
        view.addSubview(videoView)
    }
}

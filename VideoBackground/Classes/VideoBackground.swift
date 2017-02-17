//
//  VideoBackground.swift
//  VideoBackground
//
//  Created by Ruvim Micsanschi on 2/15/17.
//  Copyright © 2017 com.codingroup. All rights reserved.
//

import UIKit
import AVKit
import Foundation
import AVFoundation


/**
 Video options
 
 - Parameters:
 -      pathToVideo: String path to a video on disk
 -      pathToImage: String path to an image on disk
 -      isMuted:     Bool flag to control sound
 -      shouldLoop:  Bool flag to control looping
 */
public struct VideoOptions {
    let pathToVideo:String
    let pathToImage:String
    let isMuted:Bool
    let shouldLoop:Bool
    
    public init(pathToVideo:String, pathToImage:String, isMuted:Bool = true, shouldLoop:Bool = true) {
        self.pathToVideo = pathToVideo
        self.pathToImage = pathToImage
        self.isMuted = isMuted
        self.shouldLoop = shouldLoop
    }
}

/**
 VideoBackground view
 */
final public class VideoBackground: UIView {
    
    private var imageView:UIImageView?
    private var videoView:VideoBackgroundView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - frame: view frame
    ///   - options: VideoOptions struct
    convenience public init(frame: CGRect, options:VideoOptions) {
        self.init(frame:frame)
        
        let placeholderImageView = UIImageView(frame: frame)
        placeholderImageView.contentMode = .scaleAspectFill
        placeholderImageView.image = loadImage(at: options.pathToImage)
        placeholderImageView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        addSubview(placeholderImageView)
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        placeholderImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        placeholderImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        placeholderImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        let videoView = VideoBackgroundView(frame: frame, options: options)
        videoView.readyForDisplay = readyToDisplay
        
        self.imageView = placeholderImageView
        self.videoView = videoView
    }
    
    private func readyToDisplay() {
        guard let videoView = videoView, let imageView = imageView else { return }
        UIView.transition(from: imageView, to: videoView, duration:0.25, options: .transitionCrossDissolve) { (_) in
            imageView.removeFromSuperview()
        }
    }
    
    private func loadImage(at path:String) -> UIImage? {
        guard let imageData = try? Data(contentsOf: URL(fileURLWithPath: path)), let image = UIImage(data:imageData) else {
            return nil
        }
        return image
    }
}


/**
 VideoBackgroundView - Private class
 */
final private class VideoBackgroundView : UIView {
    
    private var playerLayer:AVPlayerLayer?
    private var timer: Timer?
    private var timerCount = 0
    var readyForDisplay:(() -> Void)?
    
    
    convenience init(frame: CGRect, options:VideoOptions) {
        self.init(frame:frame)
        setupPlayer(with: options)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
        invalidateTimer()
    }
    
    private func setupPlayer(with options:VideoOptions) {
        
        let player = AVPlayer(url:URL(fileURLWithPath: options.pathToVideo))
        player.actionAtItemEnd = .none
        player.isMuted = options.isMuted
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.frame = bounds
        self.playerLayer = playerLayer
        layer.addSublayer(playerLayer)
        
        timer = Timer.scheduledTimer(timeInterval:0.2, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        
        
        if options.shouldLoop {
            NotificationCenter.default.addObserver(self, selector: #selector(startFromBeginning), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(resumePlaying), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pausePlaying), name: .UIApplicationWillResignActive, object: nil)
    }
    
    func startFromBeginning(notification:Notification) {
        guard let player = playerLayer?.player else { return }
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    func resumePlaying(notification:Notification) {
        guard let player = playerLayer?.player else { return }
        player.play()
    }
    
    func pausePlaying(notification:Notification) {
        guard let player = playerLayer?.player else { return }
        player.pause()
    }
    
    func timerFired() {
        
        guard let playerLayer = playerLayer, timerCount < 60 else {
            invalidateTimer()
            return
        }
        
        if playerLayer.isReadyForDisplay {
            playerLayer.player?.play()
            invalidateTimer()
            readyForDisplay?()
        }
        
        timerCount += 1
    }
    
    private func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }
}

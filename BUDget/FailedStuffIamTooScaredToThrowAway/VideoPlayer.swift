//
//  VideoPlayer.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 11/11/23.
//

import UIKit
import AVKit
import AVFoundation
import SpriteKit

class VideoPlayer: SKScene{
    
    var videoRect = CGRect()
    var videoView = UIView()
    var player: AVPlayer?
    var ratio = 2
    var width = 400
    var playButton = SKSpriteNode()
    var exitButton = SKSpriteNode()
    var playing = false
    var videoLooper: AVPlayerLooper?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        videoRect = CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: view.frame.width / 1.3, height: view.frame.height / 1.3)
        videoView.frame = videoRect
        videoView.layer.position = CGPoint(x: view.frame.width / 2, y: view.frame.height/2)
    
        playButton = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 0, y: 0), texture: playTexture, scale: 0.5)
        
        exitButton = addEscapeButton(sceneTo: self)
        exitButton.texture = whiteOutExit
        exitButton.setScale(0.075)
        
        playVideo(url: VideoUrl)
        player?.pause()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
        
        
//        let url = URL(string: "https://americanfuzz.github.io/BUDget/IMG_3331%202.mov")!
//        let asset = AVAsset(url: url)
//        let item = AVPlayerItem(asset: asset)
//        let DisposablePlayer = AVQueuePlayer(playerItem: item)
//        videoLooper = AVPlayerLooper(player: DisposablePlayer, templateItem: item)
    
    }
    
    func playVideo(url: String){
        //let videoURL = URL(string: url)
        guard let path = Bundle.main.path(forResource: "GregLane_DispoVsIndispo", ofType: "mov")else{
            print("no url")
            return
        }
        print("url step")
        let videoURL = URL(fileURLWithPath: path)
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.cornerRadius = 5
        playerLayer.masksToBounds = true
        videoView.layer.addSublayer(playerLayer)
        self.view?.addSubview(videoView)
        player?.play()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if exitButton.contains(position){
                moveToScene(sceneTo: VideosScene(size: self.size), sceneFrom: self)
                videoView.removeFromSuperview()
            }
            if playButton.contains(position){
                playing.toggle()
                if playing{
                    player?.play()
                }else{
                    player?.pause()
                }
            }
        }
    }
}

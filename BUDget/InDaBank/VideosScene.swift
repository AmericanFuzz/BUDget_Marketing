//
//  VideoScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/23/23.
//

import Foundation
import SpriteKit
import AVFoundation
import AVKit
import UIKit


class VideosScene: SKScene{
    
    var bud = SKSpriteNode()
    var tableIsUp: Bool = true
    var Table = SKSpriteNode()
    var Profile = SKSpriteNode()
    var Map = SKSpriteNode()
    var Shop = SKSpriteNode()
    var Videos = SKSpriteNode()
    var escapeButton = SKSpriteNode()
    var video = SKSpriteNode()
    var video2 = SKSpriteNode()
    var video3 = SKSpriteNode()
    var video4 = SKSpriteNode()
    var video5 = SKSpriteNode()
    var video6 = SKSpriteNode()
    var video7 = SKSpriteNode()
    var video8 = SKSpriteNode()
    var video9 = SKSpriteNode()
    var video10 = SKSpriteNode()
    var videoLabel = SKLabelNode()
    var videoLabel2 = SKLabelNode()
    var videoLabel3 = SKLabelNode()
    var videoLabel4 = SKLabelNode()
    var videoLabel5 = SKLabelNode()
    var videoLabel6 = SKLabelNode()
    var videoLabel7 = SKLabelNode()
    var videoLabel8 = SKLabelNode()
    var videoLabel9 = SKLabelNode()
    var videoLabel10 = SKLabelNode()
    var videoLabelArray: [SKLabelNode] = []
    var videosArray: [SKSpriteNode] = []
    var killSwitch: Bool = false
    var videosY: CGFloat = 0
    var title = SKLabelNode()
    var subTitle = SKLabelNode()
    var startingPoint = CGPoint(x: 0, y: 0)
    var caughtFirstPoint: Bool = false
    var currentPoint = CGPoint()
    var originalLeadPoint: CGFloat = 400
    var followersArray: [SKSpriteNode] = []
    var glitchKill: Bool = false
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        originalLeadPoint = videosY
        
        escapeButton = addEscapeButton(sceneTo: self)
        title = addLabel(sceneTo: self, scale: 50, position: CGPoint(x: 80, y: 500), color: .black, text: "Videos", zPosition: 10)
        
        videosArray.append(contentsOf: [video, video2, video3, video4, video5, video6, video7, video8, video9, video10])
        
        videoLabelArray.append(contentsOf: [videoLabel, videoLabel2, videoLabel3, videoLabel4, videoLabel5, videoLabel6, videoLabel7, videoLabel8, videoLabel9, videoLabel10])
        
        for index in videosArray.indices{
            videosArray[index] = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 75, y: videosY), texture: videoTemplate, scale: 0.4)
            videosY -= 100
        }
        
        for index in videoLabelArray.indices{
            videoLabelArray[index] = addLabel(sceneTo: self, scale: 35, position: CGPoint(x: 120, y: 0), color: .white, text: "", zPosition: 2)
        }
        
        video = videosArray[0]
        video2 = videosArray[1]
        video3 = videosArray[2]
        video4 = videosArray[3]
        video5 = videosArray[4]
        video6 = videosArray[5]
        video7 = videosArray[6]
        video8 = videosArray[7]
        video9 = videosArray[8]
        video10 = videosArray[9]
        
        videoLabel = videoLabelArray[0]
        videoLabel2 = videoLabelArray[1]
        videoLabel3 = videoLabelArray[2]
        videoLabel4 = videoLabelArray[3]
        videoLabel5 = videoLabelArray[4]
        videoLabel6 = videoLabelArray[5]
        videoLabel7 = videoLabelArray[6]
        videoLabel8 = videoLabelArray[7]
        videoLabel9 = videoLabelArray[8]
        videoLabel10 = videoLabelArray[9]
        
        videoLabel.text = "Dispo vs. Indispo"
        videoLabel2.text = "Fin Investment"
        videoLabel3.text = "Dispo vs. Indispo"
        videoLabel4.text = "Fin Investment"
        videoLabel5.text = "Dispo vs. Indispo"
        videoLabel6.text = "Fin Investment"
        videoLabel7.text = "Dispo vs. Indispo"
        videoLabel8.text = "Fin Investment"
        videoLabel9.text = "Dispo vs. Indispo"
        videoLabel10.text = "Fin Investment"
        
        followersArray = videosArray
        followersArray.removeFirst()
    
        videosY = 100
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }
    
    @objc func pinchReaction(){
        dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "BankBL", k_switch: &killSwitch)
    }
    
    func convertDistanceToAlpha(distance: CGFloat) -> CGFloat{
        var absoluteDistance = distance
        getAbsoluteValue(CGFloatValue: &absoluteDistance)
        var alphaFraction = 1 - (absoluteDistance / 400)
        
        if alphaFraction < 0{
            alphaFraction = 0
        }
        
        return alphaFraction
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            
            if escapeButton.contains(position){
                dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "BankBL", k_switch: &killSwitch)
            }
            
            if video.contains(position){
                VideoUrl = "GregLane_DispoVsIndispo"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                //moveToScene(sceneTo: VideoPlayer(size: self.size), sceneFrom: self)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video2.contains(position){
                VideoUrl = "GregLane_FinInvestment"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video3.contains(position){
                VideoUrl = "GregLane_DispoVsIndispo"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video4.contains(position){
                VideoUrl = "GregLane_FinInvestment"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video5.contains(position){
                VideoUrl = "GregLane_DispoVsIndispo"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video6.contains(position){
                VideoUrl = "GregLane_FinInvestment"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video7.contains(position){
                VideoUrl = "GregLane_DispoVsIndispo"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video8.contains(position){
                VideoUrl = "GregLane_FinInvestment"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video9.contains(position){
                VideoUrl = "GregLane_DispoVsIndispo"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            if video10.contains(position){
                VideoUrl = "GregLane_FinInvestment"
                presentVideo(sceneFrom: self, videoPath: VideoUrl)
                budCoin += 5
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "videoLibrary", transactionAmount: 5, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            
            if !caughtFirstPoint{
                caughtFirstPoint = true
                startingPoint = position
                startingPoint.y += 1000
            }
            
            currentPoint.y = position.y + 1000
            
            let delta = currentPoint.y - startingPoint.y
            
            //boundries for now are 0 - 900 for "video" lead
            let vY = video.position.y
            
            if vY < 0{
                video.position.y = 0
                glitchKill = true
            }else if vY > 900{
                video.position.y = 900
                glitchKill = true
            }else if !glitchKill{
                video.position.y = delta + originalLeadPoint
            }

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        caughtFirstPoint = false
        originalLeadPoint = video.position.y
        glitchKill = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        for index in videosArray.indices{
            let alphaValue = convertDistanceToAlpha(distance: videosArray[index].position.y)
            videosArray[index].alpha = alphaValue
            videosY = 100
            let compensateLabelCorner = 15.0
            videoLabel.position.y = video.position.y - compensateLabelCorner
            for index in followersArray.indices{
                followersArray[index].position.y = video.position.y - videosY
                videoLabelArray[index + 1].position.y = followersArray[index].position.y - compensateLabelCorner
                videosY += 100
            }
        }
    }
}



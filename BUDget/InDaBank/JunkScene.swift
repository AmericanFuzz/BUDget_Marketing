//
//  JunkScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 10/29/23.
//

import Foundation
import SpriteKit

class JunkScene: SKScene{
    
    var credits = SKLabelNode()
    var Programming = SKLabelNode()
    var Graphics = SKLabelNode()
    var StoryBoard = SKLabelNode()
    var Officials = SKLabelNode()
    var RealHeroes = SKLabelNode()
    var bitMe = SKLabelNode()
    var newBebe = SKLabelNode()
    var sponsors = SKLabelNode()
    var sponsorLogo = SKSpriteNode()
    var escapeButton = SKSpriteNode()
    var killSwitch: Bool = false
    var subtitleSize: CGFloat = 20
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        escapeButton = addEscapeButton(sceneTo: self)
        
        credits = addLabel(sceneTo: self, scale: 50, position: CGPoint(x: 0, y: 500), color: .black, text: "About the Team:", zPosition: 0)
        
        Programming = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: 350), color: .black, text: "Programming: Sebastian Kazakov", zPosition: 0)
        
        Graphics = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: 250), color: .black, text: "Graphics: Gabby, Nicole, and Yaroslava Kazakova", zPosition: 0)
        
        StoryBoard = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: 150), color: .black, text: "StoryBoard: Gabby, Nicole, and Sebastian Kazakov", zPosition: 0)
        
        Officials = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: 50), color: .black, text: "Official Paperwork: Gabby & Nicole", zPosition: 0)
        
        RealHeroes = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: -50), color: .black, text: "True Heroes: Teymur Kazakov & Elena Mytarkina", zPosition: 0)
        
        bitMe = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: -150), color: .black, text: "Bit Me: Vasilisa Kazakova", zPosition: 0)
        
        newBebe = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: -250), color: .black, text: "New addition: Frederica Kazakova", zPosition: 0)
        
        sponsors = addLabel(sceneTo: self, scale: subtitleSize, position: CGPoint(x: 0, y: -350), color: .black, text: "Our proud sponsor: Northeaston Bank", zPosition: 0)
        
        sponsorLogo = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: -500), texture: northEastonLogo, scale: 0.5)
        
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }
    
    @objc func pinchReaction(){
        dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "BankBR", k_switch: &killSwitch)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            
            if escapeButton.contains(position){
                dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "BankBR", k_switch: &killSwitch)
            }
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}

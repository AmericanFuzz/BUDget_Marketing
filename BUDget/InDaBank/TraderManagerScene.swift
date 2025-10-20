//
//  InvestorManager.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 11/26/23.
//

import Foundation
import SpriteKit


class TraderManagerScene: SKScene{
    
    var escapeButton = SKSpriteNode()
    var recorder = SKCameraNode()
    var yPosition: CGFloat = -100
    var minimumY: CGFloat = 0
    var killSwitch: Bool = false
    
    override func didMove(to view: SKView){
        self.backgroundColor = .lightGray
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.camera = recorder
        self.addChild(recorder)
        
        escapeButton = addEscapeButton(sceneTo: self)
        escapeButton.position = CGPoint(x: 0, y: 0)
        
        for index in traderDetailsDatabase.indices{
            let detailsArray = traderDetailsDatabase[index] as! [Any]
            // 0 is alias
            // 1 is deal
            // 2 is UIImage
            // 3 is dealReturn
            // 4 is isActive
            // 5 is randomOutcome
            // 6 is magnification
            // 7 is floating point for return profit/deduction
            // 8 is cooldown increment
            // 9 is net profit after all deals in relation to player
            let txtr = detailsArray[2] as! Data
            let image = UIImage(data: txtr)!
            let texture = SKTexture(image: image)
            
            let ntRtns = detailsArray[9] as! String
            let netReturn = Int(ntRtns)!
            
            let alias = detailsArray[0] as! String
            
            let cldwnIncrmnt = detailsArray[8] as! String
            let cooldownIncrement = Int(cldwnIncrmnt)!
            
            createTraderRow(texture: texture, netReturn: netReturn, alias: alias, cooldownIncrement: cooldownIncrement)
        }
        minimumY = CGFloat(traderDetailsDatabase.count * -250)
        
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }
    
    @objc func pinchReaction(){
        moveToScene(sceneTo: BankScene(size: self.size), sceneFrom: self)
        sceneSetTo = "TellerHome"
    }
    
    func createTraderRow(texture: SKTexture, netReturn: Int, alias: String, cooldownIncrement: Int){
        let _ = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: -200, y: yPosition), texture: texture, scale: 0.2)
        let label = addLabel(sceneTo: self, scale: 20, position: CGPoint(x: 50, y: yPosition), color: .black, text: "name: \(alias), time: \(cooldownIncrement), netReturn: \(netReturn)", zPosition: 0)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.preferredMaxLayoutWidth = 300.0
        label.numberOfLines = 2
        yPosition -= 250
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            
            if escapeButton.contains(position){
                moveToScene(sceneTo: BankScene(size: self.size), sceneFrom: self)
                sceneSetTo = "TellerHome"
            }else{
                if recorder.position.y <= 0 && recorder.position.y >= minimumY{
                    recorder.run(SKAction.moveTo(y: position.y, duration: 0.25))
                }else if recorder.position.y > 0{
                    recorder.run(SKAction.moveTo(y: 0, duration: 0))
                }else if recorder.position.y < minimumY{
                    recorder.run(SKAction.moveTo(y: minimumY, duration: 0))
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if recorder.position.y > 0{
            recorder.removeAllActions()
            recorder.run(SKAction.moveTo(y: 0, duration: 0))
        }else if recorder.position.y < minimumY{
            recorder.removeAllActions()
            recorder.run(SKAction.moveTo(y: minimumY, duration: 0))
        }
    }
}

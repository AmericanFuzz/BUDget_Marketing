//
//  DatabaseScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 11/26/23.
//

import Foundation
import SpriteKit


class DatabaseScene: SKScene{
    
    var labelY = 0
    var recorder = SKCameraNode()
    var escapeButton = SKSpriteNode()
    var minimumY = CGFloat(transactionRecords.count * -100)
    var killSwitch: Bool = false
    
    override func didMove(to view: SKView){
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.camera = recorder
        self.addChild(recorder)
        
        escapeButton = addEscapeButton(sceneTo: self)
        escapeButton.position = CGPoint(x: 0, y: 150)
        
        for index in transactionRecords.indices{
            makeLabelForTransaction(stringValue: transactionRecords[index])
        }
        
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }

    func makeLabelForTransaction(stringValue: String){
        let label = addLabel(sceneTo: self, scale: 25, position: CGPoint(x: 0, y: labelY), color: .black, text: stringValue, zPosition: 1)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.preferredMaxLayoutWidth = 500.0
        label.numberOfLines = 2
        labelY -= 100
    }
    
    @objc func pinchReaction(){
        moveToScene(sceneTo: BankScene(size: self.size), sceneFrom: self)
        sceneSetTo = "TellerHome"
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

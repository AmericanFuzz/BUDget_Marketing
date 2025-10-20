//
//  ProfileScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/23/23.
//

import Foundation
import SpriteKit

class ProfileScene: SKScene{
    
    var budMain = Item()
    var budRed = Item()
    var budOrange = Item()
    var budYellow = Item()
    var budLightGreen = Item()
    var budDarkGreen = Item()
    var budLightBlue = Item()
    var budDarkBlue = Item()
    var budPurple = Item()
    var budPink = Item()
    var budBrown = Item()
    var budMagenta = Item()
    var budGrey = Item()
    var budArray: [Item] = []
    var budMainOriginalPos = CGPoint()
    var budIncrement = 0
    var incrementSpace = 200
    var baseNum = 200
    
    var bitNone = Item()
    var bitRed = Item()
    var bitOrange = Item()
    var bitYellow = Item()
    var bitLightGreen = Item()
    var bitDarkGreen = Item()
    var bitBlue = Item()
    var bitViolet = Item()
    var bitPurple = Item()
    var bitHotPink = Item()
    var bitPink = Item()
    var bitBrown = Item()
    var bitGrey = Item()
    var bitArray: [Item] = []
    var bitMainOriginalPosX = CGFloat()
    var bitIncrement = 0
    var bitIncrementSpace = 200
    var bitBaseIncrement = 200
    var currentBitTexture = SKTexture()
    
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    var Xdifference: CGFloat = 0
    var Ydifference: CGFloat = 0
    var onceSwitchIsOn = false
    
    var budTextureLocal = SKTexture()
    var budProfile = SKSpriteNode()
    var bitProfile = SKSpriteNode()
    var bpTexture = SKTexture()
    var bitProfileTexture = SKTexture()
    
    var videoCamera = SKCameraNode()
    var glitchKill: Bool = false
    var escapeButton = SKSpriteNode()
    var killSwitch: Bool = false
    
    var wrenchBought = Bool()
    var wrenchCounter: Int = 0
    var wrenchPosition = CGPoint()
    var delay: TimeInterval = 0

    var selectiveState: String = "home"
    //OPTIONS:
    //
    //budSelection
    //bitSelection
  
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.camera = videoCamera
        self.addChild(videoCamera)
        
        extractPNG(forVariable: &bpTexture)
        extractBitPNG(forVariable: &bitProfileTexture)
        escapeButton = addEscapeButton(sceneTo: self)
        budProfile = addBUD(sceneTo: self, texture: bpTexture, position: CGPoint(x: 0, y: 0), scale: 0.35)
        bitProfile = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 200, y: 300), texture: bitProfileTexture, scale: 0.5)
        
        addBUDS()
        addBits()
        wrenchesAnimation()
        
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }
    
    @objc func pinchReaction(){
        dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "BankL", k_switch: &killSwitch)
    }
    
    func addBUDS(){
        budArray.append(contentsOf: [budMain, budRed, budOrange, budYellow, budLightGreen, budDarkGreen, budLightBlue, budDarkBlue, budPurple, budPink, budMagenta, budBrown, budGrey])
        
        for index in budArray.indices{
            switch budIncrement{
            case 0:
                budTextureLocal = defaultBud
            case (incrementSpace):
                budTextureLocal = redBud
            case (incrementSpace*2):
                budTextureLocal = orangeBud
            case (incrementSpace*3):
                budTextureLocal = yellowBud
            case (incrementSpace*4):
                budTextureLocal = lightGreenBud
            case (incrementSpace*5):
                budTextureLocal = darkGreenBud
            case (incrementSpace*6):
                budTextureLocal = lightBlueBud
            case (incrementSpace*7):
                budTextureLocal = darkBlueBud
            case (incrementSpace*8):
                budTextureLocal = purpleBud
            case (incrementSpace*9):
                budTextureLocal = pinkBud
            case (incrementSpace*10):
                budTextureLocal = magentaBud
            case (incrementSpace*11):
                budTextureLocal = brownBud
            case (incrementSpace*12):
                budTextureLocal = greyBud
            default:
                break
            }
            let indexPoint = (budIncrement) / incrementSpace
            let boolPoint = budColors[indexPoint]
            budArray[index] = Item(texture: budTextureLocal)
            budArray[index].setUpItem(sceneFor: self, texture: budTextureLocal, position: CGPoint(x: 0, y: budIncrement + 1000), scale: 0.175, purchasedItem: boolPoint, indexOnArray: 0)
            if budArray[index].purchased{
                budArray[index].alpha = 1
            }else{
                budArray[index].alpha = 0.5
                let bP = budArray[index].position
                let lock = addSprite(sceneTo: self, zPosition: CGFloat(budIncrement), position: bP, texture: lockTexture, scale: 0.15)
                lock.alpha = 1
                lock.name = "lock"
            }
            budIncrement += baseNum
        }
        
        budMain = budArray[0]
        budRed = budArray[1]
        budOrange = budArray[2]
        budYellow = budArray[3]
        budLightGreen = budArray[4]
        budDarkGreen = budArray[5]
        budLightBlue = budArray[6]
        budDarkBlue = budArray[7]
        budPurple = budArray[8]
        budPink = budArray[9]
        budMagenta = budArray[10]
        budBrown = budArray[11]
        budGrey = budArray[12]
        
        budMainOriginalPos = budMain.position
    }
    
    func addBits(){
        bitArray.append(contentsOf: [bitNone, bitRed, bitOrange, bitYellow, bitLightGreen, bitDarkGreen, bitBlue, bitViolet, bitPurple, bitHotPink, bitPink, bitBrown, bitGrey])
        
        for index in bitArray.indices{
            currentBitTexture = bitTexturePallet[index]
            
            let purchasedThisBit = bitColors[index]
            bitArray[index] = Item(texture: currentBitTexture)
            bitArray[index].setUpItem(sceneFor: self, texture: currentBitTexture, position: CGPoint(x: 1000 + bitIncrement, y: 300), scale: 0.5, purchasedItem: purchasedThisBit, indexOnArray: 0)
            if bitArray[index].purchased{
                bitArray[index].alpha = 1
            }else{
                bitArray[index].alpha = 0.5
                let bitPosition = bitArray[index].position
                let bitLock = addSprite(sceneTo: self, zPosition: CGFloat(bitIncrement), position: bitPosition, texture: lockTexture, scale: 0.125)
                bitLock.name = "bitLock"
            }
            bitIncrement += bitIncrementSpace
        }
        
        bitNone = bitArray[0]
        bitRed = bitArray[1]
        bitOrange = bitArray[2]
        bitYellow = bitArray[3]
        bitLightGreen = bitArray[4]
        bitDarkGreen = bitArray[5]
        bitBlue = bitArray[6]
        bitViolet = bitArray[7]
        bitPurple = bitArray[8]
        bitHotPink = bitArray[9]
        bitPink = bitArray[10]
        bitBrown = bitArray[11]
        bitGrey = bitArray[12]
        
        bitMainOriginalPosX = bitNone.position.x
    }
    
    func wrenchesAnimation(){
        let setUpWrench = SKAction.run {self.setUpWrench()}
        let addWrench = SKAction.run{self.addWrench(bought: self.wrenchBought, position: self.wrenchPosition)}
        let spawnDelay = SKAction.wait(forDuration: 0.05)
        let compactWrenches = SKAction.run{self.compactWrenches(speed: 0.5)}
        self.run(SKAction.repeat(SKAction.sequence([setUpWrench, addWrench, spawnDelay, compactWrenches]), count: 25))
    }
    
    func setUpWrench(){
        let difference = wrenchCounter - wrenchCount
        if difference < 0{
            wrenchBought = true
        }else{
            wrenchBought = false
        }
        let yOffset = 0
        if wrenchCounter < 5{
            wrenchPosition = CGPoint(x: -200, y: -300 + yOffset)
            wrenchPosition.x += CGFloat(wrenchCounter * 100)
        }else if wrenchCounter < 10{
            wrenchPosition = CGPoint(x: 250, y: -380 + yOffset)
            let neoCounter = wrenchCounter - 5
            wrenchPosition.x += CGFloat(-neoCounter * 100)
        }else if wrenchCounter < 15{
            wrenchPosition = CGPoint(x: -200, y: -460 + yOffset)
            let neoCounter = wrenchCounter - 10
            wrenchPosition.x += CGFloat(neoCounter * 100)
        }else if wrenchCounter < 20{
            wrenchPosition = CGPoint(x: 250, y: -540 + yOffset)
            let neoCounter = wrenchCounter - 15
            wrenchPosition.x += CGFloat(-neoCounter * 100)
        }else{
            wrenchPosition = CGPoint(x: -200, y: -620 + yOffset)
            let neoCounter = wrenchCounter - 20
            wrenchPosition.x += CGFloat(neoCounter * 100)
        }
        wrenchCounter += 1
    }
    
    func addWrench(bought: Bool, position: CGPoint){
        var localTexture = wrenchNilTexture
        if bought{
            localTexture = wrenchTexture
        }
        let wrench = addSprite(sceneTo: self, zPosition: 0, position: position, texture: localTexture, scale: 0.1)
        wrench.name = "wrench"
    }
    
    func compactWrenches(speed: CGFloat){
        if wrenchCounter == 25{
            for child in self.children{
                if child.name == "wrench"{
                    let sprite = child as? SKSpriteNode
                    if sprite!.texture == wrenchTexture{
                        sprite?.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 0, y: 0), duration: speed), SKAction.removeFromParent()]))
                    }else{
                        sprite?.run(SKAction.sequence([SKAction.fadeOut(withDuration: speed), SKAction.removeFromParent()]))
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)

            if budProfile.contains(position){
                selectiveState = "budSelection"
                bitProfile.run(SKAction.move(to: CGPoint(x: 1000, y: -1000), duration: 1))
                budProfile.run(SKAction.fadeOut(withDuration: 0.25))
                videoCamera.run(SKAction.move(to: CGPoint(x: 0, y: 1000), duration: 0.5))
                soft.impactOccurred()
            }
            
            if bitProfile.contains(position){
                selectiveState = "bitSelection"
                budProfile.run(SKAction.move(to: CGPoint(x: -1000, y: -100), duration: 1))
                bitProfile.run(SKAction.fadeOut(withDuration: 0.25))
                videoCamera.run(SKAction.move(to: CGPoint(x: 1000, y: 300), duration: 0.5))
                soft.impactOccurred()
            }
            
            for index in budArray.indices{
                if budArray[index].contains(position) && budArray[index].purchased == true{
                    let budData = budArray[index].texture!.cgImage()
                    let bData = UIImage(cgImage: budData)
                    let dataData = bData.pngData()
                    MemoryVault.setValue(dataData, forKey: "character")
                    bitProfile.run(SKAction.move(to: CGPoint(x: 200, y: 300), duration: 1))
                    budProfile.run(SKAction.fadeIn(withDuration: 0.25))
                    videoCamera.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.5))
                    extractPNG(forVariable: &(budProfile.texture)!)
                    selectiveState = "profileMain"
                    budMain.run(SKAction.move(to: CGPoint(x: 0, y: 1000), duration: 0.5))
                    medium.impactOccurred()
                }
            }
            
            for index in bitArray.indices{
                if bitArray[index].contains(position) && bitArray[index].purchased{
                    let bitTexture = bitArray[index].texture!.cgImage()
                    let bitImage = UIImage(cgImage: bitTexture)
                    let bitData = bitImage.pngData()
                    MemoryVault.setValue(bitData, forKey: "bit")
                    budProfile.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 1))
                    bitProfile.run(SKAction.fadeIn(withDuration: 0.25))
                    videoCamera.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.5))
                    bitNone.run(SKAction.move(to: CGPoint(x: 1000, y: 300), duration: 0.5))
                    extractBitPNG(forVariable: &(bitProfile.texture)!)
                    selectiveState = "profileMain"
                    medium.impactOccurred()
                }
            }
            
            if escapeButton.contains(position){
                dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "BankL", k_switch: &killSwitch)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if onceSwitchIsOn == false{
                onceSwitchIsOn = true
                startPoint = position
            }
            endPoint = position
            
            Ydifference = endPoint.y - startPoint.y
            Xdifference = endPoint.x - startPoint.x
            
            if budMain.position.y <= 1000 && budMain.position.y >= -1400 && glitchKill == false && selectiveState == "budSelection"{
                budMain.position.y = budMainOriginalPos.y + Ydifference
            }else if budMain.position.y > 1000 && selectiveState == "budSelection"{
                budMain.position.y = 1000
                glitchKill = true
            }else if budMain.position.y < -1400 && selectiveState == "budSelection"{
                budMain.position.y = -1400
                glitchKill = true
            }
            
            let bitX = bitNone.position.x
            
            if bitX <= 1000 && bitX >= -1390 && glitchKill == false && selectiveState == "bitSelection"{
                bitNone.position.x = bitMainOriginalPosX + Xdifference
            }else if bitX > 1000 && selectiveState == "bitSelection"{
                bitNone.position.x = 1000
                glitchKill = true
            }else if bitX < -1390 && selectiveState == "bitSelection"{
                bitNone.position.x = -1390
                glitchKill = true
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onceSwitchIsOn = false
        glitchKill = false
        budMainOriginalPos = budMain.position
        bitMainOriginalPosX = bitNone.position.x
    }
    
    override func update(_ currentTime: TimeInterval) {
        incrementSpace = baseNum
        bitIncrement = bitIncrementSpace
        let vp = videoCamera.position
        for index in budArray.indices{
            if index != 0{
                budArray[index].position = CGPoint(x: 0, y: budMain.position.y + CGFloat(incrementSpace))
                incrementSpace += baseNum
            }
        }
        for child in self.children{
            if child.name == "lock"{
                let Yappendage = child.zPosition
                child.position.y = budMain.position.y + Yappendage
            }
        }
        
        for index in bitArray.indices{
            if index != 0{
                bitArray[index].position = CGPoint(x: Int(bitNone.position.x) + bitIncrement, y: 300)
                bitIncrement += bitIncrementSpace
            }
        }
        for child in self.children{
            if child.name == "bitLock"{
                let XhiddenValue = child.zPosition
                child.position.x = bitNone.position.x + XhiddenValue
            }
        }
        escapeButton.position = CGPoint(x: vp.x - 250, y: vp.y + 550)
    }
}

//375minX
//750 is X-range
//-667minY
//1334 is Y-range

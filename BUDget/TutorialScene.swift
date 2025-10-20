//
//  GameScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/22/23.
//


//MAX of map borders should be 55000 units * 55000 units, still not completely decided

import SpriteKit
import GameplayKit

class TutorialScene: SKScene, SKPhysicsContactDelegate {
    
    var bud = SKSpriteNode()
    var bit = SKSpriteNode()
    var goalCircle = SKSpriteNode()
    var tile = SKSpriteNode()
    var tile2 = SKSpriteNode()
    var tile3 = SKSpriteNode()
    var tile4 = SKSpriteNode()
    var tile5 = SKSpriteNode()
    var tile6 = SKSpriteNode()
    var tile7 = SKSpriteNode()
    var tile8 = SKSpriteNode()
    var tile9 = SKSpriteNode()
    var tile10 = SKSpriteNode()
    var tile11 = SKSpriteNode()
    var tile12 = SKSpriteNode()
    var tile13 = SKSpriteNode()
    var tile14 = SKSpriteNode()
    var tile15 = SKSpriteNode()
    var tile16 = SKSpriteNode()
    var tile17 = SKSpriteNode()
    var tile18 = SKSpriteNode()
    var tile19 = SKSpriteNode()
    var tile20 = SKSpriteNode()
    var tile21 = SKSpriteNode()
    var tile22 = SKSpriteNode()
    var tile23 = SKSpriteNode()
    var tile24 = SKSpriteNode()
    var tile25 = SKSpriteNode()
    var tile26 = SKSpriteNode()
    var tile27 = SKSpriteNode()
    var tile28 = SKSpriteNode()
    var tile29 = SKSpriteNode()
    var tile30 = SKSpriteNode()
    var tile31 = SKSpriteNode()
    var tile32 = SKSpriteNode()
    var tile33 = SKSpriteNode()
    var tile34 = SKSpriteNode()
    var tile35 = SKSpriteNode()
    var tile36 = SKSpriteNode()
    var allTiles: [SKSpriteNode] = []
    var recorder = SKCameraNode()
    var baseCoordinates = 375.0
    var stillHeld: Bool = false
    var globalTouchPosition: CGPoint = CGPoint(x: 0, y: 0)
    var localBudTexture = SKTexture()
    var bank = SKSpriteNode()
    var shop = SKSpriteNode()
    var videos = SKSpriteNode()
    var teleHome = SKSpriteNode()
    var presentKillSwitch: Bool = false
    var popUpScreen = SKSpriteNode()
    var isAllowedToMove = true
    var shaderVeil = SKSpriteNode()
    var dealDescription = SKLabelNode()
    var nameDescription = SKLabelNode()
    var acceptDeal = SKSpriteNode()
    var declineDeal = SKSpriteNode()
    var impactSeriesIndex = 0
    var isWithTrader: Bool = false
    var visitorReward: Int = 0
    var sponsorWebsite = URL(string: "")
    var sponsor = Sponsor()
    var resetWarningSign = SKSpriteNode()
    var resetLever = SKSpriteNode()
    var resetBox = SKSpriteNode()
    var didAnimateReset: Bool = false
    var budIsMoving: Bool = false
    var narrator = SKLabelNode()
    var narratorPointer = SKSpriteNode()
    
    var walk: Bool = false
    var teleport: Bool = false
    var deal: Bool = false
    var bitBeacon: Bool = false
    var wrenches: Bool = false
    var passedSwitchOn: Bool = false
    
    var afformentionedText: String = ""
    
     
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        self.camera = recorder
        self.addChild(recorder)
        
        
        localBudTexture = defaultBud
        bud = addPhysicsBasedSprite(sceneTo: self, texture: localBudTexture, position: CGPoint(x: 0, y: 0), scale: 0.1, zPosition: 100, physicsName: "bud", collider: ColliderFaction.pickup | ColliderFaction.trader | ColliderFaction.bank, contact: ColliderFaction.bank | ColliderFaction.pickup | ColliderFaction.trader | ColliderFaction.sponsor, category: ColliderFaction.player)
        bud.physicsBody?.allowsRotation = false
        
        goalCircle = addGoalCircle(sceneTo: self)
        
        teleHome = addSprite(sceneTo: self, zPosition: 1001, position: CGPoint(x: 0, y: 350), texture: telehomeButton, scale: 0.0)
        teleHome.alpha = 0
        
        shaderVeil = addSprite(sceneTo: self, zPosition: 1000, position: CGPoint(x: 0, y: 0), texture: shaderVeilTexture, scale: 2)
        shaderVeil.alpha = 0
        
        narrator = changeNarratorStuff(size: 25, text: "Welcome! This is a tutorial!                         Please allow me to introduce you to BUDget!                                                          To start, please press the screen where my red pointer is.")
        afformentionedText = "Welcome! This is a tutorial!                         Please allow me to introduce you to BUDget!                                                          To start, please press the screen where my red pointer is."
        
        narratorPointer = addSprite(sceneTo: self, zPosition: 1000, position: CGPoint(x: 0, y: 200), texture: narratorPointerTexture, scale: 0.1)
        narratorPointer.run(SKAction.repeatForever(SKAction.sequence([SKAction.scale(to: 0.25, duration: 1), SKAction.scale(to: 0.1, duration: 1)])))
        narratorPointer.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        
        
        var tileX = -937.5
        var tileY = -937.5
        
        allTiles.append(contentsOf: [tile, tile2, tile3, tile4, tile5, tile6, tile7, tile8, tile9, tile10, tile11, tile12, tile13, tile14, tile15, tile16, tile17, tile18, tile19, tile20, tile21, tile22, tile23, tile24, tile25, tile26, tile27, tile28, tile29, tile30, tile31, tile32, tile33, tile34, tile35, tile36,])
        for eachTile in allTiles.indices{
            allTiles[eachTile] = addAddBackGroundTile(sceneTo: self, position: CGPoint(x: tileX, y: tileY), texture: grass)
            if tileX < 937.5{
                tileX += baseCoordinates
            }else{
                tileY += baseCoordinates
                tileX = -937.5
            }
        }
        
        bitIdleLockOn = false
        
        for _ in 1 ... 5000{
            var randomX = generateRandomInteger(highestPossibility: 20000, lowestPossibility: 0)
            var randomY = generateRandomInteger(highestPossibility: 20000, lowestPossibility: 0)
            
            randomX -= 10000
            randomY -= 10000
            
            let _ = addSprite(sceneTo: self, zPosition: 2, position: CGPoint(x: randomX, y: randomY), texture: pebbleTexture, scale: 0.1)
        }
        
        addPinchCapability(sceneTo: self, selector: #selector(backToMap))

    }
     
    @objc func backToMap(){
        let transition = SKTransition.fade(withDuration: 1)
        let scene = MapScene(size: self.size)
        scene.scaleMode = .aspectFill
        self.view?.presentScene(scene, transition: transition)
        needsTutorial = false
        MemoryVault.set(needsTutorial, forKey: "needsTutorial")
    }
    
    func changeNarratorStuff(size: CGFloat, text: String) -> SKLabelNode{
        let label = addLabel(sceneTo: self, scale: size, position: CGPoint(x: bud.position.x, y: bud.position.y + 400), color: .black, text: text, zPosition: 1000)
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.preferredMaxLayoutWidth = 500
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 5
        
        return label
    }
    
    func QuantumizeAndReturn(){
        teleHome.alpha = 1
        let enableMovement = SKAction.run {self.isAllowedToMove.toggle()}
        isAllowedToMove = false
        teleHome.run(SKAction.sequence([SKAction.scale(to: 0.2, duration: 0.9), SKAction.scale(to: 0.01, duration: 0.9), SKAction.fadeAlpha(to: 0.0, duration: 0.1)]))
        bud.run(SKAction.scale(to: 0.00001, duration: 0.15))
        shaderVeil.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.75, duration: 0.1), SKAction.wait(forDuration: 1.75), SKAction.fadeAlpha(to: 0.0, duration: 0.1), enableMovement]))
        
        let quantumBud = SKEmitterNode(fileNamed: "QuantumBud")!
        quantumBud.position = bud.position
        quantumBud.setScale(0.0001)
        quantumBud.advanceSimulationTime(-0.25)
        self.addChild(quantumBud)
        
        quantumBud.run(SKAction.scale(to: 0.5, duration: 0.15))
        
        var counter = 0
        let endPosition = CGPoint(x: 0, y: 0)
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { Timer in
            switch counter{
            case 0:
                self.bud.run(SKAction.move(to: endPosition, duration: 1.0))
                quantumBud.run(SKAction.move(to: endPosition, duration: 1.0))
            case 2:
                self.bud.run(SKAction.scale(to: 0.1, duration: 0.25))
                quantumBud.run(SKAction.sequence([SKAction.scale(to: 0.00001, duration: 0.2), SKAction.removeFromParent()]))
            default:
                if counter >= 4{
                    Timer.invalidate()
                }else{
                    print("Im moving!")
                }
            }
            counter += 1
        }
    }
    
    func addAddBackGroundTile(sceneTo: SKScene, position: CGPoint, texture: SKTexture) -> SKSpriteNode{
        let element = SpriteSetup(texture: texture, position: position, scale: 0.375)
        element.zPosition = -1
        sceneTo.addChild(element)
        
        return element
    }

    func spawnAndSpinout(position: CGPoint, speed: CGFloat){
        if bud.position != position{
            goalCircle.removeAllActions()
            bud.removeAllActions()

            changeBudFacingOrientation(budPosition: bud.position, newPosition: position, localTexture: localBudTexture, budSprite: &bud)
                
            goalCircle.position = position
            goalCircle.alpha = 1
            goalCircle.run(SKAction.rotate(byAngle: 10, duration: speed))
            goalCircle.run(SKAction.fadeOut(withDuration: speed))
            let toggleMovingState = SKAction.run{self.budIsMoving = false}
            bud.run(SKAction.sequence([SKAction.move(to: position, duration: speed), toggleMovingState]))
        }
    }
    
//    func spawnAndSpinoutContinous(position: CGPoint, speed: CGFloat){
//        if stillHeld{
//            goalCircle.position = position
//            goalCircle.alpha = 1
//            goalCircle.run(SKAction.rotate(byAngle: 10, duration: speed))
//            let toggleMovingState = SKAction.run{self.budIsMoving = false}
//            bud.run(SKAction.sequence([SKAction.move(to: position, duration: speed), toggleMovingState]))
//        }else{
//            goalCircle.run(SKAction.fadeOut(withDuration: speed))
//            if goalCircle.alpha <= 0{
//                bud.removeAllActions()
//                goalCircle.removeAllActions()
//            }
//        }
//    }

    func resetTile(movingNode: SKSpriteNode, backgroundNode: inout SKSpriteNode, increment: CGFloat){
        let bp = movingNode.position
        let tp = backgroundNode.position
        let incrementNow = 1312.5
        if tp.x > bp.x + incrementNow{
            //print("player is too left")
            backgroundNode.position.x -= (increment*2) - baseCoordinates
        }
        if tp.x < bp.x - incrementNow{
            //print("player is too right")
            backgroundNode.position.x += (increment*2) - baseCoordinates
        }
        if tp.y > bp.y + incrementNow{
            //print("player is too low")
            backgroundNode.position.y -= (increment*2) - baseCoordinates
        }
        if tp.y < bp.y - incrementNow{
            //print("player is too high")
            backgroundNode.position.y += (increment*2) - baseCoordinates
        }
    }
    
    func switchTileTexture(movingNode: SKSpriteNode, backgroundNode: inout SKSpriteNode, increment: CGFloat){
        let bp = movingNode.position
        let tp = backgroundNode.position
        if tp.x > bp.x + increment || tp.x < bp.x - increment || tp.y > bp.y + increment || tp.y < bp.y - increment{
            let randomNum = generateRandomInteger(highestPossibility: 3, lowestPossibility: 0)
            switch randomNum{
            case 0:
                backgroundNode.texture = grass
                //print("sand")
            case 1:
                backgroundNode.texture = grass
                //print("gravel")
            case 2:
                backgroundNode.texture = grass
                //print("grass")
            case 3:
                backgroundNode.texture = grass
                //print("grass")
            default:
                break
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            
            if resetLever.contains(position){
                let quarterTurn = CGFloat(Float.pi / 2)
                let toggleBool = SKAction.run {self.didAnimateReset = true}
                resetLever.run(SKAction.sequence([SKAction.rotate(byAngle: -quarterTurn, duration: 0.25), toggleBool]))
            }
            
            if isAllowedToMove && !isInShootingMode{
                if bud.contains(position){
                    medium.impactOccurred()
                    QuantumizeAndReturn()
                    isAllowedToMove = false
                }else{
                    let distance = findDistanceBetweenPoints(currentPoint: bud.position, targetPoint: position)
                    spawnAndSpinout(position: position, speed: distance / CGFloat(playerSpeed))
                    budIsMoving = true
                }
            }else if isInShootingMode && wrenchCount > 0 && roundUpFinished && isAllowedToMove{
                wrenchCount -= 1
                MemoryVault.set(wrenchCount, forKey: "wrenchCount")
                var kS = false
                var Ks = false
                for sprite in self.children{
                    if sprite.name == "wrench" && !kS{
                        sprite.removeFromParent()
                        kS = true
                    }
                    if sprite.name == "hiddenBud" && !Ks{
                        sprite.removeFromParent()
                        Ks = true
                    }
                }
                let throwingWrench = addPhysicsBasedSprite(sceneTo: self, texture: wrenchTexture, position: bud.position, scale: 0.1, zPosition: 1001, physicsName: "wrench", collider: ColliderFaction.trader | ColliderFaction.sponsor, contact: ColliderFaction.trader | ColliderFaction.sponsor, category: ColliderFaction.player)
                
                let bp = bud.position
                let tp = position
                let dx = tp.x - bp.x
                let dy = tp.y - bp.y
                let distanceFromBud = (sqrt(pow(dx, 2) + pow(dy, 2))) / 50
                let magnitude = 10.0
                let force = CGVector(dx: (dx / distanceFromBud) * magnitude, dy: (dy / distanceFromBud) * magnitude)
                throwingWrench.physicsBody?.applyForce(force)
                throwingWrench.run(SKAction.repeatForever(SKAction.rotate(byAngle: 15, duration: 2)))
            }
            if declineDeal.contains(position){
                rigid.impactOccurred()
                animateAwayPopUp(isAllowedToMove: &isAllowedToMove, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, shaderVeil: &shaderVeil, bud: bud)
                narrator.removeFromParent()
                narrator = changeNarratorStuff(size: 25, text: "Good choice. Looks like we need to find another investor, but he is somewhere further away. Use this 'bit' to help you. He will always face towards the nearest investor")
                afformentionedText = "Good choice. Looks like we need to find another investor, but he is somewhere further away. Use this 'bit' to help you. He will always face towards the nearest investor"
                let trader = Trader(imageNamed: "ramay")
                trader.setUp(sceneFor: self, radii: 5500)
                trader.position = CGPoint(x: -1500, y: 1500)
                trader.alpha = 0
                trader.name = "Dummy Investor"
                trader.deal = "Give me all of your personal information and money!"
                trader.run(SKAction.fadeIn(withDuration: 1))
                bit = addSprite(sceneTo: self, zPosition: 100, position: CGPoint(x: bud.position.x + 100, y: bud.position.y + 100), texture: hotPinkBit, scale: 0.3)
                
                deal = true
            }
            if acceptDeal.contains(position){
                soft.impactOccurred()
                animateAwayPopUp(isAllowedToMove: &isAllowedToMove, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, shaderVeil: &shaderVeil, bud: bud)
                narrator.removeFromParent()
                narrator = changeNarratorStuff(size: 25, text: "Bad choice. Looks like we need to find another investor, but he is somewhere further away. Use this 'bit' to help you. He will always face towards the nearest investor")
                afformentionedText = "Bad choice. Looks like we need to find another investor, but he is somewhere further away. Use this 'bit' to help you. He will always face towards the nearest investor"
                let trader = Trader(imageNamed: "ramay")
                trader.setUp(sceneFor: self, radii: 5500)
                trader.position = CGPoint(x: -1500, y: 1500)
                trader.alpha = 0
                trader.name = "Dummy Investor"
                trader.deal = "Give me all of your personal information and money!"
                trader.run(SKAction.fadeIn(withDuration: 1))
                bit = addSprite(sceneTo: self, zPosition: 100, position: CGPoint(x: bud.position.x + 100, y: bud.position.y + 100), texture: hotPinkBit, scale: 0.3)
                
                deal = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let _ = touch.location(in: self)
            stillHeld = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        stillHeld = false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "bud" || contact.bodyA.node?.name == "wrench"{
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.node?.name == "bud" && secondBody.node?.name == "trader"{
            if isAllowedToMove{
                let trader = secondBody.node as! Trader
                 popUpForTrader(traderInQuestion: trader, bud: &bud, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, sceneTo: self, isAllowedToMove: &isAllowedToMove, shaderVeil: &shaderVeil)
                secondBody.node?.removeFromParent()
            }
            print(isAllowedToMove)
        }

        if firstBody.node?.name == "wrench" && secondBody.node?.name == "Dummy Investor" || firstBody.node?.name == "wrench" && secondBody.node?.name == "trader"{
            let sparks = SKEmitterNode(fileNamed: "WrenchSpark")!
            sparks.position = firstBody.node!.position
            sparks.numParticlesToEmit = 50
            self.addChild(sparks)
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        bud.position = bud.position
        let bp = bud.position
        recorder.position = bp
        shaderVeil.position = bp
        narrator.position = CGPoint(x: bp.x, y: bp.y + 400)
        
        
        teleHome.position = CGPoint(x: bp.x, y: bp.y + 350)

//        if bud.position == CGPoint(x: 0, y: 0){
//            isInShootingMode = false
//        }
        
        let homeDistance = findDistanceBetweenPoints(currentPoint: bp, targetPoint: CGPoint(x: 0, y: 0))
        if homeDistance > 2500 && isAllowedToMove{
            narrator.removeFromParent()
            narrator = changeNarratorStuff(size: 25, text: "GO BACK AND DO WHAT I ASKED *please*")
        }
        
        if homeDistance > 3000{
            if isAllowedToMove{
                medium.impactOccurred()
                QuantumizeAndReturn()
                narrator.removeFromParent()
                narrator = changeNarratorStuff(size: 25, text: afformentionedText)
            }
        }
        
        let distance = findDistanceBetweenPoints(currentPoint: bp, targetPoint: narratorPointer.position)
        if distance < 50 && !walk{
            walk = true
            if !passedSwitchOn{
                passedSwitchOn = true
                narrator.removeFromParent()
                narratorPointer.run(SKAction.fadeOut(withDuration: 0.25))
                narrator = changeNarratorStuff(size: 25, text: "Wonderful!                                                                   Now, if you ever need to get back to where you started, just press on your character!")
                afformentionedText = "Wonderful!                                                                   Now, if you ever need to get back to where you started, just press on your character!"
            }
        }
        
        if bud.position == CGPoint(x: 0, y: 0) && walk{
            teleport = true
            if passedSwitchOn{
                passedSwitchOn = false
                narrator.removeFromParent()
                narratorPointer.run(SKAction.fadeOut(withDuration: 0.25))
                narrator = changeNarratorStuff(size: 25, text: "Good again. Here is an investor, walk right up to him, and then decide on his deal.")
                afformentionedText = "Good again. Here is an investor, walk right up to him, and then decide on his deal. Shake hands for accept, reject hand for decline"
                let trader = Trader(imageNamed: "ramay")
                trader.setUp(sceneFor: self, radii: 5500)
                trader.position = CGPoint(x: 0, y: -500)
                trader.alpha = 0
                trader.alias = "Dummy Investor"
                trader.deal = "Give me all of your personal information and money!"
                trader.run(SKAction.fadeIn(withDuration: 1))
            }
        }
        var trader = Trader()
        for child in children{
            if let investor = child as? Trader{
                trader = investor
            }
        }
        let furtiveDistance = findDistanceBetweenPoints(currentPoint: bp, targetPoint: trader.position)
        if furtiveDistance < 200 && deal{
            narrator.removeFromParent()
            narrator = changeNarratorStuff(size: 25, text: "Bit did his job! But this guy isn't much of a talker. Back away as much as possible but still in sight of him, shake your phone, wait for an animation to end, and then tap on the investor. Then, after something happens, shake your phone again.")
            afformentionedText = "Bit did his job! But this guy isn't much of a talker. Back away as much as possible but still in sight of him, shake your phone, wait for an animation to end, and then tap on the investor. Then, after something happens, shake your phone again."
        }
        
        if isInShootingMode && !shootingModeKillSwitch{
            shootingModeKillSwitch = true
            wrenchCount = 25
            shaderVeil.run(SKAction.fadeAlpha(to: 0.5, duration: 0.25))
            runShootingMode(sceneFor: self, bud: bud)
        }else if shootingModeKillSwitch && !isInShootingMode {
            shootingModeKillSwitch = false
            shaderVeil.run(SKAction.fadeAlpha(to: 0, duration: 0.25))
            endShootingMode(sceneIn: self)
            bit.removeFromParent()
            narrator.removeFromParent()
            narrator = changeNarratorStuff(size: 25, text: "You did it! Now pinch the screen with two fingers, and wait a little when you are made your own BUDget world! Have fun!")
            afformentionedText = "You did it! Now pinch the screen with two fingers, and wait a little when you are made your own BUDget world! Have fun!"
        }
        
        for eachTile in allTiles.indices{
            switchTileTexture(movingNode: bud, backgroundNode: &allTiles[eachTile], increment: 1312.5)
            resetTile(movingNode: bud, backgroundNode: &allTiles[eachTile], increment: 1312.5)
        }
        
        keepBitMoving(bitCharacter: &bit, parentPosition: bud.position, isParentMoving: budIsMoving, isPermittedToMove: isAllowedToMove, sceneFrom: self, isOnMap: true)
    }
}

//
//  GameScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/22/23.
//


//MAX of map borders should be 55000 units * 55000 units, still not completely decided

import SpriteKit
import GameplayKit

class MapScene: SKScene, SKPhysicsContactDelegate {
    
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
    
	 
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        if let coins = MemoryVault.value(forKey: "coin"){
            budCoin = coins as! Int
        }else{
            budCoin = 0
            MemoryVault.setValue(budCoin, forKey: "coin")
        }
      //411 -> 442 = 31 diff
         //442 -> 473 = 31 diff
        if let bondedArray = MemoryVault.value(forKey: "tradersLinked"){
             if MemoryVaultLocalTrip == false{
                  traderDetailsDatabase = bondedArray as! [any Sequence]
                  MemoryVaultLocalTrip = true
             }
        }
        
        if let records = MemoryVault.value(forKey: "transactionRecords"){
            transactionRecords = records as! [String]
        }
         
         if let walkCycleCount = MemoryVault.value(forKey: "walkCycles"){
              walkCycles = walkCycleCount as! Int
         }else{
              walkCycles = 0
              MemoryVault.setValue(walkCycles, forKey: "walkCycles")
         }
        
        if let wCount = MemoryVault.value(forKey: "wrenchCount"){
            wrenchCount = wCount as! Int
        }else{
            wrenchCount = 25
            MemoryVault.setValue(wrenchCount, forKey: "wrenchCount")
        }
        
        if let budColores = MemoryVault.value(forKey: "budColors") as? [Bool]{
            budColors = budColores
        }else{
            budColors.append(contentsOf: [true, false, false, false, false, false, false, false, false, false, false, false, false])
            MemoryVault.setValue(budColors, forKey: "budColors")
        }
        
        if let bytes = MemoryVault.value(forKey: "bitColors") as? [Bool]{
            bitColors = bytes
        }else{
            bitColors.append(contentsOf: [true, false, false, false, false, false, false, false, false, false, false, false, false])
            MemoryVault.setValue(bitColors, forKey: "bitColors")
        }
        
        if let bit = MemoryVault.value(forKey: "bit") as? Data{
            for bitOption in bitTexturePallet{
                let budData = bitOption.cgImage()
                let bData = UIImage(cgImage: budData)
                let dataData = bData.pngData()
                if dataData == bit{
                    bitTexture = bitOption
                }
            }
        }else{
            bitTexture = noBit
        }
    
        extractPNG(forVariable: &localBudTexture)
        
        bud = addPhysicsBasedSprite(sceneTo: self, texture: localBudTexture, position: CGPoint(x: 0, y: -400), scale: 0.1, zPosition: 100, physicsName: "bud", collider: ColliderFaction.pickup | ColliderFaction.trader | ColliderFaction.bank, contact: ColliderFaction.bank | ColliderFaction.pickup | ColliderFaction.trader | ColliderFaction.sponsor, category: ColliderFaction.player)
        bud.physicsBody?.allowsRotation = false
        
        if sceneSetTo == "Map2"{
            bud.position = CGPoint(x: 0, y: 400)
        }
        
        extractBitPNG(forVariable: &bitTexture)
        if bitTexture != noBit{
            bit = addSprite(sceneTo: self, zPosition: 100, position: CGPoint(x: bud.position.x + 100, y: bud.position.y + 100), texture: bitTexture, scale: 0.3)
        }
        
        goalCircle = addGoalCircle(sceneTo: self)
        bank = addPhysicsBasedSprite(sceneTo: self, texture: bankTexture, position: CGPoint(x: 0, y: 0), scale: 0.3, zPosition: 50, physicsName: "bank", collider: ColliderFaction.player, contact: ColliderFaction.player, category: ColliderFaction.bank)
        
        teleHome = addSprite(sceneTo: self, zPosition: 1001, position: CGPoint(x: 0, y: 350), texture: telehomeButton, scale: 0.0)
        teleHome.alpha = 0
        
        shaderVeil = addSprite(sceneTo: self, zPosition: 1000, position: CGPoint(x: 0, y: 0), texture: shaderVeilTexture, scale: 2)
        shaderVeil.alpha = 0
        
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
        
        self.camera = recorder
        self.addChild(recorder)
        
        
        if didEncounterSponsor == false{
            sponsor = Sponsor(imageNamed: "northEaston")
            sponsor.setUp(sceneFor: self, position: CGPoint(x: -400, y: -400), cn: "North Easton Bank", h: "Care to visit our website? 20 BUDcoin reward!", wl: URL(string: "https://www.northeastonsavingsbank.com")!, rfv: 20, t: northEastonTexture)
        }
        
        for _ in 1 ... 100{
            let trader = Trader(imageNamed: "ramay") //This Initialization of my custom call is ABSOLUTELY NECCESSARY!!! If you do not initialize the class this way, it will crash and not exist!!!
            trader.setUp(sceneFor: self, radii: 5500)
        }
        
        bitIdleLockOn = false
         
//         let _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(impactSeries), userInfo: nil, repeats: true)
        
        resetBox = addPhysicsBasedSprite(sceneTo: self, texture: resetBoxTexture, position: CGPoint(x: -50000, y: 0), scale: 0.5, zPosition: 100, physicsName: "reset", collider: ColliderFaction.wrench, contact: ColliderFaction.wrench, category: ColliderFaction.trader)
        resetLever = addSprite(sceneTo: self, zPosition: 101, position: CGPoint(x: resetBox.position.x + 40, y: resetBox.position.y + 45), texture: resetLeverTexture, scale: 1)
        resetWarningSign = addSprite(sceneTo: self, zPosition: 100, position: CGPoint(x: -49500, y: resetBox.position.y + 200), texture: resetWarningSignTexture, scale: 1)
        
        for _ in 1 ... 1000{
            var randomX = generateRandomInteger(highestPossibility: 20000, lowestPossibility: 0)
            var randomY = generateRandomInteger(highestPossibility: 20000, lowestPossibility: 0)
            
            randomX -= 10000
            randomY -= 10000
            
            let _ = addSprite(sceneTo: self, zPosition: 2, position: CGPoint(x: randomX, y: randomY), texture: pebbleTexture, scale: 0.1)
        }
    }
     
    @objc func impactSeries(){
        switch impactSeriesIndex {
        case 0:
            soft.impactOccurred()
        case 1:
            light.impactOccurred()
        case 2:
            medium.impactOccurred()
        case 3:
            rigid.impactOccurred()
        case 4:
            heavy.impactOccurred()
        default:
            break
        }
        if impactSeriesIndex >= 4{
            impactSeriesIndex  = 0
        }else{
            impactSeriesIndex += 1
        }
    }
    
    func QuantumizeAndReturn(){
        teleHome.alpha = 1
        let enableMovement = SKAction.run {self.isAllowedToMove.toggle()}
        isAllowedToMove = false
        teleHome.run(SKAction.sequence([SKAction.scale(to: 0.2, duration: 0.9), SKAction.scale(to: 0.01, duration: 0.9), SKAction.fadeAlpha(to: 0.0, duration: 0.1)]))
        bud.run(SKAction.scale(to: 0.00001, duration: 0.15))
        shaderVeil.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.75, duration: 0.1), SKAction.wait(forDuration: 1.75), SKAction.fadeAlpha(to: 0.0, duration: 0.1), enableMovement]))
        var whereToEnd = "above"
        let budX = bud.position.x
        let budY = bud.position.y
        if budY > 0 && budX > 0{
            if budY > budX{
                whereToEnd = "above"
            }else{
                whereToEnd = "right"
            }
        }else if budY < 0 && budX > 0{
            if -budY > budX{
                whereToEnd = "below"
            }else{
                whereToEnd = "right"
            }
        }else if budY < 0 && budX < 0{
            if -budY > -budX{
                whereToEnd = "below"
            }else{
                whereToEnd = "left"
            }
        }else if budY > 0 && budX < 0{
            if budY > -budX{
                whereToEnd = "above"
            }else{
                whereToEnd = "left"
            }
        }
        
        let quantumBud = SKEmitterNode(fileNamed: "QuantumBud")!
        quantumBud.position = bud.position
        quantumBud.setScale(0.0001)
        quantumBud.advanceSimulationTime(-0.25)
        self.addChild(quantumBud)
        
        quantumBud.run(SKAction.scale(to: 0.5, duration: 0.15))
        
        var counter = 0
        var endPosition = CGPoint(x: 0, y: 0)
        let _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { Timer in
            switch counter{
            case 0:
                switch whereToEnd{
                case "above":
                    endPosition = CGPoint(x: self.bank.position.x, y: self.bank.position.y + 400)
                case "below":
                    endPosition = CGPoint(x: self.bank.position.x, y: self.bank.position.y - 400)
                case "left":
                    endPosition = CGPoint(x: self.bank.position.x - 400, y: self.bank.position.y)
                case "right":
                    endPosition = CGPoint(x: self.bank.position.x + 400, y: self.bank.position.y)
                    
                default:
                    break
                }
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
    
    func findAppropriateDashDirection(budsPosition: CGPoint, locationPosition: CGPoint) -> SKTransitionDirection{
        var budX = budsPosition.x
        var budY = budsPosition.y
        let locationX = locationPosition.x
        let locationY = locationPosition.y

        budX -= locationX
        budY -= locationY

        let absX = getAbsoluteValueNew(CGFloatValue: budX)
        let absY = getAbsoluteValueNew(CGFloatValue: budY)
        var direction = SKTransitionDirection.up
        
        if absX > absY{
            if budX < 0{
                direction = .right
            }else{
                direction = .left
            }
        }else{
            if budY < 0{
                direction = .up
            }else{
                direction = .down
            }
        }
        return direction
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
                if isWithTrader && tradersLinked.count > 0{
                    tradersLinked.removeLast()
                }
            }
            if acceptDeal.contains(position){
                soft.impactOccurred()
                if isWithTrader{
                    if traderDetailsDatabase.count < 20 {
                        animateAwayPopUp(isAllowedToMove: &isAllowedToMove, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, shaderVeil: &shaderVeil, bud: bud)
                        let traderNew = tradersLinked.last!
                        budCoin += traderNew.dealReturn
                        appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: traderNew.alias, transactionAmount: traderNew.dealReturn, transactionItem: "coins")
                        MemoryVault.set(budCoin, forKey: "coin")
                        var importantUniqueValues: [any Sequence] = []
                        importantUniqueValues.append(traderNew.alias)
                        importantUniqueValues.append(traderNew.deal)
                        let imageData = traderNew.texture!.cgImage()
                        let UIData = UIImage(cgImage: imageData)
                        let dataData = UIData.pngData()!
                        importantUniqueValues.append(dataData)
                        let dealReturn = String(traderNew.dealReturn)
                        importantUniqueValues.append(dealReturn)
                        let boolValue = String(traderNew.isActive)
                        importantUniqueValues.append(boolValue)
                        let newChance = Int(generateRandomInteger(highestPossibility: 10, lowestPossibility: 0))
                        let newChanceString = String(newChance)
                        importantUniqueValues.append(newChanceString)
                        let magnification = String(traderNew.magnification)
                        importantUniqueValues.append(magnification)
                        let floatingReturnPoint = String(traderNew.floatingReturnPoint)
                        importantUniqueValues.append(floatingReturnPoint)
                        let cooldown = String(traderNew.cooldownIncrement)
                        importantUniqueValues.append(cooldown)
                        let netReturns = String(traderNew.netReturns)
                        importantUniqueValues.append(netReturns)
                        traderDetailsDatabase.append(importantUniqueValues)
                        MemoryVault.set(traderDetailsDatabase, forKey: "tradersLinked")
                    }
                }else{
                    budCoin += visitorReward
                    appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "N.E.S.B", transactionAmount: 20, transactionItem: "coins")
                    UIApplication.shared.open(sponsorWebsite!)
                    animateAwayPopUp(isAllowedToMove: &isAllowedToMove, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, shaderVeil: &shaderVeil, bud: bud)
                }
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
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "bank"{
            let direction = findAppropriateDashDirection(budsPosition: bud.position, locationPosition: bank.position)
            sceneDirectionWith = direction
            var dashLocation: String = ""
            if bud.position.y > bank.position.y{
                dashLocation = "Bank2"
            }else{
                dashLocation = "Bank"
            }
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: direction, sceneDashName: dashLocation, k_switch: &presentKillSwitch)
        }

        if firstBody.node?.name == "bud" && secondBody.node?.name == "trader"{
            if isAllowedToMove{
                let trader = secondBody.node as! Trader
                 popUpForTrader(traderInQuestion: trader, bud: &bud, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, sceneTo: self, isAllowedToMove: &isAllowedToMove, shaderVeil: &shaderVeil)
                secondBody.node?.removeFromParent()
                tradersLinked.append(trader)
                isWithTrader = true
            }
        }
         
         if firstBody.node?.name == "bud" && secondBody.node?.name == "sponsor"{
             if isAllowedToMove{
                 let sponsor = secondBody.node as! Sponsor
                  popUpForSponsor(sponsorInQuestion: sponsor, bud: &bud, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, sceneTo: self, isAllowedToMove: &isAllowedToMove, shaderVeil: &shaderVeil)
                 secondBody.node?.removeFromParent()
                 isWithTrader = false
                 visitorReward = sponsor.rewardForVisiting
                 sponsorWebsite = sponsor.websiteLink!
                 didEncounterSponsor = true
             }
         }

        if firstBody.node?.name == "wrench" && secondBody.node?.name == "reset"{
            let sparks = SKEmitterNode(fileNamed: "WrenchSpark")!
            sparks.position = firstBody.node!.position
            sparks.numParticlesToEmit = 50
            self.addChild(sparks)
            let dictionary = MemoryVault.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                MemoryVault.removeObject(forKey: key)
            }
            MemoryVault.setValue(1000000, forKey: "coin")
            let exitAnimation = SKAction.run{exit(0)}
            self.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), exitAnimation]))
        }
        
        if firstBody.node?.name == "wrench" && secondBody.node?.name == "sponsor" || firstBody.node?.name == "wrench" && secondBody.node?.name == "trader"{
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
        recorder.position = bud.position
        shaderVeil.position = bud.position
        let rp = recorder.position
//        Table.position = CGPoint(x: rp.x, y: rp.y - 600)
//        Profile.position = CGPoint(x: rp.x - 225, y: rp.y - 600)
//        Map.position = CGPoint(x: rp.x - 75, y: rp.y - 580)
//        Shop.position = CGPoint(x: rp.x + 75, y: rp.y - 580)
//        Videos.position = CGPoint(x: rp.x + 225, y: rp.y - 600)
        teleHome.position = CGPoint(x: rp.x, y: rp.y + 350)
//        monitorKillSwitch()
        
        if bud.position == CGPoint(x: 0, y: -400) || bud.position == CGPoint(x: 0, y: 400){
            isInShootingMode = false
        }
 
        if isInShootingMode && !shootingModeKillSwitch{
            shootingModeKillSwitch = true
            shaderVeil.run(SKAction.fadeAlpha(to: 0.5, duration: 0.25))
            runShootingMode(sceneFor: self, bud: bud)
        }else if shootingModeKillSwitch && !isInShootingMode {
            shootingModeKillSwitch = false
            shaderVeil.run(SKAction.fadeAlpha(to: 0, duration: 0.25))
            endShootingMode(sceneIn: self)
        }
        
        for eachTile in allTiles.indices{
            switchTileTexture(movingNode: bud, backgroundNode: &allTiles[eachTile], increment: 1312.5)
            resetTile(movingNode: bud, backgroundNode: &allTiles[eachTile], increment: 1312.5)
        }
        if didAnimateReset{
            let dictionary = MemoryVault.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                MemoryVault.removeObject(forKey: key)
            }
            exit(0) 
        }
        
      
        if bitTexture != noBit{
            keepBitMoving(bitCharacter: &bit, parentPosition: bud.position, isParentMoving: budIsMoving, isPermittedToMove: isAllowedToMove, sceneFrom: self, isOnMap: true)
        }
    }
}

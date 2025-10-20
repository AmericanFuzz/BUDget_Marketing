//
//  BankScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 10/25/23.
//

import Foundation
import SpriteKit


class BankScene: SKScene, SKPhysicsContactDelegate{
    
    var bud = SKSpriteNode()
    var bit = SKSpriteNode()
    var localBudTexture = SKTexture()
    var backgroundFloor = SKSpriteNode()
    var perimiter = SKSpriteNode()
    var birdCamera = SKCameraNode()
    var goalCircle = SKSpriteNode()
    var centerQuantum = SKEmitterNode()
    var topQuantum = SKEmitterNode()
    var bottomQuantum = SKEmitterNode()
    var bottomLeftQuantum = SKEmitterNode()
    var bottomRightQuantum = SKEmitterNode()
    var topLeftQuantum = SKEmitterNode()
    var topRightQuantum = SKEmitterNode()
    var degrees60: CGFloat = 60
    var exitStairs = SKSpriteNode()
    var shopStairs = SKSpriteNode()
    var profileStairs = SKSpriteNode()
    var videosStairs = SKSpriteNode()
    var junkStairs = SKSpriteNode()
    var exitStairs2 = SKSpriteNode()
    var killSwitch: Bool = false
    var ramay = SKSpriteNode()
    var ramayCounter = SKSpriteNode()
    var shopIcon = SKSpriteNode()
    var profileIcon = SKSpriteNode()
    var videosIcon = SKSpriteNode()
    var junkIcon = SKSpriteNode()
    var exitIcon = SKSpriteNode()
    var exitIcon2 = SKSpriteNode()
    var popUpScreen = SKSpriteNode()
    var isAllowedToMove = true
    var shaderVeil = SKSpriteNode()
    var dealDescription = SKLabelNode()
    var nameDescription = SKLabelNode()
    var acceptDeal = SKSpriteNode()
    var declineDeal = SKSpriteNode()
    var hitStopper: Bool = false
    var traderInQuestion = Trader()
    var clickSwitch = SKSpriteNode()
    var clickSwitchFailSafeIsOn: Bool = false
    var tellerIntro = SKSpriteNode()
    var quizTile = SKSpriteNode()
    var databaseTile = SKSpriteNode()
    var traderManagerTile = SKSpriteNode()
    var questionsTile = SKSpriteNode()
    var budIsMoving: Bool = false
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        extractPNG(forVariable: &localBudTexture)
        degreesToRadians(degrees: &degrees60)
        
        walkCycles += 1
        MemoryVault.setValue(walkCycles, forKey: "walkCycles")
        
        var tx = -550
        var ty = -475
        var tTally = 0
        var stopSwitch = true
        
        for index in traderDetailsDatabase.indices{
            //
            let importantUniqueValues = traderDetailsDatabase[index] as! [Any]
            
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
            
            let alias = importantUniqueValues[0] as! String
            let deal = importantUniqueValues[1] as! String
            let uiImage = UIImage(data: importantUniqueValues[2] as! Data)
            let dealResult = importantUniqueValues[3] as! String
            let boolValue = importantUniqueValues[4] as! String
            let chanceValue = importantUniqueValues[5] as! String
            let magnification = importantUniqueValues[6] as! String
            let floatingReturnPoint = importantUniqueValues[7] as! String
            let cooldownIncrement = importantUniqueValues[8] as! String
            let netReturns = importantUniqueValues[9] as! String
            let trader = Trader(imageNamed: "trader")
            tTally += 1
            if tTally > 10 && stopSwitch{
                tx = 250
                ty = -475
                stopSwitch = false
            }
            
            //504 ->
            
            trader.position = CGPoint(x: tx, y: ty)
            trader.zPosition = 3
            trader.name = "trader"
            trader.alias = alias
            trader.deal = deal
            trader.dealReturn = Int(dealResult)!
            trader.isActive = Bool(boolValue)!
            trader.randomOutcome = Int(chanceValue)!
            trader.magnification = Int(magnification)!
            trader.floatingReturnPoint = Int(floatingReturnPoint)!
            trader.dealReturn = (trader.floatingReturnPoint - trader.randomOutcome) * trader.magnification
            trader.cooldownIncrement = Int(cooldownIncrement)!
            trader.netReturns = Int(netReturns)!
            trader.texture = SKTexture(image: uiImage!)
            trader.setScale(0.15)
            trader.physicsBody = SKPhysicsBody(rectangleOf: trader.size)
            trader.physicsBody?.categoryBitMask = ColliderFaction.trader
            trader.physicsBody?.contactTestBitMask = ColliderFaction.player
            trader.physicsBody?.collisionBitMask = ColliderFaction.bank
            trader.physicsBody?.isDynamic = false
            trader.physicsBody?.affectedByGravity = false
            self.addChild(trader)
            
            if trader.isActive{
                trader.alpha = 1
            }else{
                trader.alpha = 0.5
            }
            
            tx += 300
            if tx > -250 && tTally <= 10{
                tx = -550
                ty += 300
            }else if tx > 550 && tTally > 10{
                tx = 250
                ty += 300
            }
        }
        
        for node in self.children{
            if let trader = node as? Trader{
                trader.checkForCoolDown(sceneFor: self)
            }
        }
        
        shaderVeil = addSprite(sceneTo: self, zPosition: 1000, position: CGPoint(x: 0, y: 0), texture: shaderVeilTexture, scale: 2)
        shaderVeil.alpha = 0
        
        bud = addPhysicsBasedSprite(sceneTo: self, texture: localBudTexture, position: CGPoint(x: 0, y: -900), scale: 0.1, zPosition: 100, physicsName: "bud", collider: ColliderFaction.walls | ColliderFaction.trader, contact: ColliderFaction.walls | ColliderFaction.trader | ColliderFaction.tbd, category: ColliderFaction.player)
        bud.physicsBody?.allowsRotation = false
        
        if sceneSetTo == "Bank2"{
            bud.position = CGPoint(x: 0, y: 950)
        }
        
        extractBitPNG(forVariable: &bitTexture)
        if bitTexture != noBit{
            bit = addSprite(sceneTo: self, zPosition: 100, position: CGPoint(x: bud.position.x + 100, y: bud.position.y + 100), texture: bitTexture, scale: 0.3)
        }
        
        let oscillateTop = SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: 100, duration: 0.5), SKAction.moveBy(x: 0, y: -100, duration: 0.5)]))
        let oscillateBottom = SKAction.repeatForever(SKAction.sequence([SKAction.moveBy(x: 0, y: -100, duration: 0.5), SKAction.moveBy(x: 0, y: 100, duration: 0.5)]))
        
        shopIcon = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: -1100, y: 800), texture: storeTexture, scale: 0.3)
        profileIcon = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 1080, y: 800), texture: profilTexture, scale: 0.3)
        videosIcon = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 1080, y: -800), texture: videoTexture, scale: 0.5)
        junkIcon = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: -1100, y: -800), texture: junkTexture, scale: 0.6)
        exitIcon = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 0, y: -1350), texture: exitTexture, scale: 0.3)
        exitIcon2 = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 0, y: 1400), texture: exitTexture, scale: 0.3)
        
        shopIcon.run(oscillateTop)
        profileIcon.run(oscillateTop)
        exitIcon2.run(oscillateTop)
        videosIcon.run(oscillateBottom)
        junkIcon.run(oscillateBottom)
        exitIcon.run(oscillateBottom)
        
        switch sceneSetTo{
        case "Bank":
            bud.position = CGPoint(x: 0, y: -900)
        case "BankL":
            bud.position = CGPoint(x: 800, y: 580)
        case "BankBL":
            bud.position = CGPoint(x: 800, y: -535)
        case "BankR":
            bud.position = CGPoint(x: -800, y: 580)
        case "BankBR":
            bud.position = CGPoint(x: -800, y: -535)
        case "TellerHome":
            bud.position = CGPoint(x: 0, y: -100)
        default:
            break
        }
        
        perimiter = addPhysicsBasedSprite(sceneTo: self, texture: perimiterTexture, position: origin, scale: 2.5, zPosition: 1, physicsName: "perimiter", collider: ColliderFaction.player | ColliderFaction.tbd, contact: ColliderFaction.player, category: ColliderFaction.walls)
        perimiter.physicsBody?.isDynamic = false
        
        ramay = addPhysicsBasedSprite(sceneTo: self, texture: ramayTexture, position: CGPoint(x: 0, y: 0), scale: 0.25, zPosition: 10, physicsName: "ramay", collider: ColliderFaction.bank, contact: ColliderFaction.player, category: ColliderFaction.tbd)
        
        tellerIntro = addSprite(sceneTo: self, zPosition: 9, position: CGPoint(x: 0, y: 0), texture: tellerIntroTexture, scale: 0.01)
        quizTile = addSprite(sceneTo: self, zPosition: 9, position: CGPoint(x: 0, y: 0), texture: qTile, scale: 0.01)
        questionsTile = addSprite(sceneTo: self, zPosition: 9, position: CGPoint(x: 0, y: 0), texture: qnTile, scale: 0.01)
        databaseTile = addSprite(sceneTo: self, zPosition: 9, position: CGPoint(x: 0, y: 0), texture: dbTile, scale: 0.01)
        traderManagerTile = addSprite(sceneTo: self, zPosition: 9, position: CGPoint(x: 0, y: 0), texture: tmTile, scale: 0.01)
        
        clickSwitch = addPhysicsBasedSprite(sceneTo: self, texture: ramayTexture, position: CGPoint(x: 0, y: 10), scale: 0.25, zPosition: 10, physicsName: "clickSwitch", collider: ColliderFaction.bank, contact: ColliderFaction.bank, category: ColliderFaction.player)
        
        clickSwitch.alpha = 0
        clickSwitch.physicsBody = SKPhysicsBody(circleOfRadius: 300)
        clickSwitch.physicsBody?.categoryBitMask = ColliderFaction.tbd
        clickSwitch.physicsBody?.collisionBitMask = ColliderFaction.bank
        clickSwitch.physicsBody?.contactTestBitMask = ColliderFaction.player
        
        exitStairs = addStairs(sceneTo: self, position: CGPoint(x: 0, y: -1125), zPosition: 10, zRotation: (degrees60*3), name: "exitStairs", texture: stairs, scale: 0.2)
        shopStairs = addStairs(sceneTo: self, position: CGPoint(x: -1030, y: 580), zPosition: 10, zRotation: degrees60, name: "shopStairs", texture: stairs, scale: 0.2)
        profileStairs = addStairs(sceneTo: self, position: CGPoint(x: 1035, y: 580), zPosition: 10, zRotation: -degrees60, name: "profileStairs", texture: stairs, scale: 0.2)
        junkStairs = addStairs(sceneTo: self, position: CGPoint(x: -1015, y: -535), zPosition: 10, zRotation: (degrees60*2), name: "junkStairs", texture: stairs, scale: 0.2)
        videosStairs = addStairs(sceneTo: self, position: CGPoint(x: 1025, y: -535), zPosition: 10, zRotation: -(degrees60*2), name: "videosStairs", texture: stairs, scale: 0.2)
        exitStairs2 = addStairs(sceneTo: self, position: CGPoint(x: 0, y: 1200), zPosition: 10, zRotation: 0, name: "exitStairs2", texture: stairs, scale: 0.2)
        
        bitIdleLockOn = false
        
        topQuantum = addEmitter(sceneTo: self, timeElapsed: 1, fileName: "QuantumBar", scale: 1, position: CGPoint(x: 0, y: 1145), rotation: 0, zPosition: 5)
        bottomQuantum = addEmitter(sceneTo: self, timeElapsed: 1, fileName: "QuantumBar", scale: 1, position: CGPoint(x: 0, y: -1070), rotation: 0, zPosition: 5)
        topLeftQuantum = addEmitter(sceneTo: self, timeElapsed: 1, fileName: "QuantumBar", scale: 1, position: CGPoint(x: -970, y: 580), rotation: degrees60, zPosition: 5)
        topRightQuantum = addEmitter(sceneTo: self, timeElapsed: 1, fileName: "QuantumBar", scale: 1, position: CGPoint(x: 970, y: 580), rotation: -degrees60, zPosition: 5)
        bottomLeftQuantum = addEmitter(sceneTo: self, timeElapsed: 1, fileName: "QuantumBar", scale: 1, position: CGPoint(x: -955, y: -535), rotation: (degrees60*2), zPosition: 5)
        bottomRightQuantum = addEmitter(sceneTo: self, timeElapsed: 1, fileName: "QuantumBar", scale: 1, position: CGPoint(x: 955, y: -535), rotation: -(degrees60*2), zPosition: 5)
        
        backgroundFloor = addSprite(sceneTo: self, zPosition: 0, position: origin, texture: bankFloorTexture, scale: 2.5)
        goalCircle = addGoalCircle(sceneTo: self)
        
        self.camera = birdCamera
        self.addChild(birdCamera)
        
        var px = 250
        var py = -550
        
        for _ in 1 ... 10{
            addPad(position: CGPoint(x: px, y: py), sceneTo: self)
            px += 300
            if px > 550{
                px = 250
                py += 300
            }
        }
        
        py = -550
        px = -550
        
        for _ in 1 ... 10{
            addPad(position: CGPoint(x: px, y: py), sceneTo: self)
            px += 300
            if px > -250{
                px = -550
                py += 300
            }
        }
    }
    
    func addPad(position: CGPoint, sceneTo: SKScene){
        let pad = SKSpriteNode(texture: traderPadTexture)
        pad.setScale(0.25)
        pad.zPosition = 2
        pad.position = position
        sceneTo.addChild(pad)
    }
    
    func spawnAndSpinout(position: CGPoint, speed: CGFloat){
        goalCircle.removeAllActions()
        bud.removeAllActions()
        goalCircle.position = position
        goalCircle.alpha = 1
        
        changeBudFacingOrientation(budPosition: bud.position, newPosition: position, localTexture: localBudTexture, budSprite: &bud)
        
        goalCircle.run(SKAction.rotate(byAngle: 10, duration: speed))
        goalCircle.run(SKAction.fadeOut(withDuration: speed))
        let toggleMovingState = SKAction.run{self.budIsMoving = false}
        bud.run(SKAction.sequence([SKAction.move(to: position, duration: speed), toggleMovingState]))
    }
    
    func initiateIntro(present: Bool){
        if present{
            let growAction: SKAction = SKAction.scale(to: 0.5, duration: 0.25)
            let growAction2: SKAction = SKAction.scale(to: 0.2, duration: 0.25)
            tellerIntro.run(SKAction.move(to: CGPoint(x: 0, y: 150), duration: 0.25))
            tellerIntro.run(growAction)
            quizTile.run(SKAction.move(to: CGPoint(x: -225, y: -200), duration: 0.25))
            quizTile.run(growAction2)
            questionsTile.run(SKAction.move(to: CGPoint(x: -75, y: -200), duration: 0.25))
            questionsTile.run(growAction2)
            databaseTile.run(SKAction.move(to: CGPoint(x: 75, y: -200), duration: 0.25))
            databaseTile.run(growAction2)
            traderManagerTile.run(SKAction.move(to: CGPoint(x: 225, y: -200), duration: 0.25))
            traderManagerTile.run(growAction2)
        }else{
            let returnAction: SKAction = SKAction.move(to: CGPoint(x: 0, y: 0), duration: 0.25)
            let shrinkAction: SKAction = SKAction.scale(to: 0.01, duration: 0.25)
            tellerIntro.run(returnAction)
            tellerIntro.run(shrinkAction)
            quizTile.run(returnAction)
            quizTile.run(shrinkAction)
            questionsTile.run(returnAction)
            questionsTile.run(shrinkAction)
            databaseTile.run(returnAction)
            databaseTile.run(shrinkAction)
            traderManagerTile.run(returnAction)
            traderManagerTile.run(shrinkAction)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            var pseudoAllowedToMove = true
            if quizTile.contains(position) && !questionsTile.contains(position) && !databaseTile.contains(position) && !traderManagerTile.contains(position){
                pseudoAllowedToMove = false
                moveToScene(sceneTo: QuizScene(size: self.size), sceneFrom: self)
            }
            if !quizTile.contains(position) && questionsTile.contains(position) && !databaseTile.contains(position) && !traderManagerTile.contains(position){
                pseudoAllowedToMove = false
                moveToScene(sceneTo: QuestionsScene(size: self.size), sceneFrom: self)
            }
            if !quizTile.contains(position) && !questionsTile.contains(position) && databaseTile.contains(position) && !traderManagerTile.contains(position){
                pseudoAllowedToMove = false
                moveToScene(sceneTo: DatabaseScene(size: self.size), sceneFrom: self)
            }
            if !quizTile.contains(position) && !questionsTile.contains(position) && !databaseTile.contains(position) && traderManagerTile.contains(position){
                pseudoAllowedToMove = false
                moveToScene(sceneTo: TraderManagerScene(size: self.size), sceneFrom: self)
            }
            if isAllowedToMove && pseudoAllowedToMove && !isInShootingMode{
                let distance = findDistanceBetweenPoints(currentPoint: bud.position, targetPoint: position)
                spawnAndSpinout(position: position, speed: distance / CGFloat(playerSpeed))
                budIsMoving = true
            }else if isInShootingMode && wrenchCount > 0 && roundUpFinished && isAllowedToMove && pseudoAllowedToMove{
                wrenchCount -= 1
                MemoryVault.setValue(wrenchCount, forKey: "wrenchCount")
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
            if acceptDeal.contains(position){
                soft.impactOccurred()
                hitStopper = false
                animateAwayPopUp(isAllowedToMove: &isAllowedToMove, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, shaderVeil: &shaderVeil, bud: bud)
                budCoin += traderInQuestion.dealReturn
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: traderInQuestion.alias, transactionAmount: traderInQuestion.dealReturn, transactionItem: "coins")
                MemoryVault.set(budCoin, forKey: "coin")
            }
            var crashBlockerOn: Bool = false
            if declineDeal.contains(position){
                rigid.impactOccurred()
                hitStopper = false
                for index in traderDetailsDatabase.indices{
                    if crashBlockerOn == false{
                        let traderScoped = traderDetailsDatabase[index]
                        var importantTraits: [Any] = []
                        importantTraits.append(traderInQuestion.alias)
                        importantTraits.append(traderInQuestion.deal)
                        let imageData = traderInQuestion.texture!.cgImage()
                        let UIData = UIImage(cgImage: imageData)
                        let dataData = UIData.pngData()!
                        importantTraits.append(dataData)
                        let traderScopedArray = traderScoped as! [Any]
                        let globalChildren = self.children
                        for globalChild in globalChildren {
                            if let childTrader = globalChild as? Trader{
                                print("I found a trader!")
                                if childTrader.alias == traderInQuestion.alias{
                                    globalChild.removeFromParent()
                                    print("got him!")
                                }
                            }
                        }
                        if traderScopedArray[0] as! String == traderInQuestion.alias && traderScopedArray[2] as! Data == dataData{
                            print("his ass is caught!")
                            traderDetailsDatabase.remove(at: index)
                            crashBlockerOn = true
                        }
                        MemoryVault.setValue(traderDetailsDatabase, forKey: "tradersLinked")
                    }
                }
                animateAwayPopUp(isAllowedToMove: &isAllowedToMove, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, shaderVeil: &shaderVeil, bud: bud)
                budCoin += traderInQuestion.dealReturn
            }
        }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let position = touch.location(in: self)
//
//        }
//    }
    
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
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "perimiter"{
            heavy.impactOccurred()
            bud.removeAllActions()
            bud.run(SKAction.move(to: origin, duration: 0.25))
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "exitStairs"{
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .down, sceneDashName: "Map", k_switch: &killSwitch)
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "profileStairs"{
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "Profile", k_switch: &killSwitch)
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "shopStairs"{
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "Shop", k_switch: &killSwitch)
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "junkStairs"{
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "Junk", k_switch: &killSwitch)
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "videosStairs"{
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "Videos", k_switch: &killSwitch)
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "exitStairs2"{
            dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .up, sceneDashName: "Map2", k_switch: &killSwitch)
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "clickSwitch"{
            if clickSwitchFailSafeIsOn == false{
                clickSwitchFailSafeIsOn = true
                initiateIntro(present: true)
            }
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "trader"{
            if hitStopper == false{
                hitStopper = true
                let trader = secondBody.node as! Trader
                traderInQuestion = trader
                popUpForTrader(traderInQuestion: trader, bud: &bud, popUpScreen: &popUpScreen, nameDescription: &nameDescription, dealDescription: &dealDescription, acceptDeal: &acceptDeal, declineDeal: &declineDeal, sceneTo: self, isAllowedToMove: &isAllowedToMove, shaderVeil: &shaderVeil)
                acceptDeal.alpha = 1
                (secondBody.node as! Trader).alpha = 0.5
                (secondBody.node as! Trader).isActive = false
                (secondBody.node as! Trader).physicsBody?.categoryBitMask = ColliderFaction.player
                (secondBody.node as! Trader).physicsBody?.contactTestBitMask = ColliderFaction.bank
                (secondBody.node as! Trader).physicsBody?.collisionBitMask = ColliderFaction.bank
                
                print((secondBody.node as! Trader).floatingReturnPoint)
                print((secondBody.node as! Trader).randomOutcome)
                print((secondBody.node as! Trader).magnification)
                print((secondBody.node as! Trader).dealReturn)
                
                var crashBlockerOn: Bool = false
                for index in traderDetailsDatabase.indices{
                    if crashBlockerOn == false{
                        let traderScoped = traderDetailsDatabase[index]
                        var importantTraits: [Any] = []
                        importantTraits.append(traderInQuestion.alias)
                        importantTraits.append(traderInQuestion.deal)
                        let imageData = traderInQuestion.texture!.cgImage()
                        let UIData = UIImage(cgImage: imageData)
                        let dataData = UIData.pngData()!
                        importantTraits.append(dataData)
                        let traderScopedArray = traderScoped as! [Any]
                        if traderScopedArray[0] as! String == traderInQuestion.alias && traderScopedArray[2] as! Data == dataData{
                            print("his ass is caught!")
                            traderDetailsDatabase.remove(at: index)
                            crashBlockerOn = true
                            var importantUniqueValues: [Any] = []
                            importantUniqueValues.append(traderInQuestion.alias)
                            importantUniqueValues.append(traderInQuestion.deal)
                            let imgData = traderInQuestion.texture!.cgImage()
                            let uiData = UIImage(cgImage: imgData)
                            let dadaData = uiData.pngData()!
                            importantUniqueValues.append(dadaData)
                            let dealReturn = String(traderInQuestion.dealReturn)
                            importantUniqueValues.append(dealReturn)
                            let boolValue = String(traderInQuestion.isActive)
                            importantUniqueValues.append(boolValue)
                            let newChance = Int(generateRandomInteger(highestPossibility: 10, lowestPossibility: 0))
                            let newChanceString = String(newChance)
                            importantUniqueValues.append(newChanceString)
                            let magnification = String(traderInQuestion.magnification)
                            importantUniqueValues.append(magnification)
                            let floatingReturnPoint = String(traderInQuestion.floatingReturnPoint)
                            importantUniqueValues.append(floatingReturnPoint)
                            let cooldown = String(traderInQuestion.cooldownIncrement)
                            importantUniqueValues.append(cooldown)
                            let newNet = traderInQuestion.dealReturn + traderInQuestion.netReturns
                            let netReturns = String(newNet)
                            importantUniqueValues.append(netReturns)
                            traderDetailsDatabase.append(importantUniqueValues)
                            MemoryVault.setValue(traderDetailsDatabase, forKey: "tradersLinked")
                        }
                    }
                }
            }
        }

        if firstBody.node?.name == "wrench" && secondBody.node?.name == "trader"{
            let sparks = SKEmitterNode(fileNamed: "WrenchSpark")!
            sparks.position = firstBody.node!.position
            sparks.numParticlesToEmit = 50
            self.addChild(sparks)
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "bud" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "bud" && secondBody.node?.name == "clickSwitch"{
            if clickSwitchFailSafeIsOn{
                clickSwitchFailSafeIsOn = false
                initiateIntro(present: false)
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        bud.position = bud.position
        birdCamera.position = bud.position
        shaderVeil.position = bud.position
        if bud.position == CGPoint(x: 0, y: -100) || bud.position == CGPoint(x: -800, y: -535) || bud.position == CGPoint(x: -800, y: 580) || bud.position == CGPoint(x: 800, y: -535) || bud.position == CGPoint(x: 800, y: 580) || bud.position == CGPoint(x: 0, y: -900){
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
        
        if bitTexture != noBit{
            keepBitMoving(bitCharacter: &bit, parentPosition: bud.position, isParentMoving: budIsMoving, isPermittedToMove: isAllowedToMove, sceneFrom: self, isOnMap: false)
        }
    }
    
}


//

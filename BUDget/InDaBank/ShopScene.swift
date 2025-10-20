//
//  ShopScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/23/23.
//

import Foundation
import SpriteKit

class ShopScene: SKScene{
    
    var coinIcon = SKSpriteNode()
    var coinCounter = SKLabelNode()
    var escapeButton = SKSpriteNode()
    var killSwitch: Bool = false
    var budCollection = SKSpriteNode()
    var bitCollection = SKSpriteNode()
    var wrenchCollection = SKSpriteNode()
    var accountAligner = SKSpriteNode()
    var itemArray: [Bool] = []
    var video = SKCameraNode()
    var wx = -200
    var wy = -1500
    var oneWrench = SKSpriteNode()
    var fiveWrenches = SKSpriteNode()
    var allWrenches = SKSpriteNode()
    
    //buMain is defaultBud
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
    var budIncrement = 0
    var incrementSpace = 300
    var baseNum = 300
    
    //bitMain is no bit
    var bitMain = Item()
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
    var bitIncrement = 0
    var bitIncrementSpace = 300
    var bitBase = 300
    var anchorY: Int = 0
    
    var startPointY: Int = 0
    var endPointY: Int = 0
    var Ydifference: Int = 0
    var touchSwitch = false
    var budTextureLocal = SKTexture()
    var blowoutLabel = SKLabelNode()
    var blowoutCoin = SKSpriteNode()
    var blowoutButton = SKSpriteNode()
    var selectedItem = Item()
    var dragLockOn: Bool = false
    var screenOn: String = "home"
    var bottomCap: CGFloat = 0
    var adjustBreaker: Bool = false
    
    var oneWrenchPrice = 20
    var fiveWrenchPrice = 60
    var allWrenchPrice = 250
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.camera = video
        self.addChild(video)
        
        setUpMainPage()
        setUpWrenchSector()
        setUpBudColors()
        setUpBits()
    }
    
    func setUpWrenchSector(){
        oneWrench = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: -200, y: -1200), texture: oneWrenchTexture, scale: 0.2)
        fiveWrenches = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: -1200), texture: fiveWrenchesTexture, scale: 0.2)
        allWrenches = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 200, y: -1200), texture: allWrenchesTexture, scale: 0.2)
        
        addCoin(whereAt: CGPoint(x: oneWrench.position.x - 50, y: oneWrench.position.y - 100))
        addCoin(whereAt: CGPoint(x: fiveWrenches.position.x - 50, y: fiveWrenches.position.y - 100))
        addCoin(whereAt: CGPoint(x: allWrenches.position.x - 50, y: allWrenches.position.y - 100))
        
        addPrice(whereAt: CGPoint(x: oneWrench.position.x + 20, y: oneWrench.position.y - 120), price: 20)
        addPrice(whereAt: CGPoint(x: fiveWrenches.position.x + 20, y: fiveWrenches.position.y - 120), price: 60)
        addPrice(whereAt: CGPoint(x: allWrenches.position.x + 20, y: allWrenches.position.y - 120), price: 250)

        if wrenchCount > 0{
            for _ in 1 ... wrenchCount{
                let _ = addSprite(sceneTo: self, zPosition: 2, position: CGPoint(x: wx, y: wy), texture: wrenchTexture, scale: 0.1)
                wx += 100
                if wx > 200{
                    wx = -200
                    wy -= 100
                }
            }
        }
        
        wx = -200
        wy = -1500
        
        for _ in 1 ... 25{
            let _ = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: wx, y: wy), texture: wrenchNilTexture, scale: 0.1)
            wx += 100
            if wx > 200{
                wx = -200
                wy -= 100
            }
        }
        wx = -200
        wy = -1500
    }
    
    func setUpMainPage(){
        escapeButton = addEscapeButton(sceneTo: self)
        coinIcon = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: -250, y: 450), texture: coinTexture, scale: 0.1)
        coinCounter = addLabel(sceneTo: self, scale: 50, position: CGPoint(x: 20, y: 430), color: .black, text: "\(budCoin)", zPosition: 1)
        accountAligner = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: 0, y: 450), texture: questionqTexture, scale: 0.6)
        
        budCollection = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: -175 , y: 100), texture: budShopTexture, scale: 0.55)
        
        bitCollection = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 175 , y: 100), texture: bitShopTexture, scale: 0.55)

        wrenchCollection = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0 , y: -200), texture: wrenchShopTexture, scale: 0.55)
        
        toggleSwipeCapabilities(turnThemOn: true)
        addSwipeCapability(sceneTo: self, selector: #selector(swipeLeft), direction: .left)
        addSwipeCapability(sceneTo: self, selector: #selector(swipeRight), direction: .right)
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }
    
    func toggleSwipeCapabilities(turnThemOn: Bool){
        switch turnThemOn{
        case true:
            addSwipeCapability(sceneTo: self, selector: #selector(swipeUp), direction: .up)
            addSwipeCapability(sceneTo: self, selector: #selector(swipeDown), direction: .down)
        case false:
            removeSwipeCapability(sceneTo: self, direction: .down)
            removeSwipeCapability(sceneTo: self, direction: .up)
        }
    }
    
    // 13 different colors of bud(0 -> 12 index)
    func setUpBudColors(){
        if let budColores = MemoryVault.value(forKey: "budColors") as? [Bool]{
            budColors = budColores
        }else{
            budColors.append(contentsOf: [true, false, false, false, false, false, false, false, false, false, false, false, false])
            MemoryVault.setValue(budColors, forKey: "budColors")
        }
        
        budArray.append(contentsOf: [budMain, budRed, budOrange, budYellow, budLightGreen, budDarkGreen, budLightBlue, budDarkBlue, budPurple, budPink, budMagenta, budBrown, budGrey])
        
        for index in budArray.indices{
            switch budIncrement{
            case 0:
                budTextureLocal = defaultBud
            case (-baseNum):
                budTextureLocal = redBud
            case (-baseNum*2):
                budTextureLocal = orangeBud
            case (-baseNum*3):
                budTextureLocal = yellowBud
            case (-baseNum*4):
                budTextureLocal = lightGreenBud
            case (-baseNum*5):
                budTextureLocal = darkGreenBud
            case (-baseNum*6):
                budTextureLocal = lightBlueBud
            case (-baseNum*7):
                budTextureLocal = darkBlueBud
            case (-baseNum*8):
                budTextureLocal = purpleBud
            case (-baseNum*9):
                budTextureLocal = pinkBud
            case (-baseNum*10):
                budTextureLocal = magentaBud
            case (-baseNum*11):
                budTextureLocal = brownBud
            case (-baseNum*12):
                budTextureLocal = greyBud
            default:
                break
            }
            let itemPurchasedIndex = budIncrement / -baseNum
            let purchasedBoolean = budColors[itemPurchasedIndex]
            budArray[index] = Item(texture: budTextureLocal)
            budArray[index].setUpItem(sceneFor: self, texture: budTextureLocal, position: CGPoint(x: -1200, y: budIncrement), scale: 0.25, purchasedItem: purchasedBoolean, indexOnArray: itemPurchasedIndex)
            budArray[index].zPosition = -1
            budIncrement -= baseNum
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
        
        anchorY = Int(budMain.position.y)
    }
    
    // 12 bits(0 -> 11 index)
    func setUpBits(){
        if let bytes = MemoryVault.value(forKey: "bitColors") as? [Bool]{
            bitColors = bytes
        }else{
            bitColors.append(contentsOf: [true, false, false, false, false, false, false, false, false, false, false, false, false])
            MemoryVault.setValue(bitColors, forKey: "bitColors")
        }
        
        bitArray.append(contentsOf: [bitMain, bitRed, bitOrange, bitYellow, bitLightGreen, bitDarkGreen, bitBlue, bitViolet, bitPurple, bitHotPink, bitPink, bitBrown, bitGrey])
        for index in bitArray.indices{
            var localTexture = bitTexturePallet[index]
        
            let indexPoint = bitIncrement / -bitBase
            let booleanPoint = bitColors[indexPoint]
            bitArray[index] = Item(texture: localTexture)
            bitArray[index].setUpItem(sceneFor: self, texture: localTexture, position: CGPoint(x: 1175, y: bitIncrement), scale: 0.65, purchasedItem: booleanPoint, indexOnArray: indexPoint)
            bitArray[index].zPosition = -1
            bitArray[index].priceOfItem *= 10
            bitIncrement -= bitBase
        }
        
        bitMain = bitArray[0]
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
    }
    
    @objc func swipeUp(){
        print("swipeUp")
        if video.position.y == 0 && video.position.x == 0{
            video.run(SKAction.moveTo(y: -1400, duration: 0.75))
            screenOn = "wrenches"
        }
    }
    
    @objc func swipeDown(){
        print("swipeDown")
        if video.position.y == -1400 && video.position.x == 0{
            video.run(SKAction.moveTo(y: 0, duration: 0.75))
            screenOn = "home"
        }
    }
    
    @objc func swipeLeft(){
        if video.position.x == 0 && video.position.y == 0{
            video.run(SKAction.moveTo(x: 1000, duration: 0.75))
            screenOn = "bits"
            toggleSwipeCapabilities(turnThemOn: false)
        }else if video.position.x == -1000 && video.position.y == 0{
            video.run(SKAction.moveTo(x: 0, duration: 0.75))
            screenOn = "home"
            toggleSwipeCapabilities(turnThemOn: true)
        }
    }
    
    @objc func swipeRight(){
        if video.position.x == 0 && video.position.y == 0{
            video.run(SKAction.moveTo(x: -1000, duration: 0.75))
            screenOn = "buds"
            toggleSwipeCapabilities(turnThemOn: false)
        }else if video.position.x == 1000 && video.position.y == 0{
            video.run(SKAction.moveTo(x: 0, duration: 0.75))
            screenOn = "home"
            toggleSwipeCapabilities(turnThemOn: true)
        }
    }
    
    @objc func pinchReaction(){
        dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "BankR", k_switch: &killSwitch)
    }
    
    func addCoin(whereAt: CGPoint){
        let _ = addSprite(sceneTo: self, zPosition: 1, position: whereAt, texture: coinTexture, scale: 0.1)
    }
    
    func addPrice(whereAt: CGPoint, price: Int){
        let _ = addLabel(sceneTo: self, scale: 50, position: whereAt, color: .black, text: "\(price)", zPosition: 1)
    }
    
    func manageTransaction(coinMin: Int, wrenchesAdded: Int){
        if wrenchCount < 25{
            if budCoin >= coinMin{
                switch coinMin{
                case oneWrenchPrice:
                    drainCoins(howMany: -coinMin, startingPos: coinCounter.position, endingPos: oneWrench.position)
                case fiveWrenchPrice:
                    drainCoins(howMany: -coinMin, startingPos: coinCounter.position, endingPos: fiveWrenches.position)
                case allWrenchPrice:
                    drainCoins(howMany: -coinMin, startingPos: coinCounter.position, endingPos: allWrenches.position)
                default:
                    break
                }
                if wrenchesAdded == 25{
                    wrenchCount = wrenchesAdded
                }else{
                    wrenchCount += wrenchesAdded
                }
                MemoryVault.setValue(wrenchCount, forKey: "wrenchCount")
                MemoryVault.setValue(budCoin, forKey: "coin")
                if wrenchesAdded > 1{
                    appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "shopKeeper", transactionAmount: wrenchesAdded, transactionItem: "wrenches")
                }else{
                    appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "shopKeeper", transactionAmount: wrenchesAdded, transactionItem: "wrench")
                }
                for _ in 1 ... wrenchCount{
                    _ = addSprite(sceneTo: self, zPosition: 2, position: CGPoint(x: wx, y: wy), texture: wrenchTexture, scale: 0.1)
                    wx += 100
                    if wx > 200{
                        wx = -200
                        wy -= 100
                    }
                }
                wx = -200
                wy = -1500
            }else{
                heavy.impactOccurred()
            }
        }
    }
    
    func drainCoins(howMany: Int, startingPos: CGPoint, endingPos: CGPoint){
        // range is 10 coins to 1000 coins for a single transaction
        // I want process to take about 1 second
        
        if howMany != 0 && ((howMany < 0 && abs(howMany) <= budCoin) || howMany > 0){
            let distance = findDistanceBetweenPoints(currentPoint: startingPos, targetPoint: endingPos)
            let modifier = 2000.0
            let runTime = TimeInterval(distance / modifier)
            let loopTime = TimeInterval(0.5 / CGFloat(abs(howMany)))
            print(loopTime)
            
            appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "shopKeeper", transactionAmount: howMany, transactionItem: "coins")
            
            let spawnCoin = SKAction.run{
                light.impactOccurred()
                
                let coin = addSprite(sceneTo: self, zPosition: 1, position: startingPos, texture: coinTexture, scale: 0.05)
                if howMany > 0{
                    budCoin += 1
                }else{
                    budCoin -= 1
                }
                self.coinCounter.text = "\(budCoin)"
                MemoryVault.set(budCoin, forKey: "coin")
                coin.run(SKAction.sequence([SKAction.move(to: endingPos, duration: runTime), SKAction.removeFromParent()]))
            }

            self.run(SKAction.repeat(SKAction.sequence([spawnCoin, SKAction.wait(forDuration: loopTime)]), count: abs(howMany)))
        }
    }
    
    func popOutPurchaseBar(price: Int, boughtItem: Bool, itemPressed: Item, bitOrBud: String){
        let itemPos = itemPressed.position
        if bitOrBud == "bud"{
            blowoutCoin = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: itemPos.x + 120, y: itemPos.y), texture: coinTexture, scale: 0.075)
            blowoutLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: itemPos.x + 360, y: itemPos.y - 10), color: .black, text: "\(itemPressed.priceOfItem) BUDcoin", zPosition: 0)
            if itemPressed.purchased{
                blowoutButton = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: itemPos.x + 200, y: itemPos.y), texture: sellTexture, scale: 0.25)
            }else{
                blowoutButton = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: itemPos.x + 200, y: itemPos.y), texture: buyTexture, scale: 0.25)
            }
        }else{
            blowoutCoin = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: itemPos.x - 100, y: itemPos.y), texture: coinTexture, scale: 0.075)
            blowoutLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: itemPos.x - 350, y: itemPos.y - 10), color: .black, text: "BUDcoin: \(itemPressed.priceOfItem)", zPosition: 0)
            if itemPressed.purchased{
                blowoutButton = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: itemPos.x - 180, y: itemPos.y), texture: sellTexture, scale: 0.25)
            }else{
                blowoutButton = addSprite(sceneTo: self, zPosition: 0, position: CGPoint(x: itemPos.x - 180, y: itemPos.y), texture: buyTexture, scale: 0.25)
            }
        }
        selectedItem = itemPressed
    }
    
    func removePopOutBar(){
        blowoutCoin.removeFromParent()
        blowoutLabel.removeFromParent()
        blowoutButton.removeFromParent()
        selectedItem = Item(texture: ramayTexture)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if escapeButton.contains(position){
                dashTransition(sceneTo: BlackOutTransition(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "BankR", k_switch: &killSwitch)
            }
            
            if oneWrench.contains(position){
                manageTransaction(coinMin: 20, wrenchesAdded: 1)
            }
            
            if fiveWrenches.contains(position){
                manageTransaction(coinMin: 60, wrenchesAdded: 5)
            }
            
            if allWrenches.contains(position){
                manageTransaction(coinMin: 250, wrenchesAdded: 25)
            }
            
            for index in budArray.indices{
                if budArray[index].contains(position) && budArray[index].texture != defaultBud{
                    if budArray[index] != selectedItem{
                        removePopOutBar()
                        popOutPurchaseBar(price: budArray[index].priceOfItem, boughtItem: budArray[index].purchased, itemPressed: budArray[index], bitOrBud: "bud")
                    }else{
                        removePopOutBar()
                    }
                }
            }
            
            for index in bitArray.indices{
                let bit = bitArray[index]
                if bit.contains(position) && bit.texture != noBit{
                    if bit.texture != selectedItem.texture{
                        removePopOutBar()
                        popOutPurchaseBar(price: bit.priceOfItem, boughtItem: bit.purchased, itemPressed: bit, bitOrBud: "bit")
                    }else{
                        removePopOutBar()
                    }
                }
            }
            
            if blowoutButton.contains(position){
                if blowoutButton.texture == buyTexture{
                    let price = selectedItem.priceOfItem
                    if abs(price) <= budCoin{
                        drainCoins(howMany: -price, startingPos: coinCounter.position, endingPos: selectedItem.position)
                        selectedItem.alpha = 1
                        selectedItem.purchased = true
                        blowoutButton.texture = sellTexture
                        if blowoutButton.position.x < 0{
                            budColors.remove(at: selectedItem.index)
                            budColors.insert(true, at: selectedItem.index)
                            MemoryVault.set(budColors, forKey: "budColors")
                        }else if blowoutButton.position.x > 0{
                            bitColors.remove(at: selectedItem.index)
                            bitColors.insert(true, at: selectedItem.index)
                            MemoryVault.set(bitColors, forKey: "bitColors")
                        }
                    }else{
                        heavy.impactOccurred()
                    }
                }else{
                    let price = selectedItem.priceOfItem
                    drainCoins(howMany: price, startingPos: selectedItem.position, endingPos: coinCounter.position)
                    selectedItem.alpha = 0.5
                    selectedItem.purchased = false
                    var currentBudTexture = SKTexture()
                    extractPNG(forVariable: &currentBudTexture)
                    if selectedItem.texture == currentBudTexture{
                        let budData = defaultBud.cgImage()
                        let bData = UIImage(cgImage: budData)
                        let dataData = bData.pngData()
                        MemoryVault.setValue(dataData, forKey: "character")
                    }else if selectedItem.texture == bitTexture{
                        let bitTextureOption = noBit.cgImage()
                        let bitImage = UIImage(cgImage: bitTextureOption)
                        let bitData = bitImage.pngData()
                        MemoryVault.setValue(bitData, forKey: "bit")
                    }
                    blowoutButton.texture = buyTexture
                    if blowoutButton.position.x < 0{
                        budColors.remove(at: selectedItem.index)
                        budColors.insert(false, at: selectedItem.index)
                        MemoryVault.set(budColors, forKey: "budColors")
                    }else if blowoutButton.position.x > 0{
                        bitColors.remove(at: selectedItem.index)
                        bitColors.insert(false, at: selectedItem.index)
                        MemoryVault.set(bitColors, forKey: "bitColors")
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            if touchSwitch == false{
                touchSwitch = true
                startPointY = Int(position.y)
            }
            endPointY = Int(position.y)
            Ydifference = endPointY - startPointY
            print(endPointY)
            let newPositionY = Ydifference + anchorY
            let bmy = budMain.position.y
            if bmy >= 0 && bmy <= 3600 && dragLockOn == false{
                budMain.position.y = CGFloat(newPositionY)
            }else if bmy < 0{
                budMain.position.y = 0
                dragLockOn = true
            }else if bmy > 3600{
                budMain.position.y = 3600
                dragLockOn = true
            }
            var localIncrementSpace = CGFloat(incrementSpace)
            moveWithLead(spriteMoving: &budRed, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budOrange, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budYellow, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budLightGreen, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budDarkGreen, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budLightBlue, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budDarkBlue, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budPurple, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budPink, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budMagenta, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budBrown, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            moveWithLead(spriteMoving: &budGrey, increment: &localIncrementSpace, incrementUnit: incrementSpace)
            localIncrementSpace = 0
            moveWithLead(spriteMoving: &bitMain, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            
            moveWithLead(spriteMoving: &bitRed, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitOrange, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitYellow, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitLightGreen, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitDarkGreen, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitBlue, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitViolet, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitPurple, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitHotPink, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitPink, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitBrown, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            moveWithLead(spriteMoving: &bitGrey, increment: &localIncrementSpace, incrementUnit: bitIncrementSpace)
            let sy = selectedItem.position.y
            blowoutCoin.position.y = sy
            blowoutLabel.position.y = sy - 10
            blowoutButton.position.y = sy
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchSwitch = false
        anchorY = Int(budMain.position.y)
        dragLockOn = false
    }
    
    func moveWithLead(spriteMoving: inout Item, increment: inout CGFloat, incrementUnit: Int){
        spriteMoving.position.y = budMain.position.y - increment
        increment += CGFloat(incrementUnit)
    }
    
    override func update(_ currentTime: TimeInterval) {
        let vx = video.position.x
        let vy = video.position.y
        coinIcon.position = CGPoint(x: vx - 250, y: vy + 450)
        coinCounter.position = CGPoint(x: vx + 20, y: vy + 430)
        accountAligner.position = CGPoint(x: vx, y: vy + 450)
        escapeButton.position = CGPoint(x: vx - 250, y: vy + 550)
    }
}

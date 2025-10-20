//
//  QuestionsScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 11/26/23.
//

import Foundation
import SpriteKit


class QuestionsScene: SKScene{
    
    var somethingNotWorking = SKSpriteNode()
    var somethingNotWorkingLabel = SKLabelNode()
    var howToChangeSomething = SKSpriteNode()
    var howToChangeSomethingLabel = SKLabelNode()
    var howToUseSomething = SKSpriteNode()
    var howToUseSomethingLabel = SKLabelNode()
    var proTips = SKSpriteNode()
    var proTipsLabel = SKLabelNode()
    var howToGetSomewhere = SKSpriteNode()
    var howToGetSomewhereLabel = SKLabelNode()
    var boxList: [SKSpriteNode] = []
    var somethingDeployed: Bool = false
    
    var escapeButton = SKSpriteNode()
    
    override func didMove(to view: SKView){
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        escapeButton = addEscapeButton(sceneTo: self)
        
        let lockRange = SKRange(constantValue: 0)
        
        somethingNotWorking = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 400), texture: questionqTexture, scale: 0.6)
        somethingNotWorkingLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: 0, y: 400), color: .black, text: "Something is not working:", zPosition: 2)
        addPositionLock(objectToLock: &somethingNotWorkingLabel, anchorToLock: somethingNotWorking, lockRangeDistance: lockRange)
        somethingNotWorkingLabel.verticalAlignmentMode = .center
        
        
        howToChangeSomething = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 200), texture: questionqTexture, scale: 0.6)
        howToChangeSomethingLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: 0, y: 200), color: .black, text: "How to change something:", zPosition: 2)
        addPositionLock(objectToLock: &howToChangeSomethingLabel, anchorToLock: howToChangeSomething, lockRangeDistance: lockRange)
        howToChangeSomethingLabel.verticalAlignmentMode = .center
        
        
        howToUseSomething = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 0), texture: questionqTexture, scale: 0.6)
        howToUseSomethingLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: 0, y: 0), color: .black, text: "How to use something:", zPosition: 2)
        addPositionLock(objectToLock: &howToUseSomethingLabel, anchorToLock: howToUseSomething, lockRangeDistance: lockRange)
        howToUseSomethingLabel.verticalAlignmentMode = .center
        
        
        proTips = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: -200), texture: questionqTexture, scale: 0.6)
        proTipsLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: 0, y: -200), color: .black, text: "Pro tips and mediocre tips:", zPosition: 2)
        addPositionLock(objectToLock: &proTipsLabel, anchorToLock: proTips, lockRangeDistance: lockRange)
        proTipsLabel.verticalAlignmentMode = .center
        
        
        howToGetSomewhere = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: -400), texture: questionqTexture, scale: 0.6)
        howToGetSomewhereLabel = addLabel(sceneTo: self, scale: 40, position: CGPoint(x: 0, y: -400), color: .black, text: "How to get somewhere:", zPosition: 2)
        addPositionLock(objectToLock: &howToGetSomewhereLabel, anchorToLock: howToGetSomewhere, lockRangeDistance: lockRange)
        howToGetSomewhereLabel.verticalAlignmentMode = .center
        
        boxList.append(contentsOf: [somethingNotWorking, howToChangeSomething, howToUseSomething, proTips, howToGetSomewhere])
        
        somethingNotWorking = boxList[0]
        howToChangeSomething = boxList[1]
        howToUseSomething = boxList[2]
        proTips = boxList[3]
        howToGetSomewhere = boxList[4]
        
        addPinchCapability(sceneTo: self, selector: #selector(getOutOfQnA))
    }
    
    func addPositionLock(objectToLock: inout SKLabelNode, anchorToLock: SKSpriteNode, lockRangeDistance: SKRange){
        let lockConstraint = SKConstraint.distance(lockRangeDistance, to: anchorToLock)
        objectToLock.constraints = [lockConstraint]
    }
 
    @objc func getOutOfQnA(){
        moveToScene(sceneTo: BankScene(size: self.size), sceneFrom: self)
        sceneSetTo = "TellerHome"
    }
    
    func cloneLabel(uniqueText: String) -> SKLabelNode{
        let label = addLabel(sceneTo: self, scale: 20, position: CGPoint(x: 250, y: 400), color: .black, text: uniqueText, zPosition: 2)
        label.verticalAlignmentMode = .top
        label.horizontalAlignmentMode = .left
        label.preferredMaxLayoutWidth = 500
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 3
        label.name = "bullet"
        
        return label
    }
    
    func slideEverythingAway(indexOfSpriteNotToMove: Int){
        if somethingDeployed{
            var increment = 400
            for index in boxList.indices{
                boxList[index].run(SKAction.move(to: CGPoint(x: 0, y: increment), duration: 0.25))
                increment -= 200
            }
            
            for child in self.children{
                if child.name == "bullet"{
                    child.run(SKAction.sequence([SKAction.move(to: CGPoint(x: -1250, y: -1000), duration: 1), SKAction.removeFromParent()]))
                }
            }
            
            somethingDeployed = false
        }else{
            boxList[indexOfSpriteNotToMove].run(SKAction.move(to: CGPoint(x: 0, y: 400), duration: 0.25))
            for index in boxList.indices{
                if index != indexOfSpriteNotToMove{
                    boxList[index].run(SKAction.move(to: CGPoint(x: 0, y: -1000), duration: 0.25))
                }
            }
            
            // something not working
            
            var label = cloneLabel(uniqueText: "I can't scroll! It's just lagging and glitching! (-----) Press down, hold for a second, and then drag slowly. For a more permanent solution, just restart app.")
            var label2 = cloneLabel(uniqueText: "I can't accept any more investors! (-----) You have reached the limit of 20, please break deals with ones you are bonded with to hire new investors.")
            var label3 = cloneLabel(uniqueText: "I can't escape some screens! The stairs button is hidden! (-----) Try pinching, I made sure to let people escape that way. In fact, try now!")
            var label4 = cloneLabel(uniqueText: "I can't buy the stuff I want! (-----) You are lacking the funds to do so, please use my 'pro tips' to help you get more money.")
            var label5 = cloneLabel(uniqueText: "I can't move, and wrenches are flying around me! (-----) Shake the phone, and you will be activating / deactivating the wrench ability.")
            var label6 = cloneLabel(uniqueText: "I am lost, and I need a way back to the bank! (-----) Tap on your 'bud' character, and he will teleport back home!")
        
            
            
            switch indexOfSpriteNotToMove{
                case 1: // how to change something
                label.removeFromParent()
                label2.removeFromParent()
                label3.removeFromParent()
                label4.removeFromParent()
                label5.removeFromParent()
                label6.removeFromParent()
                    label = cloneLabel(uniqueText: "How do I change my 'bud' character? (-----) Buy a color, and then go to profile, where you will press on the giant bud and scroll up to the color you chose, and press it.")
                    label2 = cloneLabel(uniqueText: "How do I change my 'bit' character? (-----) Go to profile, press the bit on the shoulder of bud, and select the color that you bought.")
                    label3 = cloneLabel(uniqueText: "How do I change the investors I am bonded with? (-----) Wait until they come with a new opportunity, and decline their deal to get rid of them.")
                    label4 = cloneLabel(uniqueText: "How do I get rid of my progress? (-----) THAT IS THE SECRET I WANT SOMEBODY TO FIND *HINT* 'Lost in firefly forest by Casper van Dommelen was an inspiration'")
                    label5 = cloneLabel(uniqueText: "How do I get rid of my 'bit' character? (-----) Go to profile, and select the bit that is crossed out after pressing on the bit on the shoulder of the giant bud.")
                    label6 = cloneLabel(uniqueText: "How do I view a different video? (-----) Go to the videos section in the bank, and when in the library scroll through the options, selecting whatever description you like best. ")
                case 2: // how to use something
                label.removeFromParent()
                label2.removeFromParent()
                label3.removeFromParent()
                label4.removeFromParent()
                label5.removeFromParent()
                label6.removeFromParent()
                    label = cloneLabel(uniqueText: "How is 'bit' useful? (-----) Your 'bit', *if you have one*, will always guide you towards the closest available investor  on the map!")
                    label2 = cloneLabel(uniqueText: "How do I use my wrenches? (-----) Shakle your phone, wait for my bada** animation to end, and tap on the screen to throw the wrenches! *Some targets do fun stuff!*")
                    label3 = cloneLabel(uniqueText: "How do I use the bank teller stuff? (-----) Just approach the bank teller, or crash into a wall, and he will give you quiz, help, database, and logs to help you get rich!")
                    label4 = cloneLabel(uniqueText: "How do I use my BUDcoin? (-----) Buy colors, bits, wrenches, get richer, whatever you would like!")
                    label5 = cloneLabel(uniqueText: "How do I use the other stuff here? (-----) Just keep looking through questions, and experiment! I HAD 3 YOUNGER SISTERS TEST MY APP TO A PERFORATED DECOR.")
                    label6 = cloneLabel(uniqueText: "How do I use the videos? (-----) You just watch one, get a reward for it, and learn a little while at it!")
                case 3: // pro tips
                label.removeFromParent()
                label2.removeFromParent()
                label3.removeFromParent()
                label4.removeFromParent()
                label5.removeFromParent()
                label6.removeFromParent()
                    label = cloneLabel(uniqueText: "If stuff is slow and getting stuck, make sure you did what you wanted one more time, and then WAIT. I am a teenager, and currently lack the brains and time to make things snappier.")
                    label2 = cloneLabel(uniqueText: "The quiz is the FASTEST way to get money")
                    label3 = cloneLabel(uniqueText: "The shop is the SNEAKIEST way to get money HINT: *The prices never stay the same!*")
                    label4 = cloneLabel(uniqueText: "The investors are the OPTIMAL way to get money")
                    label5 = cloneLabel(uniqueText: "The videos are the most EDUCATIONAL way to get money")
                    label6 = cloneLabel(uniqueText: "Don't try to just 'learn', try to beat my app! If you beat it, then THAT is how you learn best! Win - win!")
                case 4: // how to get somewhere
                label.removeFromParent()
                label2.removeFromParent()
                label3.removeFromParent()
                label4.removeFromParent()
                label5.removeFromParent()
                label6.removeFromParent()
                    label = cloneLabel(uniqueText: "How do I get back to the bank on the map? (-----) Press on the bud character, and he will teleport back to the bank!")
                    label2 = cloneLabel(uniqueText: "How do I get to the videos section? (-----) Go to the bottom right corner of the bank!")
                    label3 = cloneLabel(uniqueText: "How do I get to the shop section? (-----) Go to the top left corner of the bank!")
                    label4 = cloneLabel(uniqueText: "How do I get to the profile section? (-----) Go to the top right corner of the bank!")
                    label5 = cloneLabel(uniqueText: "How do I get to the quiz? (-----) Select the leftmost option of the bank teller!")
                    label6 = cloneLabel(uniqueText: "How do I see what transactions I recently made? (-----) Select the second to the right box to see the transaction database!")
                default:
                    break
            }
            
            let marginBorder = -250
            
            label.run(SKAction.move(to: CGPoint(x: marginBorder, y: 300), duration: 0.5))
            label2.run(SKAction.move(to: CGPoint(x: marginBorder, y: 150), duration: 0.5))
            label3.run(SKAction.move(to: CGPoint(x: marginBorder, y: 0), duration: 0.5))
            label4.run(SKAction.move(to: CGPoint(x: marginBorder, y: -150), duration: 0.5))
            label5.run(SKAction.move(to: CGPoint(x: marginBorder, y: -300), duration: 0.5))
            label6.run(SKAction.move(to: CGPoint(x: marginBorder, y: -450), duration: 0.5))
            
            somethingDeployed = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let position = touch.location(in: self)
            
            if somethingNotWorking.contains(position){
                slideEverythingAway(indexOfSpriteNotToMove: 0)
            }
            
            if howToChangeSomething.contains(position){
                slideEverythingAway(indexOfSpriteNotToMove: 1)
            }
            
            if howToUseSomething.contains(position){
                slideEverythingAway(indexOfSpriteNotToMove: 2)
            }
            
            if proTips.contains(position){
                slideEverythingAway(indexOfSpriteNotToMove: 3)
            }
            
            if howToGetSomewhere.contains(position){
                slideEverythingAway(indexOfSpriteNotToMove: 4)
            }
            
            if escapeButton.contains(position){
                moveToScene(sceneTo: BankScene(size: self.size), sceneFrom: self)
                sceneSetTo = "TellerHome"
            }
            
        }
    }
}

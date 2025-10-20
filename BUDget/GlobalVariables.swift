//
//  GlobalVariables.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/22/23.
//

import Foundation
import SpriteKit
import AVFoundation
import AVKit
import UIKit


//  SSSSS
//  S   S
//  S
//  SSSSS
//      S
//  S   S
//  SSSSS  tructs




// Structure for the physics categories("Factions")
struct ColliderFaction{
    static let player: UInt32 = 0
    static let bank: UInt32 = 1
    static let pickup: UInt32 = 2
    static let trader: UInt32 = 4
    static let tbd: UInt32 = 8
    static let walls: UInt32 = 16
    static let sponsor: UInt32 = 32
    static let wrench: UInt32 = 64
}


//   CCCCCC
//  CC
//  C
//  C
//  CC
//   CCCCCC  lasses


// Custom class for traders to add the "aliasName" characteristic to sprites, among other special duplicable data properties.
class Trader: SKSpriteNode{
    
    var alias: String = ""
    var deal: String = ""
    var floatingReturnPoint = Int()
    var magnification = Int()
    var dealReturn = Int()
    var isActive: Bool = false
    var cooldownIncrement = generateRandomInteger(highestPossibility: 10, lowestPossibility: 1)
    var randomOutcome = generateRandomInteger(highestPossibility: 10, lowestPossibility: 0)
    var netReturns: Int = 0
    
    func setUp(sceneFor: SKScene, radii: Int){
        
        let randomX = generateRandomInteger(highestPossibility: radii, lowestPossibility: -radii)
        let randomY = generateRandomInteger(highestPossibility: radii, lowestPossibility: -radii)
        let randomTexture = generateRandomInteger(highestPossibility: 4, lowestPossibility: 0)
        var aliasName = ""
        for _ in 1 ... 4{
            aliasName += randomAdjective(spaceAfter: true)
        }
        aliasName += randomName(spaceAfter: false)
        
        
        let randomDeal = generateRandomInteger(highestPossibility: 4, lowestPossibility: 0)
        
        cooldownIncrement = generateRandomInteger(highestPossibility: 5, lowestPossibility: 1)
        
        let randomDealDescription = generateRandomInteger(highestPossibility: 4, lowestPossibility: 0)
        
        switch randomDeal{
        case 0: // SCAM --- SCAM --- SCAM --- SCAM --- SCAM --- SCAM --- SCAM --- SCAM --- SCAM --- SCAM
            deal = deals[randomDealDescription + 20]
            floatingReturnPoint = 1
            magnification = generateRandomInteger(highestPossibility: 1000, lowestPossibility: 1)
            // Hi: 100, Lo: -900
        case 1: // DANGEROUS --- DANGEROUS --- DANGEROUS --- DANGEROUS --- DANGEROUS --- DANGEROUS --- DANGEROUS
            deal = deals[randomDealDescription + 15]
            floatingReturnPoint = 3
            magnification = generateRandomInteger(highestPossibility: 80, lowestPossibility: 1)
            // Hi: 150, Lo: -350
        case 2: // SHADY --- SHADY --- SHADY --- SHADY --- SHADY --- SHADY --- SHADY --- SHADY --- SHADY
            deal = deals[randomDealDescription + 10]
            floatingReturnPoint = 5
            magnification = generateRandomInteger(highestPossibility: 40, lowestPossibility: 1)
            // Hi: 175, Lo: -175
        case 3: // RISKY --- RISKY --- RISKY --- RISKY --- RISKY --- RISKY --- RISKY --- RISKY --- RISKY
            deal = deals[randomDealDescription + 5]
            floatingReturnPoint = 7
            magnification = generateRandomInteger(highestPossibility: 20, lowestPossibility: 1)
            // Hi: 140, Lo: -60
        case 4: // SAFE --- SAFE --- SAFE --- SAFE --- SAFE --- SAFE --- SAFE --- SAFE --- SAFE --- SAFE
            deal = deals[randomDealDescription]
            floatingReturnPoint = 9
            magnification = generateRandomInteger(highestPossibility: 12, lowestPossibility: 1)
            // Hi: 90, Lo: -10
        default:
            break
        }
        
        /// This means deal is the deal floater(9, 7, 5, 3, 1) and negative outcome(10 - 0), so:
        /// Safe is low of: -1(9 - 10), and a high of 9(9 - 0)
        /// Risky is low of: -3(7 - 10), and a high of 7(7 - 0)
        /// Shady is low of: -5(5 - 10), and a high of 5(5 - 0)
        /// Dangerous is low of: -7(3 - 10), and a high of 3(3 - 0)
        /// Scam is low of: -9(1 - 10), and a high of 1(1 - 0)
        ///
        /// And then magnify those
        
        dealReturn = (floatingReturnPoint - randomOutcome) * magnification
        netReturns += dealReturn
        
        
        self.position = CGPoint(x: randomX, y: randomY)
        self.zPosition = 1
        self.name = "trader"
        self.alias = aliasName
        self.texture = traderTexture
        self.setScale(0.25)
        sceneFor.addChild(self)
        
        switch randomTexture{
        case 0:
            self.texture = traderT1
        case 1:
            self.texture = traderT2
        case 2:
            self.texture = traderT3
        case 3:
            self.texture = traderT4
        case 4:
            self.texture = traderT5
        default:
            break
        }

        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = ColliderFaction.trader
        self.physicsBody?.contactTestBitMask = ColliderFaction.player
        self.physicsBody?.collisionBitMask = ColliderFaction.bank
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
    }
    func checkForCoolDown(sceneFor: SKScene){
        print("cooldownIncrement is: \(cooldownIncrement)")
        if walkCycles % cooldownIncrement == 0{
            self.physicsBody?.categoryBitMask = ColliderFaction.trader
            self.physicsBody?.contactTestBitMask = ColliderFaction.player
            self.physicsBody?.collisionBitMask = ColliderFaction.bank
            self.alpha = 1
            self.isActive = true
        }else{
            self.alpha = 0.5
            self.isActive = false
            self.physicsBody?.categoryBitMask = ColliderFaction.player
            self.physicsBody?.contactTestBitMask = ColliderFaction.bank
            self.physicsBody?.collisionBitMask = ColliderFaction.bank
        }
    }
}

// Custom class for sponsor ads to add the website link and rewards for visiting those websites
class Sponsor: SKSpriteNode{
    
    var companyName: String = ""
    var hook: String = ""
    var websiteLink = URL(string: "")
    var rewardForVisiting: Int = 0
    
    func setUp(sceneFor: SKScene, position: CGPoint, cn: String, h: String, wl: URL, rfv: Int, t: SKTexture){
        self.position = position
        self.zPosition = 100
        self.name = "sponsor"
        self.companyName = cn
        self.hook = h
        self.websiteLink = wl
        self.rewardForVisiting = rfv
        self.texture = t
        self.setScale(0.35)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.categoryBitMask = ColliderFaction.sponsor
        self.physicsBody?.contactTestBitMask = ColliderFaction.player
        self.physicsBody?.collisionBitMask = ColliderFaction.bank
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        sceneFor.addChild(self)
    }
}

class Item: SKSpriteNode{
    var priceOfItem = Int()
    var purchased = Bool()
    var index = Int()
    func setUpItem(sceneFor: SKScene, texture: SKTexture, position: CGPoint, scale: CGFloat, purchasedItem: Bool, indexOnArray: Int){
        self.texture = texture
        self.position = position
        self.setScale(scale)
        self.zPosition = 0
        self.index = indexOnArray
        self.priceOfItem = generateRandomInteger(highestPossibility: 100, lowestPossibility: 10)
        if purchasedItem{
            purchased = true
            self.alpha = 1
        }else{
            purchased = false
            self.alpha = 0.5
        }
        sceneFor.addChild(self)
        if self.texture == defaultBud{
            self.priceOfItem = 0
        }
    }
}

//    V       V
//     V     V
//      V   V
//       V V
//        V ariables

/// IMPACT OPTIONS *LISTED BY STRENGTH(TOP WEAK, BOTTOM HARD)*
let soft = UIImpactFeedbackGenerator(style: .soft)
let light = UIImpactFeedbackGenerator(style: .light)
let medium = UIImpactFeedbackGenerator(style: .medium)
let rigid = UIImpactFeedbackGenerator(style: .rigid)
let heavy = UIImpactFeedbackGenerator(style: .heavy)

/// IMPACT OPTIONS
var pinchRecognizer = UIPinchGestureRecognizer() // the recognizer that works with UIKit to sense specific gestures and output according analog data
var swipeLeftGesture = UISwipeGestureRecognizer() // UIKit sense for swiping left
var swipeRightGesture = UISwipeGestureRecognizer() // UIKit sense for swiping left
var swipeUpGesture = UISwipeGestureRecognizer() // UIKit sense for swiping left
var swipeDownGesture = UISwipeGestureRecognizer() // UIKit sense for swiping left

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//BUD TEXTURES
let defaultBud = SKTexture(imageNamed: "defaultBud") // front
let redBud = SKTexture(imageNamed: "redBud")
let orangeBud = SKTexture(imageNamed: "orangeBud")
let yellowBud = SKTexture(imageNamed: "yellowBud")
let lightGreenBud = SKTexture(imageNamed: "lightGreenBud")
let darkGreenBud = SKTexture(imageNamed: "darkGreenBud")
let lightBlueBud = SKTexture(imageNamed: "lightBlueBud")
let darkBlueBud = SKTexture(imageNamed: "darkBlueBud")
let purpleBud = SKTexture(imageNamed: "purpleBud")
let pinkBud = SKTexture(imageNamed: "pinkBud")
let magentaBud = SKTexture(imageNamed: "magentaBud")    
let brownBud = SKTexture(imageNamed: "brownBud")
let greyBud = SKTexture(imageNamed: "greyBud")
let budTexturePallet: [SKTexture] = [defaultBud, redBud, orangeBud, yellowBud, lightGreenBud, darkGreenBud, lightBlueBud, darkBlueBud, purpleBud, pinkBud, magentaBud, brownBud, greyBud] // a collection of every possible bud texture(mainly for extractPNG function)

let defaultBudBack = SKTexture(imageNamed: "defaultBudBack") // back
let redBudBack = SKTexture(imageNamed: "redBudBack")
let orangeBudBack = SKTexture(imageNamed: "orangeBudBack")
let yellowBudBack = SKTexture(imageNamed: "yellowBudBack")
let lightGreenBudBack = SKTexture(imageNamed: "lightGreenBudBack")
let darkGreenBudBack = SKTexture(imageNamed: "darkGreenBudBack")
let lightBlueBudBack = SKTexture(imageNamed: "lightBlueBudBack")
let darkBlueBudBack = SKTexture(imageNamed: "darkBlueBudBack")
let purpleBudBack = SKTexture(imageNamed: "purpleBudBack")
let pinkBudBack = SKTexture(imageNamed: "pinkBudBack")
let magentaBudBack = SKTexture(imageNamed: "magentaBudBack")
let brownBudBack = SKTexture(imageNamed: "brownBudBack")
let greyBudBack = SKTexture(imageNamed: "greyBudBack")

let defaultBudRight = SKTexture(imageNamed: "defaultBudRight") // right
let redBudRight = SKTexture(imageNamed: "redBudRight")
let orangeBudRight = SKTexture(imageNamed: "orangeBudRight")
let yellowBudRight = SKTexture(imageNamed: "yellowBudRight")
let lightGreenBudRight = SKTexture(imageNamed: "lightGreenBudRight")
let darkGreenBudRight = SKTexture(imageNamed: "darkGreenBudRight")
let lightBlueBudRight = SKTexture(imageNamed: "lightBlueBudRight")
let darkBlueBudRight = SKTexture(imageNamed: "darkBlueBudRight")
let purpleBudRight = SKTexture(imageNamed: "purpleBudRight")
let pinkBudRight = SKTexture(imageNamed: "pinkBudRight")
let magentaBudRight = SKTexture(imageNamed: "magentaBudRight")
let brownBudRight = SKTexture(imageNamed: "brownBudRight")
let greyBudRight = SKTexture(imageNamed: "greyBudRight")

let defaultBudLeft = SKTexture(imageNamed: "defaultBudLeft") // left
let redBudLeft = SKTexture(imageNamed: "redBudLeft")
let orangeBudLeft = SKTexture(imageNamed: "orangeBudLeft")
let yellowBudLeft = SKTexture(imageNamed: "yellowBudLeft")
let lightGreenBudLeft = SKTexture(imageNamed: "lightGreenBudLeft")
let darkGreenBudLeft = SKTexture(imageNamed: "darkGreenBudLeft")
let lightBlueBudLeft = SKTexture(imageNamed: "lightBlueBudLeft")
let darkBlueBudLeft = SKTexture(imageNamed: "darkBlueBudLeft")
let purpleBudLeft = SKTexture(imageNamed: "purpleBudLeft")
let pinkBudLeft = SKTexture(imageNamed: "pinkBudLeft")
let magentaBudLeft = SKTexture(imageNamed: "magentaBudLeft")
let brownBudLeft = SKTexture(imageNamed: "brownBudLeft")
let greyBudLeft = SKTexture(imageNamed: "greyBudLeft")
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//BIT TEXTURES
let redBit = SKTexture(imageNamed: "redBit")
let orangeBit = SKTexture(imageNamed: "orangeBit")
let yellowBit = SKTexture(imageNamed: "yellowBit")
let lightGreenBit = SKTexture(imageNamed: "lightGreenBit")
let darkGreenBit = SKTexture(imageNamed: "darkGreenBit")
let blueBit = SKTexture(imageNamed: "blueBit")
let violetBit = SKTexture(imageNamed: "violetBit")
let purpleBit = SKTexture(imageNamed: "purpleBit")
let hotPinkBit = SKTexture(imageNamed: "hotPinkBit")
let pinkBit = SKTexture(imageNamed: "pinkBit")
let brownBit = SKTexture(imageNamed: "brownBit")
let greyBit = SKTexture(imageNamed: "greyBit")
let noBit = SKTexture(imageNamed: "noBit")
let bitTexturePallet: [SKTexture] = [noBit, redBit, orangeBit, yellowBit, lightGreenBit, darkGreenBit, blueBit, violetBit, purpleBit, hotPinkBit, pinkBit, brownBit, greyBit] // a collection of every possible bit texture(mainly for extractBitPNG function)
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

let bitShopTexture = SKTexture(imageNamed: "bitShop")
let budShopTexture = SKTexture(imageNamed: "budShop")
let wrenchShopTexture = SKTexture(imageNamed: "wrenchShop")
let wrenchTexture = SKTexture(imageNamed: "wrench")
let menuTexture = SKTexture(imageNamed: "MenuTemplate")
let profileTexture = SKTexture(imageNamed: "MenuTemplateCharacter")
let shopTexture = SKTexture(imageNamed: "MenuTemplateShop")
let videosTexture = SKTexture(imageNamed: "MenuTemplateVideos")
let mapTexture = SKTexture(imageNamed: "MenuTemplateMap")
let goalCircleTexture = SKTexture(imageNamed: "goalCircle")
var lockTexture = SKTexture(imageNamed: "lock")
var telehomeButton = SKTexture(imageNamed: "TeleportHome")
var bankFloorTexture = SKTexture(imageNamed: "BankFloorHexagon")
var perimiterTexture = SKTexture(imageNamed: "BankFloorForceFeild")
var stairs = SKTexture(imageNamed: "StaircaseDown")
var stairsButtonTexture = SKTexture(imageNamed: "StaircaseDownPolarized")
var ramayTexture = SKTexture(imageNamed: "ramay2")
var ramayCounterTexture = SKTexture(imageNamed: "ramayCounter")
var videoTemplate = SKTexture(imageNamed: "videoTemplate")
var coinTexture = SKTexture(imageNamed: "BudCoin")
var whiteOutExit = SKTexture(imageNamed: "escapeWithWB")
var playTexture = SKTexture(imageNamed: "play")
var shaderVeilTexture = SKTexture(imageNamed: "shaderVeil")
var dealAcceptedTexture = SKTexture(imageNamed: "dealAccepted")
var dealRejectedTexture = SKTexture(imageNamed: "dealRejected")
var barterScreen = SKTexture(imageNamed: "BarterScreen")
var traderHeadsup = SKTexture(imageNamed: "GuidoFawkes")
var traderTexture = SKTexture(imageNamed: "trader")
var pauseTexture = SKTexture(imageNamed: "pause")
var traderT1 = SKTexture(imageNamed: "HelloTrader")
var traderT2 = SKTexture(imageNamed: "InvestigatingTrader")
var traderT3 = SKTexture(imageNamed: "ComputingTrader")
var traderT4 = SKTexture(imageNamed: "ExchangeTrader")
var traderT5 = SKTexture(imageNamed: "IdeaTrader")
var traderPadTexture = SKTexture(imageNamed: "traderSpot")
var notificationTexture = SKTexture(imageNamed: "notification")
var tellerIntroTexture = SKTexture(imageNamed: "TellerQ")
var dbTile = SKTexture(imageNamed: "databaseTile")
var qTile = SKTexture(imageNamed: "quizTile")
var qnTile = SKTexture(imageNamed: "questionsTile")
var tmTile = SKTexture(imageNamed: "traderManagerTile")
var answerqTexture = SKTexture(imageNamed: "answerQuadrant")
var questionqTexture = SKTexture(imageNamed: "questionQuadrant")
var wrenchNilTexture = SKTexture(imageNamed: "wrenchNil")
var oneWrenchTexture = SKTexture(imageNamed: "oneWrench")
var fiveWrenchesTexture = SKTexture(imageNamed: "fiveWrenches")
var allWrenchesTexture = SKTexture(imageNamed: "allWrenches")
var resetBoxTexture = SKTexture(imageNamed: "resetBox")
var resetLeverTexture = SKTexture(imageNamed: "resetLever")
var resetWarningSignTexture = SKTexture(imageNamed: "warningSign")
var buyTexture = SKTexture(imageNamed: "buyButton")
var sellTexture = SKTexture(imageNamed: "sellButton")
var quizClockTexture = SKTexture(imageNamed: "quizClock")
var quizNeedleTexture = SKTexture(imageNamed: "quizNeedle")
var pebbleTexture = SKTexture(imageNamed: "pebble")
var narratorPointerTexture = SKTexture(imageNamed: "narratorPointer")

var northEastonLogo = SKTexture(imageNamed: "sponsorLogo")
var bankTexture = SKTexture(imageNamed: "Bank")
var storeTexture = SKTexture(imageNamed: "shopSpot")
var videoTexture = SKTexture(imageNamed: "videosSpot")
var junkTexture = SKTexture(imageNamed: "credits")
var profilTexture = SKTexture(imageNamed: "profileSpot")
var exitTexture = SKTexture(imageNamed: "exitPoint")
var correctTexture = SKTexture(imageNamed: "correctAnswer")
var wrongTexture = SKTexture(imageNamed: "wrongAnswer")
var northEastonTexture = SKTexture(imageNamed: "northEaston")

var gravel = SKTexture(imageNamed: "GravelTexture")
var sand = SKTexture(imageNamed: "SandTexture")
var grass = SKTexture(imageNamed: "31") //textures to be easily switched out

var tableElements: [SKSpriteNode] = [] // array for navigation items
var tableIsUp: Bool = true // tells whether to drop the table or lift it up
var killSwitch: String = "off" // the switch that prevents gesture spamming
var currentScene: String = "map" // the current scene that is being presented
var origin = CGPoint(x: 0, y: 0) // shortcut for center of the scene
var playerSpeed: Int = 1000 // global speed of player
var playerSpeedMemory: UserDefaults! // speed stored to memory
var budCoin: Int = 0 // in - game currency
var tradersLinked: [Trader] = [] // the list of traders that deals have been made with
var traderDetailsDatabase: [any Sequence] = [] // the array of arrays that have the important credentials of each trader
var transactionRecords: [String] = [] // the array that holds the strings of transaction details that the player made
var budColors: [Bool] = [] // the to be filled list of possible bud colors
var bitColors: [Bool] = [] // the to be filled list of possible bit colors
let adjectiveList = ["Frugal", "Rich", "Poor", "Furtive", "Risky", "Savy", "Coin", "Cash", "Bill", "Check", "Reciept", "Debt", "Bond", "Loan", "Miser", "Thinker", "Collecter", "Tax", "Agent", "Investor", "Barter", "Trader", "Broker", "Change", "Cash", "Articulated", "Budget", "Bank", "Capital", "Credit", "Dividend", "Gold", "Silver", "Bronze", "Profiting", "Stock", "Interest", "Supplier", "Money", "Medium", "Trust", "Fund", "Relief", "Sell", "Buy", "Sale", "Price", "Real", "Risky", "Save", "Prepare", "Hoard", "Blame", "Deposit", "Red", "Orange", "Yellow", "Green", "Blue", "Violet", "Grey", "Robot", "Polite", "Kind", "Cool", "Broke", "Happy", "Dire", "Junk", "Inflate", "Crash", "Bull", "Bear", "Market", "Trade", "Trick", "Helping", "Safe", "Shady", "Great", "Vault", "Fast", "Paced", "Lovely", "Right", "Vexing", "Nervous", "Clever", "Friendly", "Reliable", "Dire", "Cheery", "Really", "Quite", "Mostly", "Maybe", "Surely", "Definitely", "Not"] // 99 adjectives for the name of traders

/*["Frugal", "Rich", "Poor", "Furtive", "Cool", "Small", "Big", "Cute", "Heinous", "Lovely", "Short", "Tall", "Fat", "Thin", "Rude", "Polite", "Easy", "Stern", "Best", "Friend", "Foe", "Old", "Young", "Keen", "Smart", "Dumb", "Crude", "Neat", "Fun", "Boring", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Violet", "White", "Black", "Equal", "Above", "Better", "Worse", "Best", "Worst", "Dense", "Light", "Bright", "Risky", "Mad", "Sad", "Happy", "Sick", "Lost", "Jerk", "Sir", "Lady", "Ms.", "Mrs.", "Mr.", "(I)", "(II)", "(III)", "(IV)", "(V)", "(-I)", "Smelly", "Fine", "Cruel", "Sneaky", "Creepy", "Hot", "Cold", "Spiky", "Soft", "Dimpled", "Rusty", "Shiny", "Mediocre", "Great", "Awful", "Terrible", "Polished", "Sticky", "Sloppy", "Skewed", "Fast", "Slow", "Agile", "Relentless", "Dire", "Cheery", "Alive", "Grateful", "Giddy", "Puny", "Huge", "Weird", "Not"] // 99 adjectives for the name of traders*/

// The ones above are too "offensive". Wow.

let nameList = ["Nicole", "Gabby", "Sebastian", "Lily", "Cassie", "Charlie", "Brian", "Brady", "Nicky", "Holly", "Jenn", "Jess", "Maggie", "Peter", "Kim", "Becky", "Tony", "Peter", "Sally", "Mike", "Logan", "John", "Courtney", "Gavin", "Angelina", "Nielsen", "Leila", "Musketeer", "Elena", "Teymur", "Vasilisa", "Frederica", "Yaroslava"] // 33 names for traders

let deals: [String] = ["Would you like to invest your money in a high-yield savings account that is insured by the U.S. government?", "Hey, do you want to buy this Treasury Bond from the U.S. Department of Treasury?", "Hello, would you like to open a certificate of deposit that is insured by the U.S. government?", "Would you like to buy this EE Bond, which is classified as a U.S. Savings Bond?", "Would you like to buy this HH Bond, which is classified as a U.S. Savings Bond?", "Would you care to invest into this life insurance plan?", "Hi, do you accept this highly rated bond issued by your state government?", "Hey, do you accept this highly rated bond issued by a trustworthy corporation?", "Would you like to deposit money in a money market account offered at my bank?", "Would you like to deposit money in a money market account offered at my credit union?", "Would you like to invest in a secure mutual fund with both stocks and bonds?", "Hey, do you want to purchase a highly rated stock that will be converted to a different type of stock over time?", "Do you want to buy this highly rated preferred stock that won’t bug you, but you can't control either?", "Do you want to buy this highly rated common stock?", "Hello, do you want to invest in these businesses that have the potential to grow at a faster rate than others in their industries?", "Do you want to invest in this business as a limited partner, meaning that you won’t have a role in managing it?", "Would you like to invest in my studio apartment in Cashtropolis?", "Would you like to purchase my mansion in Cashtropolis before selling it in a few years?", "Do you join my charity lottery? You have a chance to become rich!", "Do you want to buy this growing stock? I’ll let you buy it as long as you buy it right now!", "Would you like to buy this speculative common stock? Buy it while it's still low!", "Would you like to buy this cheap stock from a company operating in a developing economy?", "Would you like to invest in this oil company that will find oil very soon?", "Hey, do you want to buy this trinket that will make you rich? Trust me, I'll make sure you get it!", "Do you want to make a legal agreement to sell this stock when I signal you it's time?"] // the possible deals for traders, INDEX MATTERS! 0 - 4 is safe, 5 - 9 is kind of safe, 10 - 14 is risky, 15 - 19 is dangerous, 20 - 24 is a scam.

//##############################################################################################
var MemoryVault = UserDefaults()/// The storage for all permanent values
//"character" is the vault for the character bod.
//"bit" is the vault for the bit texture(if there is a bit as well).
//"highlightedSlot" is the vault for the highlighted character in the profile.
//"coin" is the vault for the amount of currency the player has.
//"tradersLinked" is the vault for all of the traders you made a bondage with.
//"walkCycles" is the vault for the times the player paced a loop from the map to the bank.
//"shopList" is the vault for the purchased items that are allowed to be used in profile.
//"wrenchCount" is the vault for how many wrenches BUD has to be thrown on the map or inside the bank.
//"transactionRecords" is the vault for all of the transaction arrays that occoured by the player.
//"budColors" is the vault in array form containing the boolean state of each bud color for purchase.
//"bitColors" is the vault in array form containing the boolean state of each bit for purchase.
//"needsTutorial" is the vault in boolean form whether or not the user needs an introductory tutorial.
//##############################################################################################

// The variable that holds where the blackout scene goes to
var sceneSetTo: String = "" // The variable that helps decide where to dash the second time while leaving the blackout transition
var sceneDirectionWith: SKTransitionDirection = .down // the global direction for moving through the HeadQuarters
var globalPushSpeed: TimeInterval = 0.5 // the global speed it takes to do the dash transition
var VideoUrl: String = "" // the url for the video that is to be played in the videos section
var MemoryVaultLocalTrip: Bool = false // helps only "update" the variables once in accordance to memory, to save me the argious pain af writing something a lot more complicated. I need sleep.
var walkCycles: Int = 0 // the amount of times the player has walked between the bank and the map
var didEncounterSponsor: Bool = false // the boolean trigger whether or not to show the advertisment for the sponsor.
var isInShootingMode: Bool = false // whether or not the phone was shook to throw wrenches
var shootingModeKillSwitch: Bool = false // the switch to prevent glitches while in throwing mode
var roundUpFinished: Bool = false // whether or not my cool wrench animation finished
var wrenchCount = 0 // the amount of wrenches the player has(to be updated by a userdefault)
var needsTutorial = true // whether or not the user needs a tutorial
var bitTexture = SKTexture() // the texture of the bit in use, on the global scope
var bitIdleLockOn: Bool = false // whether or not bit is allowed to just move around it's owner

//##############################################################################################
//Deprecated(By Me) Variables:

//let twoCentsTexture = SKTexture(imageNamed: "defaultBud")

//##############################################################################################

//  FFFFF
//  F
//  FFFF
//  F
//  F unctions

///function to add the main character
func addBUD(sceneTo: SKScene, texture: SKTexture, position: CGPoint, scale: CGFloat) -> SKSpriteNode{
    let bud = SKSpriteNode(texture: texture)
    bud.position = position
    bud.setScale(scale)
    bud.zPosition = 10
    sceneTo.addChild(bud)
    
    return bud
    
}

///function to add pinch recognizer in a single line to intergrated UIKit views
func addPinchCapability(sceneTo: SKScene, selector: Selector?){
    pinchRecognizer = UIPinchGestureRecognizer(target: sceneTo, action: selector)
    sceneTo.view?.addGestureRecognizer(pinchRecognizer)
}

///function to add swipe recognizer in a single line to intergrated UIKit views
func addSwipeCapability(sceneTo: SKScene, selector: Selector?, direction: UISwipeGestureRecognizer.Direction){
    switch direction{
        case .down:
            swipeDownGesture = UISwipeGestureRecognizer(target: sceneTo, action: selector)
            swipeDownGesture.direction = .down
            sceneTo.view?.addGestureRecognizer(swipeDownGesture)
        case .up:
            swipeUpGesture = UISwipeGestureRecognizer(target: sceneTo, action: selector)
            swipeUpGesture.direction = .up
            sceneTo.view?.addGestureRecognizer(swipeUpGesture)
        case .left:
            swipeLeftGesture = UISwipeGestureRecognizer(target: sceneTo, action: selector)
            swipeLeftGesture.direction = .left
            sceneTo.view?.addGestureRecognizer(swipeLeftGesture)
        case .right:
            swipeRightGesture = UISwipeGestureRecognizer(target: sceneTo, action: selector)
            swipeRightGesture.direction = .right
            sceneTo.view?.addGestureRecognizer(swipeRightGesture)
        default:
            break
    }
}

///function to remove swipe capabilities to not fuzz with touchesHeld actions
func removeSwipeCapability(sceneTo: SKScene, direction: UISwipeGestureRecognizer.Direction){
    switch direction{
        case .down:
            sceneTo.view?.removeGestureRecognizer(swipeDownGesture)
        case .up:
            sceneTo.view?.removeGestureRecognizer(swipeUpGesture)
        case .left:
            sceneTo.view?.removeGestureRecognizer(swipeLeftGesture)
        case .right:
            sceneTo.view?.removeGestureRecognizer(swipeRightGesture)
        default:
            break
    }
}

///function to run every time a pinch is started(DEPRECATED BY ME)
func ShowTable(profile: SKSpriteNode, map: SKSpriteNode, shop: SKSpriteNode, videos: SKSpriteNode, table: SKSpriteNode){
    if killSwitch == "off"{
        tableElements.removeAll()
        tableElements.append(contentsOf: [profile, map, shop, videos, table])
        for index in tableElements.indices{
            if tableIsUp == true && killSwitch == "off"{
                tableElements[index].run(SKAction.fadeOut(withDuration: 1))
                print("down")
            }
            if tableIsUp == false && killSwitch == "off"{
                tableElements[index].run(SKAction.fadeIn(withDuration: 1))
                print("up")
            }
        }
        tableIsUp.toggle()
        killSwitch = "on"
    }
}

///function to add a simple mutable text
func addLabel(sceneTo: SKScene, scale: CGFloat, position: CGPoint, color: UIColor, text: String, zPosition: CGFloat) -> SKLabelNode{
    let element = SKLabelNode(fontNamed: "MarkerFelt-Wide")
    element.position = position
    element.fontSize = scale
    element.zPosition = zPosition
    element.fontColor = color
    element.text = text
    sceneTo.addChild(element)
    
    return element
}

///function to set up an archaic sprite model to be later adjusted
func SpriteSetup(texture: SKTexture, position: CGPoint, scale: CGFloat) -> SKSpriteNode{
    let element = SKSpriteNode(texture: texture)
    element.position = position
    element.setScale(scale)
    element.zPosition = 100
    
    return element
}

///function to set up a physics - based sprite and import into a variable & a scene
func addPhysicsBasedSprite(sceneTo: SKScene, texture: SKTexture, position: CGPoint, scale: CGFloat, zPosition: CGFloat, physicsName: String, collider: UInt32, contact: UInt32, category: UInt32) -> SKSpriteNode{
    
    let element = SKSpriteNode(texture: texture)
    element.position = position
    element.setScale(scale)
    element.zPosition = zPosition
    element.name = physicsName
    element.physicsBody = SKPhysicsBody(texture: element.texture!, size: element.size)
    element.physicsBody?.categoryBitMask = category
    element.physicsBody?.collisionBitMask = collider
    element.physicsBody?.contactTestBitMask = contact
    sceneTo.addChild(element)
    
    return element
}

///function that sets up the core sprites and logic for the navigation bar !!!SENSITIVE IN/OUT FUNCTION!!!
func setUpNavigationTable(table: inout SKSpriteNode, map: inout SKSpriteNode, shop: inout SKSpriteNode, videos: inout SKSpriteNode, profile: inout SKSpriteNode, sceneTo: SKScene){
    
    table = SpriteSetup(texture: menuTexture, position: CGPoint(x: 0, y: -600), scale: 0.75)
    table.zPosition = 99
    profile = SpriteSetup(texture: profileTexture, position: CGPoint(x: -225, y: -600), scale: 0.4)
    map = SpriteSetup(texture: mapTexture, position: CGPoint(x: -75, y: -580), scale: 0.4)
    shop = SpriteSetup(texture: shopTexture, position: CGPoint(x: 75, y: -580), scale: 0.4)
    videos = SpriteSetup(texture: videosTexture, position: CGPoint(x: 225, y: -600), scale: 0.4)

    sceneTo.addChild(table)
    sceneTo.addChild(profile)
    sceneTo.addChild(map)
    sceneTo.addChild(shop)
    sceneTo.addChild(videos)

}

///function that monitors current scene tab and helps navigate by accessing touches that can be inputed
func detectMenuSelections(pointPressed: CGPoint, sceneFrom: SKScene, profile: SKSpriteNode, map: SKSpriteNode, shop: SKSpriteNode, videos: SKSpriteNode){
    if profile.alpha > 0{
        if profile.contains(pointPressed){
            if currentScene != "profile"{
                currentScene = "profile"
                let scene = ProfileScene(size: sceneFrom.size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.crossFade(withDuration: 1.0)
                sceneFrom.view?.presentScene(scene, transition: transition)
            }
        }
        if map.contains(pointPressed){
            if currentScene != "map"{
                currentScene = "map"
                let scene = MapScene(size: sceneFrom.size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.crossFade(withDuration: 1.0)
                sceneFrom.view?.presentScene(scene, transition: transition)
            }
        }
        if shop.contains(pointPressed){
            if currentScene != "shop"{
                currentScene = "shop"
                let scene = ShopScene(size: sceneFrom.size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.crossFade(withDuration: 1.0)
                sceneFrom.view?.presentScene(scene, transition: transition)
            }
        }
        if videos.contains(pointPressed){
            if currentScene != "videos"{
                currentScene = "videos"
                let scene = VideosScene(size: sceneFrom.size)
                scene.scaleMode = .aspectFill
                let transition = SKTransition.crossFade(withDuration: 1.0)
                sceneFrom.view?.presentScene(scene, transition: transition)
            }
        }
    }
}

///function that is input in a constant loop to monitor screen for pinching actions, and killing the switch to fade in or out the navigation bar
func monitorKillSwitch(){
    if pinchRecognizer.scale > 1.0{
        killSwitch = "on"
    }
    if pinchRecognizer.scale < 1.0{
        killSwitch = "on"
    }
    if pinchRecognizer.scale == 1.0{
        killSwitch = "off"
    }
}

/// calculate distance between 2 points to find constant speed or just length
func findDistanceBetweenPoints(currentPoint: CGPoint, targetPoint: CGPoint) -> CGFloat{
    let cx = currentPoint.x
    let cy = currentPoint.y
    let tx = targetPoint.x
    let ty = targetPoint.y
    
    let formula = sqrt(pow(cx - tx, 2) + pow(cy - ty, 2))
    
    return formula
}

/// generates a number within the given range **INCLUSIVE NUMBERS!!!**
func generateRandomInteger(highestPossibility: Int, lowestPossibility: Int) -> Int{
    let randomNumber = Int.random(in: lowestPossibility ... highestPossibility)
    
    return randomNumber
}

/// presents a ViewController from a SKScene in a single line
func presentViewController(nameTo: String, sceneFrom: SKScene){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: nameTo)
    vc.view.frame = (sceneFrom.view?.frame)!
    vc.view.layoutIfNeeded()
    UIView.transition(with: sceneFrom.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{ sceneFrom.view?.window?.rootViewController = vc }, completion: { completed in })
}

/// change back view controllers(root display)
func switchViewController(from: UIView, to: String){
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: to)
    vc.view.frame = (from.frame)
    vc.view.layoutIfNeeded()
    UIView.transition(with: from, duration: 0.3, options: .transitionFlipFromRight, animations:{ from.window?.rootViewController = vc }, completion: { completed in })
}

/// present a pre - made(Apple designed it) player that can use mp4 files to display a video with very good settings, and an easy exit. *scaling for all phones included!
func presentVideo(sceneFrom: SKScene, videoPath: String){
    guard let localPath = Bundle.main.path(forResource: videoPath, ofType: "mp4")else{
        print("no url")
        return
    }
    let player = AVPlayer.init(url: URL(fileURLWithPath: localPath))
    let popUpController = AVPlayerViewController()
    popUpController.player = player
    sceneFrom.view?.window!.rootViewController!.present(popUpController, animated: true){
        player.play()
    }
}

/// presents a SKScene from a ViewController in a single line
func presentSKScene(viewFrom: UIViewController, sceneTo: String){
    if let view = viewFrom.view as! SKView? {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: sceneTo) {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view.presentScene(scene)
        }
    }
}

/// plays a video of the .mp4, or .mv4, or IMG
func playVideo(from file:String, viewFrom: UIViewController, size: CGRect, position: CGPoint) {
    let file = file.components(separatedBy: ".")
    guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
        debugPrint( "\(file.joined(separator: ".")) not found")
        return
    }
    let player = AVPlayer(url: URL(fileURLWithPath: path))
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = size
    playerLayer.position = position
    viewFrom.view.layer.addSublayer(playerLayer)
    player.play()
}

/// gets the absolute value and edits the inputed value, before outputting it within the given variable
func getAbsoluteValue(CGFloatValue: inout CGFloat){
    if CGFloatValue < 0{
        CGFloatValue *= -1
    }
}

/// gets the absolute value and edits the inputed value, before outputting it with a NEW variable
func getAbsoluteValueNew(CGFloatValue: CGFloat) -> CGFloat{
    var result = CGFloatValue
    if result < 0{
        result *= -1
    }
    return result
}

/// extracts the PNG texture from data that was converted from an image, as a true full SKTexture for the BUD texture
func extractPNG(forVariable: inout SKTexture){
    if let localTxtr = MemoryVault.value(forKey: "character"){
        for budTexture in budTexturePallet{
            let budData = budTexture.cgImage()
            let bData = UIImage(cgImage: budData)
            let dataData = bData.pngData()
            if dataData == localTxtr as? Data{
                forVariable = budTexture
            }
        }
    }else{
        forVariable = defaultBud
    }
}


/// extracts the PNG texture from data that was converted from an image, as a true full SKTexture for the BIT texture
func extractBitPNG(forVariable: inout SKTexture){
    if let localTxtr = MemoryVault.value(forKey: "bit"){
        for bitTexture in bitTexturePallet{
            let bitTextureOption = bitTexture.cgImage()
            let bitImage = UIImage(cgImage: bitTextureOption)
            let bitData = bitImage.pngData()
            if bitData == localTxtr as? Data{
                forVariable = bitTexture
            }
        }
    }else{
        forVariable = noBit
    }
}

/// doesn't only set up sprite, but also adds to scene and returns the variable to be a usable sprite
func addSprite(sceneTo: SKScene, zPosition: CGFloat, position: CGPoint, texture: SKTexture, scale: CGFloat) -> SKSpriteNode{
    let sprite = SKSpriteNode(texture: texture)
    sprite.setScale(scale)
    sprite.position = position
    sprite.zPosition = zPosition
    sceneTo.addChild(sprite)
    
    return sprite
}

/// sets up the specific target cursor for navigating around with BUD
func addGoalCircle(sceneTo: SKScene) -> SKSpriteNode{
    let goal = SKSpriteNode(texture: goalCircleTexture)
    goal.position = origin
    goal.alpha = 0
    goal.zPosition = 1000
    goal.setScale(0.4)
    sceneTo.addChild(goal)
    
    return goal
}

/// convert degrees to radians(turns variable into radians)
func degreesToRadians(degrees: inout CGFloat){
    let radians = (degrees / 180) * CGFloat(Float.pi)
    degrees = radians
}

/// adds a particle emmitter to a scene
func addEmitter(sceneTo: SKScene, timeElapsed: TimeInterval, fileName: String, scale: CGFloat, position: CGPoint, rotation: CGFloat, zPosition: CGFloat) -> SKEmitterNode{
    let emitter = SKEmitterNode(fileNamed: fileName)!
    emitter.setScale(scale)
    emitter.advanceSimulationTime(timeElapsed)
    emitter.position = position
    emitter.zPosition = zPosition
    emitter.zRotation = rotation
    sceneTo.addChild(emitter)
    
    return emitter
}

/// add a stairs sprite to a scene for easy navigation between places
func addStairs(sceneTo: SKScene, position: CGPoint, zPosition: CGFloat, zRotation: CGFloat, name: String, texture: SKTexture, scale: CGFloat) -> SKSpriteNode{
    let element = addPhysicsBasedSprite(sceneTo: sceneTo, texture: texture, position: position, scale: scale, zPosition: zPosition, physicsName: name, collider: ColliderFaction.player, contact: ColliderFaction.player, category: ColliderFaction.walls)
    element.zRotation = zRotation
    element.physicsBody?.isDynamic = false
    
    return element
}

/// function that switches scenes with the "dash" action. (My Favorite yet!)
func dashTransition(sceneTo: SKScene, sceneFrom: SKScene, direction: SKTransitionDirection, sceneDashName: String, k_switch: inout Bool){
    if !k_switch{
        k_switch = true
        sceneSetTo = sceneDashName
        sceneTo.scaleMode = .aspectFill
        sceneFrom.view?.presentScene(sceneTo, transition: SKTransition.moveIn(with: direction, duration: 0.6))
    }
}

/// function that auto - adds the escape stairs button to the scenes in the bank
func addEscapeButton(sceneTo: SKScene) -> SKSpriteNode{
    let element = addSprite(sceneTo: sceneTo, zPosition: 1000, position: CGPoint(x: -250, y: 550), texture: stairsButtonTexture, scale: 0.05)
    return element
}

/// function for easy scene - to - scene transitions(not for bank - related scenes)
func moveToScene(sceneTo: SKScene, sceneFrom: SKScene){
    sceneTo.scaleMode = .aspectFill
    sceneFrom.view?.presentScene(sceneTo, transition: SKTransition.push(with: .down, duration: 0.1))
} 

/// function that picks a random letter and returns it
func drawRandomLetter() -> String{
    let randomLetterIndex = generateRandomInteger(highestPossibility: 25, lowestPossibility: 0)
    var letter = ""
    switch randomLetterIndex{
    case 0:
        letter = "a"
    case 1:
        letter = "b"
    case 2:
        letter = "c"
    case 3:
        letter = "d"
    case 4:
        letter = "e"
    case 5:
        letter = "f"
    case 6:
        letter = "g"
    case 7:
        letter = "h"
    case 8:
        letter = "i"
    case 9:
        letter = "j"
    case 10:
        letter = "k"
    case 11:
        letter = "l"
    case 12:
        letter = "m"
    case 13:
        letter = "n"
    case 14:
        letter = "o"
    case 15:
        letter = "p"
    case 16:
        letter = "q"
    case 17:
        letter = "r"
    case 18:
        letter = "s"
    case 19:
        letter = "t"
    case 20:
        letter = "u"
    case 21:
        letter = "v"
    case 22:
        letter = "w"
    case 23:
        letter = "x"
    case 24:
        letter = "y"
    case 25:
        letter = "z"
    default:
        break
    }
    return letter
}

/// DEPRECATED(BY ME)
func addRandomizedTeller(sceneTo: SKScene, maxX: Int, maxY: Int, aliasLength: Int) -> SKSpriteNode{
    let randomX = generateRandomInteger(highestPossibility: maxX, lowestPossibility: -maxX)
    let randomY = generateRandomInteger(highestPossibility: maxY, lowestPossibility: -maxY)
    let randomTexture = generateRandomInteger(highestPossibility: 5, lowestPossibility: 0)
    var aliasName = ""
    
    for _ in 1 ... aliasLength{
        aliasName += drawRandomLetter()
    }
    
    
    let trader = SKSpriteNode(texture: traderTexture)
    trader.position = CGPoint(x: randomX, y: randomY)
    trader.setScale(0.15)
    trader.zPosition = 1
    trader.aliasGlobal = aliasName
    trader.name = "trader"
    sceneTo.addChild(trader)
    
    switch randomTexture{
    case 0:
        trader.texture = traderTexture
    case 1:
        trader.texture = traderTexture
    case 2:
        trader.texture = traderTexture
    case 3:
        trader.texture = traderTexture
    case 4:
        trader.texture = traderTexture
    case 5:
        trader.texture = traderTexture
    default:
        break
    }
    
    trader.physicsBody = SKPhysicsBody(rectangleOf: trader.size)
    trader.physicsBody?.categoryBitMask = ColliderFaction.trader
    trader.physicsBody?.contactTestBitMask = ColliderFaction.player
    trader.physicsBody?.collisionBitMask = ColliderFaction.player
    trader.physicsBody?.isDynamic = false
    trader.physicsBody?.affectedByGravity = false
    
    return trader
}

/// function to pop up the trader screen
func popUpForTrader(traderInQuestion: Trader, bud: inout SKSpriteNode, popUpScreen: inout SKSpriteNode, nameDescription: inout SKLabelNode, dealDescription: inout SKLabelNode, acceptDeal: inout SKSpriteNode, declineDeal: inout SKSpriteNode, sceneTo: SKScene, isAllowedToMove: inout Bool, shaderVeil: inout SKSpriteNode){
    bud.removeAllActions()
    isAllowedToMove = false
    popUpScreen = addSprite(sceneTo: sceneTo, zPosition: 1001, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), texture: barterScreen, scale: 1.25)
    nameDescription = addLabel(sceneTo: sceneTo, scale: 30, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), color: .black, text: traderInQuestion.alias, zPosition: 1002)
    dealDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
    dealDescription.preferredMaxLayoutWidth = 400.0
    dealDescription.numberOfLines = 10
    dealDescription = addLabel(sceneTo: sceneTo, scale: 20, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), color: .black, text: traderInQuestion.deal, zPosition: 1002)
    dealDescription.lineBreakMode = NSLineBreakMode.byWordWrapping
    dealDescription.preferredMaxLayoutWidth = 400.0
    dealDescription.numberOfLines = 10
    acceptDeal = addSprite(sceneTo: sceneTo, zPosition: 1002, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), texture: dealAcceptedTexture, scale: 0.2)
     if traderDetailsDatabase.count >= 20{
          acceptDeal.alpha = 0.25
     }
    declineDeal = addSprite(sceneTo: sceneTo, zPosition: 1002, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), texture: dealRejectedTexture, scale: 0.25)
    
    popUpScreen.run(SKAction.move(to: bud.position, duration: 0.25))
    nameDescription.run(SKAction.move(to: CGPoint(x: bud.position.x, y: bud.position.y + 250), duration: 0.25))
    dealDescription.run(SKAction.move(to: CGPoint(x: bud.position.x, y: bud.position.y), duration: 0.25))
    acceptDeal.run(SKAction.move(to: CGPoint(x: bud.position.x - 120, y: bud.position.y - 300), duration: 0.25))
    declineDeal.run(SKAction.move(to: CGPoint(x: bud.position.x + 120, y: bud.position.y - 300), duration: 0.25))
    shaderVeil.run(SKAction.fadeAlpha(to: 0.75, duration: 0.25))
    
}

/// function to pop up the sponsor screen
func popUpForSponsor(sponsorInQuestion: Sponsor, bud: inout SKSpriteNode, popUpScreen: inout SKSpriteNode, nameDescription: inout SKLabelNode, dealDescription: inout SKLabelNode, acceptDeal: inout SKSpriteNode, declineDeal: inout SKSpriteNode, sceneTo: SKScene, isAllowedToMove: inout Bool, shaderVeil: inout SKSpriteNode){
    bud.removeAllActions()
    isAllowedToMove = false
    popUpScreen = addSprite(sceneTo: sceneTo, zPosition: 1001, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), texture: barterScreen, scale: 1.25)
    nameDescription = addLabel(sceneTo: sceneTo, scale: 50, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), color: .black, text: sponsorInQuestion.companyName, zPosition: 1002)
    dealDescription = addLabel(sceneTo: sceneTo, scale: 20, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), color: .black, text: sponsorInQuestion.hook, zPosition: 1002)
    acceptDeal = addSprite(sceneTo: sceneTo, zPosition: 1002, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), texture: dealAcceptedTexture, scale: 0.2)
    declineDeal = addSprite(sceneTo: sceneTo, zPosition: 1002, position: CGPoint(x: bud.position.x, y: bud.position.y - 1000), texture: dealRejectedTexture, scale: 0.25)
    
    popUpScreen.run(SKAction.move(to: bud.position, duration: 0.25))
    nameDescription.run(SKAction.move(to: CGPoint(x: bud.position.x, y: bud.position.y + 250), duration: 0.25))
    dealDescription.run(SKAction.move(to: CGPoint(x: bud.position.x, y: bud.position.y), duration: 0.25))
    acceptDeal.run(SKAction.move(to: CGPoint(x: bud.position.x - 120, y: bud.position.y - 300), duration: 0.25))
    declineDeal.run(SKAction.move(to: CGPoint(x: bud.position.x + 120, y: bud.position.y - 300), duration: 0.25))
    shaderVeil.run(SKAction.fadeAlpha(to: 0.75, duration: 0.25))
}

/// function to toss away the trader screen
func animateAwayPopUp(isAllowedToMove: inout Bool, popUpScreen: inout SKSpriteNode, nameDescription: inout SKLabelNode, dealDescription: inout SKLabelNode, acceptDeal: inout SKSpriteNode, declineDeal: inout SKSpriteNode, shaderVeil: inout SKSpriteNode, bud: SKSpriteNode){
    popUpScreen.run(SKAction.sequence([SKAction.moveBy(x: 0, y: -10000, duration: 0.25), SKAction.removeFromParent()]))
    nameDescription.run(SKAction.sequence([SKAction.moveBy(x: 0, y: -10000, duration: 0.25), SKAction.removeFromParent()]))
    dealDescription.run(SKAction.sequence([SKAction.moveBy(x: 0, y: -10000, duration: 0.25), SKAction.removeFromParent()]))
    acceptDeal.run(SKAction.sequence([SKAction.move(to: CGPoint(x: bud.position.x - 1000, y: bud.position.y - 300), duration: 0.25), SKAction.removeFromParent()]))
    declineDeal.run(SKAction.sequence([SKAction.move(to: CGPoint(x: bud.position.x + 1000, y: bud.position.y - 300), duration: 0.25), SKAction.removeFromParent()]))
    shaderVeil.run(SKAction.fadeAlpha(to: 0, duration: 0.25))
    isAllowedToMove = true
}

/// function to slap on a red, glaring, urgent notification anywhere
func addNotification(sceneTo: SKScene, position: CGPoint){
    let _ = addSprite(sceneTo: sceneTo, zPosition: 5, position: position, texture: notificationTexture, scale: 0.5)
}

/// function for spawning individual wrench, it's invisible orbit parent, and orbit it until it is killed
func spawnWrench(bud: SKSpriteNode, sceneTo: SKScene){
    let hiddenBud = addPhysicsBasedSprite(sceneTo: sceneTo, texture: wrenchTexture, position: CGPoint(x: bud.position.x, y: bud.position.y - 100), scale: 0.001, zPosition: 0, physicsName: "hiddenBud", collider: ColliderFaction.walls, contact: ColliderFaction.walls, category: ColliderFaction.player)
    hiddenBud.physicsBody?.mass = 0
    let wrench = addPhysicsBasedSprite(sceneTo: sceneTo, texture: wrenchTexture, position: CGPoint(x: bud.position.x, y: bud.position.y + 100), scale: 0.1, zPosition: 1001, physicsName: "wrench", collider: ColliderFaction.trader | ColliderFaction.sponsor, contact: ColliderFaction.trader | ColliderFaction.sponsor, category: ColliderFaction.wrench)
    wrench.physicsBody?.mass = 0
    //        let rangeToBud = SKRange(constantValue: 100)
    //        let constraintToBud = SKConstraint.distance(rangeToBud, to: bud)
    let rotationOffset = SKRange(constantValue: .pi / 2.0)
    let rotationLock = SKConstraint.orient(to: bud, offset: rotationOffset)
    wrench.constraints = [rotationLock]
    
    let pinJoint = SKPhysicsJointPin.joint(withBodyA: wrench.physicsBody!, bodyB: hiddenBud.physicsBody!, anchor: wrench.position)
    sceneTo.physicsWorld.add(pinJoint)
    hiddenBud.run(SKAction.move(to: CGPoint(x: bud.position.x, y: bud.position.y - 100), duration: 0.000001))
    // USES FREAKING RADIANS!!! SCREW THEM!!! AND ITS 2 PI FOR 1 TURN!!!
    hiddenBud.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi * 2, duration: 4)))
    heavy.impactOccurred()
}

/// function called to do cool into animation and be ready to throw wrenches
func runShootingMode(sceneFor: SKScene, bud: SKSpriteNode){
    let durationTime: TimeInterval = 4.0 / Double(wrenchCount)
    let waitAlittle = SKAction.wait(forDuration: durationTime)
    let spawnW: SKAction = SKAction.run{spawnWrench(bud: bud, sceneTo: sceneFor)}
    let confirmRoundup: SKAction = SKAction.run{roundUpFinished = true}
    let spanwningSequence = SKAction.sequence([spawnW, waitAlittle])
    if wrenchCount > 0{
        sceneFor.run(SKAction.sequence([SKAction.repeat(spanwningSequence, count: wrenchCount), confirmRoundup]))
    }
    isInShootingMode = true
}

/// function called to stop the wrench throwing mode and get back to work
func endShootingMode(sceneIn: SKScene){
    for sprite in sceneIn.children{
        if sprite.name == "wrench" || sprite.name == "hiddenBud"{
            sprite.removeFromParent()
        }
    }
    roundUpFinished = false
    isInShootingMode = false
}

/// function to add a ransaction record to the transaction database
func appendTransactionRecord(nameOfPlayer: String, nameOfEntity: String, transactionAmount: Int, transactionItem: String){
    var record = String()
    if transactionAmount >= 0{
        record = "\(nameOfPlayer) gained: \(transactionAmount) \(transactionItem) from: \(nameOfEntity)"
    }else{
        let neoTransactionAmount = transactionAmount * -1
        record = "\(nameOfPlayer) lost: \(neoTransactionAmount) \(transactionItem) to: \(nameOfEntity)"
    }
    transactionRecords.insert(record, at: 0)
    if transactionRecords.count > 50{
        transactionRecords.removeLast()
    }
    MemoryVault.setValue(transactionRecords, forKey: "transactionRecords")
}

/// return a random string that is a single adjective with a space at the end if asked
func randomAdjective(spaceAfter: Bool) -> String{
    let randomNum = generateRandomInteger(highestPossibility: adjectiveList.count - 1, lowestPossibility: 0)
    var randomAdjective = adjectiveList[randomNum]
    if spaceAfter{
        randomAdjective += " "
    }
    
    return randomAdjective
}

/// return a random string that is a single name with a space at the end if asked
func randomName(spaceAfter: Bool) -> String{
    let randomNum = generateRandomInteger(highestPossibility: nameList.count - 1, lowestPossibility: 0)
    var randomName = nameList[randomNum]
    if spaceAfter{
        randomName += " "
    }
    
    return randomName
}

/// turn bud to the way he needs to be, always keeping his color in mind
func changeBudFacingOrientation(budPosition: CGPoint, newPosition: CGPoint, localTexture: SKTexture, budSprite: inout SKSpriteNode){
    let oldX = (budPosition.x) // set everything to a positive delta from the origin of the field.
    let newX = (newPosition.x) // set everything to a positive delta from the origin of the field.
    let oldY = (budPosition.y) // set everything to a positive delta from the origin of the field.
    let newY = (newPosition.y) // set everything to a positive delta from the origin of the field.
    
    let deltaX = abs(abs(newX) - abs(oldX))
    let deltaY = abs(abs(newY) - abs(oldY))
    
    var faceRight = Bool()
    var faceUp = Bool()
    
    let textureRoot = localTexture.description
    print(textureRoot)
    var halfCommaTrigger = false
    var letterArray: [String] = []
    for character in textureRoot{
        if character == "'" && halfCommaTrigger == false{
            halfCommaTrigger = true
        }else if character == "'" && halfCommaTrigger{
            halfCommaTrigger = false
        }else if halfCommaTrigger{
            let stringUnit = String(character)
            letterArray.append(stringUnit)
        }
    }
    let textureFileName = letterArray.joined()
    print(textureFileName)
    
    if newX < oldX{
        faceRight = false
    }else{
        faceRight = true
    }
    
    if newY < oldY{
        faceUp = false
    }else{
        faceUp = true
    }
    
    if faceRight{
        budSprite.texture = SKTexture(imageNamed: textureFileName + "Right")
    }else{
        budSprite.texture = SKTexture(imageNamed: textureFileName + "Left")
    }

    if deltaX > deltaY{
        if faceRight{
            budSprite.texture = SKTexture(imageNamed: textureFileName + "Right")
        }else{
            budSprite.texture = SKTexture(imageNamed: textureFileName + "Left")
        }
    }else if deltaY > deltaX{
        if faceUp{
            budSprite.texture = SKTexture(imageNamed: textureFileName + "Back")
        }else{
            budSprite.texture = SKTexture(imageNamed: textureFileName)
        }
    }else{
        if faceUp{
            budSprite.texture = SKTexture(imageNamed: textureFileName + "Back")
        }else{
            budSprite.texture = SKTexture(imageNamed: textureFileName)
        }
    }
}


//#################################################################################################################

//MY FAVORITE FUNCTION!!!

/// the function to have bit move towards the nearest trader in an orbital lock, while oriented feet first towards the player. I am using linear algebra with the circle function around BUD, the linear function running through the nearest trader, and then checking the possible solutions for the final position of BIT!!!
func keepBitMoving(bitCharacter: inout SKSpriteNode, parentPosition: CGPoint, isParentMoving: Bool, isPermittedToMove: Bool, sceneFrom: SKScene, isOnMap: Bool){
    
    
    if !isPermittedToMove || isInShootingMode{
        if !bitIdleLockOn{
            bitIdleLockOn = true
            let deactivateLock = SKAction.run{bitIdleLockOn = false}
            bitCharacter.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.1), SKAction.move(to: CGPoint(x: 1000, y: 1000), duration: 0.1), deactivateLock]))
        }
    }else{
        bitIdleLockOn = false
        //bitCharacter.position = CGPoint(x: parentPosition.x + 100, y: parentPosition.y + 100)
        bitCharacter.run(SKAction.fadeIn(withDuration: 0.25))
        var closestTraderPosition = CGPoint(x: 999999, y: 999999)
        var closestDistance = findDistanceBetweenPoints(currentPoint: parentPosition, targetPoint: closestTraderPosition)
        for baby in sceneFrom.children{
            if let trader = baby as? Trader{
                if trader.isActive || isOnMap{
                    let newDistance = findDistanceBetweenPoints(currentPoint: parentPosition, targetPoint: trader.position)
                    if newDistance < closestDistance{
                        closestDistance = newDistance
                        closestTraderPosition = trader.position
                    }
                }
            }
        }
        if closestTraderPosition != CGPoint(x: 999999, y: 999999){
            // YOU NEVER ACTUALLY PLUG IN X AND Y!!! LINEAR ALGEBRA IS JUST RELATIVE FUNCTIONS!!!
            // IT TOOK ME TWO HOURS TO FIGURE THAT OUT!!!
            
            let radius = 10000.0
            //let circleAroundBud = pow(parentPosition.x, 2) + pow(parentPosition.y, 2) - radius
            let deltaX = parentPosition.x - closestTraderPosition.x
            let deltaY = parentPosition.y - closestTraderPosition.y
            let riseOverRun: CGFloat = deltaY / deltaX // slope, or "m"
            //let line = closestTraderPosition.y - (riseOverRun * closestTraderPosition.x)
            //let lineY = riseOverRun * parentPosition.x
            /// x2 + y2 - radius = 0
            /// y = mx + 0
            ///
            /// x2 + (mx)2 - radius = 0
            /// x2 + m2*x2 - radius = 0
            /// (1+m2)*x2=radius
            /// x2 = radius/(1+m2)
            /// x = (+-) sqrt(radius/(1+m2))
            
            let positiveX = abs(sqrt(radius/(1+pow(riseOverRun, 2))))
            let negativeX = -(abs(sqrt(radius/(1+pow(riseOverRun, 2)))))
            
            var realX = CGFloat()
            var realY = CGFloat()
            
            
            /// x2 + y2 - radius = 0
            /// y = mx + 0
            /// x = y/m
            ///
            /// (y/m)^2 + y^2 - radius = 0
            /// y^2 / m^2 + y^2 - radius = 0
            /// y^2 / m^2 + y^2 = radius
            /// y^2 + y^2 * m^2 = radius * m^2
            /// y^2(1 + m^2) = radius * m^2
            /// y^2 = (radius * m^2) / (1 + m^2)
            /// y^2 = (+-) sqrt((radius * m^2) / (1 + m^2))
            
            
            let squaredSlope = pow(riseOverRun, 2)
            let positiveY = abs(sqrt((squaredSlope * radius) / (1 + squaredSlope)))
            let negativeY = -(abs(sqrt((squaredSlope * radius) / (1 + squaredSlope))))
            
            let positiveDopeX = parentPosition.x + positiveX
            let negativeDopeX = parentPosition.x + negativeX
            
            let positiveDopeY = parentPosition.y + positiveY
            let negativeDopeY = parentPosition.y + negativeY
            
            let negativeNegative = abs(findDistanceBetweenPoints(currentPoint: CGPoint(x: negativeDopeX, y: negativeDopeY), targetPoint: closestTraderPosition))
            let negativePositive = abs(findDistanceBetweenPoints(currentPoint: CGPoint(x: negativeDopeX, y: positiveDopeY), targetPoint: closestTraderPosition))
            let positiveNegative = abs(findDistanceBetweenPoints(currentPoint: CGPoint(x: positiveDopeX, y: negativeDopeY), targetPoint: closestTraderPosition))
            let positivePositive = abs(findDistanceBetweenPoints(currentPoint: CGPoint(x: positiveDopeX, y: positiveDopeY), targetPoint: closestTraderPosition))
            
            let combinations: [CGFloat] = [negativeNegative, negativePositive, positiveNegative, positivePositive]
            
            let closestCombination = combinations.min()
            var closestIndex: Int = 0
            
            for index in combinations.indices{
                if combinations[index] == closestCombination{
                    closestIndex = index
                }
            }
            
            switch closestIndex{
            case 0:
                realX = negativeX
                realY = negativeY
            case 1:
                realX = negativeX
                realY = positiveY
            case 2:
                realX = positiveX
                realY = negativeY
            case 3:
                realX = positiveX
                realY = positiveY
            default:
                break
            }

            bitCharacter.position = CGPoint(x: parentPosition.x + realX, y: parentPosition.y + realY)
            let rotationOffset = SKRange(constantValue: .pi / 2)
            let rotationLock = SKConstraint.orient(to: parentPosition, offset: rotationOffset)
            bitCharacter.constraints = [rotationLock]
        }else{
            if isParentMoving{
                bitIdleLockOn = false
                bitCharacter.position = CGPoint(x: parentPosition.x + 100, y: parentPosition.y + 100)
            }else{
                if !bitIdleLockOn{
                    bitIdleLockOn = true
                    bitCharacter.alpha = 1
                    let deactivateLock = SKAction.run{bitIdleLockOn = false}
                    bitCharacter.run(SKAction.sequence([SKAction.moveBy(x: 0, y: 50, duration: 0.5), SKAction.moveBy(x: 0, y: -50, duration: 0.5), deactivateLock]))
                }
            }
        }
    }
}
//#################################################################################################################



//  EEEEEE
//  E
//  EEEEEE
//  E
//  EEEEEE xtensions


///DEPRECATED(BY ME)
extension SKNode{
    struct Holder {
        static var hiddenAlias:String = ""
    }
    var aliasGlobal:String {
        get {
            return Holder.hiddenAlias
        }
        set(newValue) {
            Holder.hiddenAlias = newValue
        }
    }
}





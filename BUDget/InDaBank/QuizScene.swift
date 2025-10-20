//
//  QuizScene.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 11/26/23.
//

import Foundation
import SpriteKit


class QuizScene: SKScene{
    
    var questionTitle = SKSpriteNode()
    var trButton = SKSpriteNode()
    var tlButton = SKSpriteNode()
    var blButton = SKSpriteNode()
    var brButton = SKSpriteNode()
    var buttonArray: [SKSpriteNode] = []
    var escapeButton = SKSpriteNode()
    var quizQuestions: [any Sequence] = []
    
    //var question: [String] = ["Question description", "Correct answer", "Dummy", "Dummy", "Dummy", "Category"]
    
    //########################## MONEY IN OUR LIVES ################################
    
    var q1: [String] = ["Who puts off financial descisions?", "Avoider", "Collecter", "Spender", "Thinker", "Money in our lives"]
    
    var q2: [String] = ["Who like to see their money accumulate over time?", "Collector", "Avoider", "Spender", "Thinker", "Money in our lives"]
    
    var q3: [String] = ["Who do not think much about the money they spend on purchases?", "Spender", "Collecter", "Avoider", "Thinker", "Money in our lives"]
    
    var q4: [String] = ["Who is conscious about the economic states of other people?", "Thinker", "Collecter", "Spender", "Avoider", "Money in our lives"]
    
    var q5: [String] = ["Who likes to save money and be frugal on every transaction?", "Miser", "Collecter", "Spender", "Thinker", "Money in our lives"]
    
    var q6: [String] = ["What is NOT an expense?", "Government aid", "Food", "Utilities", "Medications", "Money in our lives"]
    
    var q7: [String] = ["What is the up front cost of something called?", "Sticker price", "Net price", "Front price", "Cost price", "Money in our lives"]
    
    var q8: [String] = ["When a person decides to spend or save their money, which impacts how it can be spent or saved in the future", "Tradeoff", "Sacrifice", "Miser", "Prep", "Money in our lives"]
    
    var q9: [String] = ["What is the cost after discounts?", "Net price", "Sticker price", "Real price", "Smol price", "Money in our lives"]
    
    var q39: [String] = ["What is NOT a common monthly expense of a typical adult?", "Child taxes", "Utility bills", "Housing fees", "Transportation", "Money in our lives"]
    
    
    //########################## CONSUMER SKILLS ################################
    
    var q10: [String] = ["What is NOT a way to compare prices?", "Trial both", "Read reviews", "Research policies", "Compare coupons", "Consumer Skills"]
    
    var q11: [String] = ["What is NOT a type of discount?", "Black Friday", "Free shipping", "Money off", "Percentage sale", "Consumer Skills"]
    
    var q12: [String] = ["What is not part of a standard reciept?", "Records", "Tax", "Total", "Subtotal", "Consumer Skills"]
    
    var q40: [String] = ["Why should you check every reciept?", "For the charged amounts", "To avoid tax evasion", "To make sure you checked under the cart", "To look for coupons", "Consumer Skills"]
    
    var q13: [String] = ["What type of bank account manages money?", "Checking account", "Saving account", "Manage account", "Money account", "Consumer Skills"]
    
    var q14: [String] = ["What is NOT a way to purchase?", "Barter", "Gift cards", "Mobile wallets", "Prepaid cards", "Consumer Skills"]
    
    var q41: [String] = ["To open a checking account, you do NOT need:", "To have an L.T.C.", "To be above 18", "To have a form of identification", "To have a proof of adress", "Consumer Skills"]
    
    var q42: [String] = ["To pay without easily getting monitored, what is the best transaction method?", "Cash and coin", "Write a check", "Use electronic payment", "Use a premium credit card", "Consumer Skills"]
    
    
    //########################## BUDGETING ################################
    
    var q15: [String] = ["What is the salary of a person called, if all taxes and other fees have already been deducted?", "Income", "Bribe", "Salary", "Compensation", "Budgeting"]
    
    var q16: [String] = ["What are two factors of a budget?", "Income & Expenses", "BUD & get", "Cost & Benefit", "Needs & Wants", "Budgeting"]
    
    var q17: [String] = ["What is a neccesity, that not having will negatively impact you in the long run and/or short term?", "A need", "A want", "---", "---", "Budgeting"]
    
    var q18: [String] = ["What is an optional desire, that will not hurt you in the long run if you do not obtain it?", "A want", "A need", "---", "---", "Budgeting"]
    
    var q19: [String] = ["What is the 50 - 30 - 20 rule?", "Need-want-saving", "Want-need-saving", "Saving-need-want", "100% rule", "Budgeting"]
    
    var q20: [String] = ["The tax that anybody profiting is required to pay:", "Income tax", "Everyone sax", "Sales Tax", "Profit tax", "Budgeting"]
    
    
    //########################## CREDIT ################################
    
    var q21: [String] = ["What is the 'borrowing' of money in order to buy goods thatt are relitively cheap?", "Credit", "Debit", "Debt", "Allowance", "Credit"]
    
    var q43: [String] = ["What is the 'borrowing' of money in order to buy goods thatt are relitively expensive?", "Loan", "Credit", "Debit", "Grant", "Credit"]
    
    var q22: [String] = ["What is the money you pay to entities that loaned you money, on top of what you loaned called?", "Interest", "Good will", "Debt", "Service tax", "Credit"]
    
    var q23: [String] = ["What is range of a credit score?", "350 - 800", "0 - 100", "0 - 999", "350 - 720", "Credit"]
    
    var q24: [String] = ["A high credit score means you are economically:", "Reliable", "Sloppy", "Rich", "Untrustworthy", "Credit"]
    
    var q25: [String] = ["Relitively large amounts of money given and expected back soon:", "Loan", "Allowance", "Donation", "Investment", "Credit"]
    
    
    //########################## SAVING ################################
    
    var q26: [String] = ["An account that holds money & grows:", "Savings account", "Checking account", "Growth account", "Bank account", "Saving"]
    
    var q27: [String] = ["Which account is for everyday use?", "Checking account", "Savings account", "---", "---", "Saving"]
    
    var q44: [String] = ["What do you pay off when you 'pay yourself first'?", "Your needs, wants, and savings", "You accept your income from your job", "Your crippling coffee addiction by going to a cafe", "Your family to help them out", "Saving"]
    
    var q28: [String] = ["Age to open account without parents:", "18", "16", "25", "21", "Saving"]
    
    var q29: [String] = ["Money you placed in a savings account growing at a set percentage over time:", "Simple interest", "Compound interest", "Timed interest", "---", "Saving"]
    
    var q30: [String] = ["Money you placed in a savings account growing at a growing percentage over time and amount present:", "Compound interest", "Simple interest", "Exponential interest", "This doesn't exist", "Saving"]
    
    
    //########################## INVESTING ################################
    
    var q31: [String] = ["What has more risk & reward?", "Investing", "Saving", "---", "---", "Investing"]
    
    var q32: [String] = ["The stock market portion of a given company:", "Share", "Portion", "Percentage", "Investment", "Investing"]
    
    var q33: [String] = ["The collection of different companies shares:", "Stock market", "Auction", "Trade market", "Share market", "Investing"]
    
    var q34: [String] = ["Stock market growing exponentially:", "Bull market", "Bear market", "---", "---", "Investing"]
    
    var q35: [String] = ["Stock market faltering exponentially:", "Bear market", "Bull market", "---", "---", "Investing"]
    
    var q45: [String] = ["Stocks profit off of the change in price before / after purchase:", "True", "False", "---", "---", "Investing"]
    
    var q36: [String] = ["Bonds profit off of the interest of a loan:", "True", "False", "---", "---", "Investing"]
    
    var q37: [String] = ["What is the strategy of buying many stocks to avoid net loss?", "Diversification", "Rounding", "Spreaading", "Reduntification", "Investing"]
    
    
    //########################## PROTECTING YOURSELF ################################
    
    var q38: [String] = ["Someone using your information without your permission as if they were you:", "Identity theft", "Thievery", "Meanie", "Mascaraude", "Investing"]
    
    var q46: [String] = ["Why would someone want to steal your personal information and impersonate you?", "To take what you have, and make it look like you allow it", "To sell it to third party advertisers", "To pull a prank on you", "To blackmail you and hold you hostage", "Investing"]
    
    var q47: [String] = ["Organizations that you pay little by little that will pay you a lot more if you have an accident:", "Insurance", "Relief funds", "Charities", "Backup Bros", "Investing"]
    
    var q48: [String] = ["What is the trick of luring people into accidentally giviong away personal information called?", "Phishing", "Looning", "Spoofing", "Bamboozling", "Investing"]
    
    var correctAnswer = SKSpriteNode()
    var topicLabel = SKLabelNode()
    var questionLabel = SKLabelNode()
    var trLabel = SKLabelNode()
    var tlLabel = SKLabelNode()
    var blLabel = SKLabelNode()
    var brLabel = SKLabelNode()
    var labelArray: [SKLabelNode] = []
    var bonusTimer = Timer()
    var baseStandings = 20
    var bonusStandings = 20
    var resultPopup = SKLabelNode()
    var trResult = SKSpriteNode()
    var tlResult = SKSpriteNode()
    var blResult = SKSpriteNode()
    var brResult = SKSpriteNode()
    var killSwitch: Bool = false
    var gotPrize: Bool = false
    var quizClock = SKSpriteNode()
    var quizNeedle = SKSpriteNode()
    var clockDegrees: CGFloat = 0

    
    let trPos = CGPoint(x: 150, y: -100)
    let tlPos = CGPoint(x: -150, y: -100)
    let blPos = CGPoint(x: -150, y: -400)
    let brPos = CGPoint(x: 150, y: -400)
    
    override func didMove(to view: SKView){
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        quizQuestions.append(contentsOf: [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, q32, q33, q34, q35, q36, q37, q38, q39, q40, q41, q42, q43, q44, q45, q46, q47, q48])
        
        escapeButton = addEscapeButton(sceneTo: self)
        
        topicLabel = addLabel(sceneTo: self, scale: 60, position: CGPoint(x: 0, y: 450), color: .black, text: "ahahhahahhahhaha", zPosition: 2)
        
        quizClock = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 350), texture: quizClockTexture, scale: 0.1)
        quizNeedle = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 350), texture: quizNeedleTexture, scale: 0.1)
        
        questionTitle = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 200), texture: questionqTexture, scale: 0.6)
        questionLabel = addLabel(sceneTo: self, scale: 25, position: CGPoint(x: 0, y: 205), color: .black, text: "ahahhahahhahhaha", zPosition: 2)
        
        
//        questionLabel = addLabel(sceneTo: self, scale: 0, position: CGPoint(x: 0, y: -300), color: .black, text: "ahahhahahhahhaha", zPosition: 10)
//        questionLabel.alpha = 0
        
        buttonArray.append(contentsOf: [trButton, tlButton, blButton, brButton, trResult, tlResult, blResult, brResult])
        for button in buttonArray.indices{
            buttonArray[button] = addSprite(sceneTo: self, zPosition: 1, position: CGPoint(x: 0, y: 0), texture: answerqTexture, scale: 0.5)
        }
        trButton = buttonArray[0]
        tlButton = buttonArray[1]
        blButton = buttonArray[2]
        brButton = buttonArray[3]
        trResult = buttonArray[4]
        tlResult = buttonArray[5]
        blResult = buttonArray[6]
        brResult = buttonArray[7]
        trButton.position = trPos
        tlButton.position = tlPos
        blButton.position = blPos
        brButton.position = brPos
        trResult.position = trPos
        tlResult.position = tlPos
        blResult.position = blPos
        brResult.position = brPos
        trResult.alpha = 0
        tlResult.alpha = 0
        blResult.alpha = 0
        brResult.alpha = 0
        trResult.zPosition = 3
        tlResult.zPosition = 3
        blResult.zPosition = 3
        brResult.zPosition = 3
        
        
        labelArray.append(contentsOf: [trLabel, tlLabel, blLabel, brLabel])
        for button in labelArray.indices{
            labelArray[button] = addLabel(sceneTo: self, scale: 25, position: CGPoint(x: 0, y: 0), color: .black, text: "possibleAnswer", zPosition: 2)
            labelArray[button].preferredMaxLayoutWidth = 200
            labelArray[button].lineBreakMode = .byWordWrapping
            labelArray[button].numberOfLines = 5
            labelArray[button].verticalAlignmentMode = .center
        }
        trLabel = labelArray[0]
        tlLabel = labelArray[1]
        blLabel = labelArray[2]
        brLabel = labelArray[3]
        trLabel.position = trPos
        tlLabel.position = tlPos
        blLabel.position = blPos
        brLabel.position = brPos
        

        drawQuestion()
        
        bonusTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(drainBonus), userInfo: nil, repeats: true)
        
        addPinchCapability(sceneTo: self, selector: #selector(pinchReaction))
    }
    
    @objc func drainBonus(){
        if !gotPrize{
            clockDegrees += 2
            let clockRadians = (clockDegrees / 180) * .pi
            if clockDegrees > 360{
                gotPrize = true
                nextQuestion()
                budCoin += -20
                appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "quizMaker", transactionAmount: -20, transactionItem: "coins")
                callForAnimation(positive: false)
                heavy.impactOccurred()
            }
            quizNeedle.zRotation = -clockRadians
        }
    }
    
    func inflateResult(score: Int){
       let result = addLabel(sceneTo: self, scale: 0, position: CGPoint(x: 0, y: -800), color: .black, text: "\(score)", zPosition: 10)
        if score >= 0{
            result.fontColor = .green
        }else{
            result.fontColor = .red
        }
        let increaseScale: SKAction = SKAction.run {
            let fs = result.fontSize
            result.fontSize = fs + 1
        }
        result.run(SKAction.repeatForever(SKAction.sequence([increaseScale, SKAction.wait(forDuration: 0.01)])))
        result.run(SKAction.sequence([SKAction.move(to: CGPoint(x: 0, y: 800), duration: 2), SKAction.removeFromParent()]))
        print("baloooon")
    }
    
    func drawQuestion(){
        gotPrize = false
        trResult.alpha = 0
        tlResult.alpha = 0
        blResult.alpha = 0
        brResult.alpha = 0
        let randomQuestion = generateRandomInteger(highestPossibility: (quizQuestions.count - 1), lowestPossibility: 0)
        let randomArangment = generateRandomInteger(highestPossibility: 3, lowestPossibility: 0)
        let questionSet = quizQuestions[randomQuestion] as! [Any]
        topicLabel.text = questionSet[5] as? String
        questionLabel.text = questionSet[0] as? String
        questionLabel.preferredMaxLayoutWidth = 600
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 2
        questionLabel.verticalAlignmentMode = .center
        switch randomArangment{
        case 0:
            trLabel.text = questionSet[1] as? String
            tlLabel.text = questionSet[2] as? String
            blLabel.text = questionSet[3] as? String
            brLabel.text = questionSet[4] as? String
            correctAnswer = trButton
            trResult.texture = correctTexture
            tlResult.texture = wrongTexture
            blResult.texture = wrongTexture
            brResult.texture = wrongTexture
        case 1:
            trLabel.text = questionSet[2] as? String
            tlLabel.text = questionSet[3] as? String
            blLabel.text = questionSet[4] as? String
            brLabel.text = questionSet[1] as? String
            correctAnswer = brButton
            trResult.texture = wrongTexture
            tlResult.texture = wrongTexture
            blResult.texture = wrongTexture
            brResult.texture = correctTexture
        case 2:
            trLabel.text = questionSet[3] as? String
            tlLabel.text = questionSet[4] as? String
            blLabel.text = questionSet[1] as? String
            brLabel.text = questionSet[2] as? String
            correctAnswer = blButton
            trResult.texture = wrongTexture
            tlResult.texture = wrongTexture
            blResult.texture = correctTexture
            brResult.texture = wrongTexture
        case 3:
            trLabel.text = questionSet[4] as? String
            tlLabel.text = questionSet[1] as? String
            blLabel.text = questionSet[2] as? String
            brLabel.text = questionSet[3] as? String
            correctAnswer = tlButton
            trResult.texture = wrongTexture
            tlResult.texture = correctTexture
            blResult.texture = wrongTexture
            brResult.texture = wrongTexture
        default:
            break
        }
    }
    
    func nextQuestion(){
        let draw: SKAction = SKAction.run {
            self.drawQuestion()
        }
        let fadeInAction: SKAction = SKAction.sequence([SKAction.fadeAlpha(to: 0.5, duration: 0.25), SKAction.wait(forDuration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.25)])
        trResult.run(fadeInAction)
        tlResult.run(fadeInAction)
        blResult.run(fadeInAction)
        brResult.run(fadeInAction)
        self.run(SKAction.sequence([SKAction.wait(forDuration: 1), draw]))
    }
    
    func callForAnimation(positive: Bool){
        var profit = Int((340 - clockDegrees)/10)
        if clockDegrees > 340{
            profit = Int((340 - clockDegrees))
        }
        if positive{
            inflateResult(score: profit)
        }else{
            inflateResult(score: -20)
        }
        clockDegrees = 0
        quizNeedle.zRotation = 0
    }
    
    func respondToPlayerAnswer(answer: SKSpriteNode){
        if answer == correctAnswer && !gotPrize{
            print("correct")
            gotPrize = true
            nextQuestion()
            var profit = Int((340 - clockDegrees)/10)
            if clockDegrees > 340{
                profit = Int((340 - clockDegrees))
            }
            budCoin += profit
            appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "quizMaker", transactionAmount: profit, transactionItem: "coins")
            callForAnimation(positive: true)
            light.impactOccurred()
        }else if answer != correctAnswer && !gotPrize {
            print("wrong")
            gotPrize = true
            nextQuestion()
            budCoin += -20
            appendTransactionRecord(nameOfPlayer: "bud", nameOfEntity: "quizMaker", transactionAmount: -20, transactionItem: "coins")
            callForAnimation(positive: false)
            heavy.impactOccurred()
        }
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
            }
            if trButton.contains(position){
                respondToPlayerAnswer(answer: trButton)
            }
            if tlButton.contains(position){
                respondToPlayerAnswer(answer: tlButton)
            }
            if blButton.contains(position){
                respondToPlayerAnswer(answer: blButton)
            }
            if brButton.contains(position){
                respondToPlayerAnswer(answer: brButton)
            }
        }
    }
}

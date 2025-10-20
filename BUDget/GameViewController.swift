//
//  GameViewController.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 9/22/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let need = MemoryVault.value(forKey: "needsTutorial") as? Bool{
                needsTutorial = need
            }else{
                needsTutorial = true
            }
            if needsTutorial{
                if let scene = SKScene(fileNamed: "TutorialScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                view.ignoresSiblingOrder = true
                view.showsPhysics = false
                view.showsFPS = false
                view.showsNodeCount = false
            }else{
                if let scene = SKScene(fileNamed: "MapScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                }
                
                view.ignoresSiblingOrder = true
                view.showsPhysics = false
                view.showsFPS = false
                view.showsNodeCount = false
            }
        }
        self.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool{
        get{
            return true
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            isInShootingMode.toggle()
            print(isInShootingMode)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

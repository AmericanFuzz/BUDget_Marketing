//
//  BlackOutTransition.swift
//  BUDget
//
//  Created by Sebastian Kazakov on 10/29/23.
//

import Foundation
import SpriteKit


class BlackOutTransition: SKScene{
    
    var clockTime: Int = 0
    var killSwitch: Bool = false
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
   
    }
    
    override func update(_ currentTime: TimeInterval) {
        clockTime += 1
        if clockTime >= 2{
            switch sceneSetTo{
            case "Bank":
                dashTransition(sceneTo: BankScene(size: self.size), sceneFrom: self, direction: sceneDirectionWith, sceneDashName: "Bank", k_switch: &killSwitch)
            case "Bank2":
                dashTransition(sceneTo: BankScene(size: self.size), sceneFrom: self, direction: sceneDirectionWith, sceneDashName: "Bank2", k_switch: &killSwitch)
            case "Map":
                dashTransition(sceneTo: MapScene(size: self.size), sceneFrom: self, direction: .down, sceneDashName: "Map", k_switch: &killSwitch)
            case "Map2":
                dashTransition(sceneTo: MapScene(size: self.size), sceneFrom: self, direction: .up, sceneDashName: "Map2", k_switch: &killSwitch)
            case "Profile":
                dashTransition(sceneTo: ProfileScene(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "Profile", k_switch: &killSwitch)
            case "Shop":
                dashTransition(sceneTo: ShopScene(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "Shop", k_switch: &killSwitch)
            case "Junk":
                dashTransition(sceneTo: JunkScene(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "Junk", k_switch: &killSwitch)
            case "Videos":
                dashTransition(sceneTo: VideosScene(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "Videos", k_switch: &killSwitch)
//            case "Teller":
//                dashTransition(sceneTo: TellerScene(size: self.size), sceneFrom: self, direction: .down, sceneDashName: "Teller", k_switch: &killSwitch)
            case "BankL":
                dashTransition(sceneTo: BankScene(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "BankL", k_switch: &killSwitch)
            case "BankBL":
                dashTransition(sceneTo: BankScene(size: self.size), sceneFrom: self, direction: .left, sceneDashName: "BankBL", k_switch: &killSwitch)
            case "BankR":
                dashTransition(sceneTo: BankScene(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "BankR", k_switch: &killSwitch)
            case "BankBR":
                dashTransition(sceneTo: BankScene(size: self.size), sceneFrom: self, direction: .right, sceneDashName: "BankBR", k_switch: &killSwitch)
            default:
                break
            }
        }
    }
}

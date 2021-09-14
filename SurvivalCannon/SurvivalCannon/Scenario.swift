//
//  Scenario.swift
//  SurvivalCannon
//
//  Created by Lucas Dimer Justo on 10/09/21.
//

import Foundation
import SpriteKit

class Scenario: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Background set-up
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "BG_menu")
        // 9:16 proportion for the size
        background.size = CGSize(width: ((UIScreen.main.bounds.height * 1)/16)*9, height: UIScreen.main.bounds.height * 1)
        background.zPosition = 0
        self.addChild(background)
        
        // Adds main menu
//        let mainMenu = MainMenu(parentScene: self)
//        mainMenu.position = CGPoint(x: 0, y: 0)
//        mainMenu.size = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height)
//        self.addChild(mainMenu)
        
        let settingsMenu = SettingsMenu(parentScene: self, sound: true, music: false)
        settingsMenu.position = CGPoint(x: 0, y: 0)
        settingsMenu.size = CGSize(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height)
        self.addChild(settingsMenu)
    }
    
}

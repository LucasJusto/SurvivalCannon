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
        let mainMenu = MainMenu(parentScene: self)
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: self.view!.scene!.size.width, height: self.view!.scene!.size.height)
        self.addChild(mainMenu)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}

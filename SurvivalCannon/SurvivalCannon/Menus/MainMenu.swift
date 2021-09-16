//
//  MainMenu.swift
//  SurvivalCannon
//
//  Created by João Brentano on 13/09/21.
//

import Foundation
import SpriteKit

class MainMenu: SKSpriteNode {
    var parentScene: SKScene?
    
    init(parentScene: SKScene) {
        super.init(texture: nil, color: .white, size: CGSize(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 1))
        self.parentScene = parentScene
        self.position = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
        self.name = "mainMenu"
        
        var y = UIScreen.main.bounds.height * -0.07
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), text: "PLAY", action: {
            guard let scenario = parentScene as? Scenario else { return }
            scenario.removeAllButMusic()
            scenario.gameBegin()
        }))
        
        y = UIScreen.main.bounds.height * -0.17
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), text: "RANKING", action: {
            if let view = parentScene.view?.next as? GameViewController {
                GameCenter.presentLeaderboard(view: view)
            }
        }))
        
        y = UIScreen.main.bounds.height * -0.27
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), text: "SETTINGS", action: {
            guard let scenario = parentScene as? Scenario else { return }
            scenario.removeAllButMusic()
            scenario.setBackground()
            scenario.setSettings()
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

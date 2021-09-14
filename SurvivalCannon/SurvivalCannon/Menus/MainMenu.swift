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
        self.zPosition = 700
        self.name = "mainMenu"
        
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "BG_menu")
        background.size = CGSize(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 1)
        
        background.zPosition = 0
        self.addChild(background)
        
        var y = UIScreen.main.bounds.height * -0.02
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), text: "PLAY", action: {
            print("PLAY")
        }))
        
        y = UIScreen.main.bounds.height * -0.12
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), text: "RANKING", action: {
            if let view = parentScene.view?.next as? GameViewController {
                GameCenter.presentLeaderboard(view: view)
            }
        }))
        
        
        y = UIScreen.main.bounds.height * -0.22
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), text: "SETTINGS", action: {
            print("SETTINGS")
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

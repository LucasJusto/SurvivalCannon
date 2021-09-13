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
        
        //        let welcomeBack: SKLabelNode = SKLabelNode(text: "WelcomeBack!")
        //        welcomeBack.fontName = "Copperplate"
        //        welcomeBack.fontSize = self.size.height * 0.08
        //        welcomeBack.position = CGPoint(x: 0, y: self.size.height * 0.3)
        //        welcomeBack.fontColor = .black
        //        let earned: SKLabelNode = SKLabelNode(text: "You earned")
        //        earned.fontName = "Copperplate"
        //        earned.fontSize = welcomeBack.fontSize * 0.95
        //        earned.position = CGPoint(x: 0, y: welcomeBack.position.y - self.size.height * 0.1)
        //        earned.fontColor = .black
        //        let coins: SKLabelNode = SKLabelNode(text: "aa")
        //        coins.fontName = "Copperplate"
        //        coins.fontSize = welcomeBack.fontSize * 0.9
        //        coins.fontColor = .black
        //        coins.horizontalAlignmentMode = .left
        //        let whileOff1: SKLabelNode = SKLabelNode(text: "during the s that")
        //        whileOff1.fontName = "Copperplate"
        //        whileOff1.fontSize = welcomeBack.fontSize * 0.7
        //        whileOff1.position = CGPoint(x: 0, y: coins.position.y - self.size.height * 0.1)
        //        whileOff1.fontColor = .black
        //        let whileOff2: SKLabelNode = SKLabelNode(text: "you were offline.")
        //        whileOff2.fontName = "Copperplate"
        //        whileOff2.fontSize = welcomeBack.fontSize * 0.7
        //        whileOff2.position = CGPoint(x: 0, y: whileOff1.position.y - self.size.height * 0.08)
        //        whileOff2.fontColor = .black
        //
        //        self.addChild(welcomeBack)
        //        self.addChild(earned)
        //        self.addChild(coins)
        //        self.addChild(whileOff1)
        //        self.addChild(whileOff2)
        
        background.zPosition = 0
        self.addChild(background)
        
        var y = UIScreen.main.bounds.height * -0.02
        self.addChild(MainMenuButton(mainMenu: self, position: CGPoint(x: 0, y: y), text: "PLAY", action: {
            print("PLAY")
        }))
        
        y = UIScreen.main.bounds.height * -0.12
        self.addChild(MainMenuButton(mainMenu: self, position: CGPoint(x: 0, y: y), text: "RANKING", action: {
            if let view = parentScene.view?.next as? GameViewController {
                //GameCenter.presentLeaderboard(view: view)
            }
        }))
        
        
        y = UIScreen.main.bounds.height * -0.22
        self.addChild(MainMenuButton(mainMenu: self, position: CGPoint(x: 0, y: y), text: "SETTINGS", action: {
            print("SETTINGS")
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

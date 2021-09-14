//
//  FinalScore.swift
//  SurvivalCannon
//
//  Created by Lucca Molon on 13/09/21.
//

import Foundation
import SpriteKit


class FinalScore: SKSpriteNode {
    var myScene: SKScene?
    
    init(scene: SKScene) {
        super.init(texture: nil, color: .white, size: CGSize(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 1))
        self.myScene = scene
        self.position = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
        self.name = "finalScore"
        let font = "Copperplate"
        let color = hexStringToUIColor(hex: "#40200e")
        
        
        let background = SKSpriteNode(imageNamed: "scenario")
        background.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        background.zPosition = 0
        
        let backgroundScore = SKSpriteNode(imageNamed: "backgroundScore")
        backgroundScore.size = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.55)
        backgroundScore.position = CGPoint(x: 0, y: self.size.height * 0.05)
        backgroundScore.zPosition = 1
        
        let scoreLabel: SKLabelNode = SKLabelNode(text: "Your Score")
        scoreLabel.fontName = font
        scoreLabel.fontSize = self.size.height * 0.035
        scoreLabel.fontColor = color
        scoreLabel.position = CGPoint(x: 0, y: self.size.height * 0.2)
        scoreLabel.zPosition = 2
        
        let score: SKLabelNode = SKLabelNode(text: "456")
        score.fontName = font
        score.fontSize = self.size.height * 0.15
        score.fontColor = color
        score.position = CGPoint(x: 0, y: self.size.height * 0.09)
        score.zPosition = 2
        
        let bestScore: SKLabelNode = SKLabelNode(text: "Best score: 999")
        bestScore.fontName = font
        bestScore.fontSize = self.size.height * 0.02
        bestScore.fontColor = color
        bestScore.position = CGPoint(x: 0, y: self.size.height * 0.05)
        bestScore.zPosition = 2
        
        let playAgainButton = Button(parentMenu: self, position: CGPoint(x: 0, y: self.size.height * -0.01), text: "Try Again") {
            print("play again")
        }
        playAgainButton.zPosition = 1
        
        let menuButton = Button(parentMenu: self, position: CGPoint(x: 0, y: self.size.height * -0.1), text: "Menu") {
            print("menu")
        }
        menuButton.zPosition = 1
        menuButton.size = CGSize(width: UIScreen.main.bounds.width * 0.3, height: UIScreen.main.bounds.height * 0.05)
        
        self.addChild(background)
        self.addChild(backgroundScore)
        self.addChild(scoreLabel)
        self.addChild(score)
        self.addChild(bestScore)
        self.addChild(playAgainButton)
        self.addChild(menuButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

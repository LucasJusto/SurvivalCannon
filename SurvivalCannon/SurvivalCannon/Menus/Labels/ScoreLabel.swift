//
//  ScoreLabel.swift
//  SurvivalCannon
//
//  Created by Lucca Molon on 14/09/21.
//

import Foundation
import SpriteKit

class ScoreLabel {
    var node: SKLabelNode
    var count: Int
    
    init() {
        node = SKLabelNode(text: "Score: 0")
        count = 0
        node.fontSize = UIScreen.main.bounds.height * 0.03
        node.fontName = "Copperplate"
        node.fontColor = hexStringToUIColor(hex: "#40200e")
        node.name = "scoreLabel"
        node.position = CGPoint(x: 0, y: UIScreen.main.bounds.height * 0.5 - node.fontSize * 2.5)
        node.zPosition = 2
    }
    
    

    func update() {
        count += 1
        node.text = "Score: \(count)"
    }
    
    
}


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
        node.zPosition = 10
    }
    
    func resetScore() {
        count = 0
        node.text = "Score: \(count)"
    }

    func update(points: Int) {
        self.pointSinalizer(points: points)
        count += points
        node.text = "Score: \(count)"
    }
    
    func pointSinalizer(points: Int) {
        let point = SKLabelNode(text: "+\(points)")
        point.fontSize = UIScreen.main.bounds.height * 0.05
        point.fontName = "Copperplate"
        point.fontColor = hexStringToUIColor(hex: "#40200e")
        point.zPosition = 50
        point.position = CGPoint(x: self.node.position.x, y: self.node.position.y - UIScreen.main.bounds.height * 0.1)
        let moveUP = SKAction.moveTo(y: self.node.position.y, duration: 0.5)
        point.run(moveUP) {
            point.removeFromParent()
        }
        self.node.parent!.addChild(point)
    }
    
}


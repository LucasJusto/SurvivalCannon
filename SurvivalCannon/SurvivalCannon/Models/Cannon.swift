//
//  Cannon.swift
//  SurvivalCannon
//
//  Created by Lucca Molon on 13/09/21.
//

import Foundation
import SpriteKit

class Cannon {
    var health: Int
    var node: SKSpriteNode
    
    init() {
        health = 100
        let texture = SKTexture(imageNamed: "cannon")
        node = SKSpriteNode(texture: texture)
        node.name = "cannon"
        node.zPosition = 1
        node.size = CGSize(width: UIScreen.main.bounds.height * 0.87 * 0.3, height: UIScreen.main.bounds.height * 0.3)
        node.physicsBody?.contactTestBitMask = node.physicsBody!.collisionBitMask
        node.physicsBody?.affectedByGravity = false
        node.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: node.size.width, height: node.size.height))
    }
}

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
        let texture = SKTexture(imageNamed: "Cannon")
        node = SKSpriteNode(texture: texture)
        node.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: node.size.width, height: node.size.height))
    }
}

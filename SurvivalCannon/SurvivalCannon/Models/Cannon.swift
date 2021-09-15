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
        node.name = "Cannon"
        node.zPosition = 5
        let percentageOfScreenHeight: CGFloat = 0.2 //the percentage of the screen height that will define the cannon's height
        let widthProportionToHeight: CGFloat = 0.87 //for cannon, 1 height = 0.87 width
        node.size = CGSize(width: UIScreen.main.bounds.height * widthProportionToHeight * percentageOfScreenHeight, height: UIScreen.main.bounds.height * percentageOfScreenHeight)
        node.physicsBody?.contactTestBitMask = node.physicsBody!.collisionBitMask
        node.physicsBody?.affectedByGravity = false
        node.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: node.size.width, height: node.size.height))
    }
}

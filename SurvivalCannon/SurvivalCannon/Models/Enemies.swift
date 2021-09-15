//
//  Enemy.swift
//  SurvivalCannon
//
//  Created by Willian Magnum Albeche on 13/09/21.
//
import Foundation
import SpriteKit

class Enemy {
    
    var nameEnemy: String
    var typeEnemy: String
    var breakable: Bool
    
    init(nameEnemy:String , typeEnemy:String , breakable:Bool) {
        self.nameEnemy = nameEnemy
        self.typeEnemy = typeEnemy
        self.breakable = breakable
    }
}

class Barrel: Enemy {
    var health: Int
    var texture: String
    var node: SKSpriteNode
    
    override init(nameEnemy: String, typeEnemy: String, breakable: Bool) {
        self.health = 100
        self.texture = "barrel"
        node = SKSpriteNode(imageNamed: texture)
        node.physicsBody = SKPhysicsBody.init(rectangleOf: node.size)
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }

}

class Anvil: Enemy {
    var texture:String
    var node:SKSpriteNode
    
    override init(nameEnemy: String, typeEnemy: String, breakable: Bool) {
        self.texture = "anvil"
        node = SKSpriteNode(imageNamed: texture)
        node.physicsBody = SKPhysicsBody.init(rectangleOf: node.size)
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }
}

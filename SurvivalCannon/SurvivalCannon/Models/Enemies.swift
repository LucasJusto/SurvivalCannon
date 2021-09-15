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
    var texture: SKTexture
    var node: SKSpriteNode
    
    override init(nameEnemy: String, typeEnemy: String, breakable: Bool) {
        self.health = 100
        self.texture = SKTexture(imageNamed: "barrel")
        node = SKSpriteNode(texture:  texture)
        node.size = CGSize(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.2)
        node.physicsBody = SKPhysicsBody( texture: node.texture!, size: node.texture!.size())
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }

}

class Anvil: Enemy {
    var texture:SKTexture
    var node:SKSpriteNode
    
    override init(nameEnemy: String, typeEnemy: String, breakable: Bool) {
        self.texture = SKTexture(imageNamed: "anvil")
        node = SKSpriteNode(texture: texture)
        node.size = CGSize(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.1)
        node.physicsBody = SKPhysicsBody( texture: node.texture!, size: node.texture!.size())
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }
}

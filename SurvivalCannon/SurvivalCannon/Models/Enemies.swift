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
        node.name = "barrel"
        node.zPosition = 5
        let percentageOfScreenHeight: CGFloat = 0.1
        node.size = CGSize(width:UIScreen.main.bounds.height * percentageOfScreenHeight , height: ((UIScreen.main.bounds.height * percentageOfScreenHeight) * 1.38 ))
    
        node.physicsBody = SKPhysicsBody( texture: node.texture!, size: node.size)
        node.physicsBody?.isDynamic = false
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }

}

class Anvil: Enemy { // 1 de largura po 0.64 de altura
    var texture:SKTexture
    var node:SKSpriteNode
    
    override init(nameEnemy: String, typeEnemy: String, breakable: Bool) {
        self.texture = SKTexture(imageNamed: "anvil")
        node = SKSpriteNode(texture: texture)
        node.name = "anvil"
        node.zPosition = 5
        let percentageOfScreenHeight: CGFloat = 0.1
        node.size = CGSize(width: ((UIScreen.main.bounds.height * percentageOfScreenHeight)/0.64), height: UIScreen.main.bounds.height * percentageOfScreenHeight)
        node.physicsBody = SKPhysicsBody( texture: node.texture!, size: node.size)
        node.physicsBody?.isDynamic = false
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }
}

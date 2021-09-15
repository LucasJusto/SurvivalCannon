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
        let percentageOfScreenHeight: CGFloat = 0.13
        node.size = CGSize(width:UIScreen.main.bounds.height * percentageOfScreenHeight , height: ((UIScreen.main.bounds.height * 0.13) * 1.38 ))
    
        node.physicsBody = SKPhysicsBody( texture: node.texture!, size: node.size)
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
        node.size = CGSize(width: ((UIScreen.main.bounds.height * 0.13)/0.64), height: UIScreen.main.bounds.height * 0.13)
        node.physicsBody = SKPhysicsBody( texture: node.texture!, size: node.size)
        super.init(nameEnemy: nameEnemy, typeEnemy: typeEnemy, breakable: breakable)
    }
}

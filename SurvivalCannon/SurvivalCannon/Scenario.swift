//
//  Scenario.swift
//  SurvivalCannon
//
//  Created by Lucas Dimer Justo on 10/09/21.
//

import Foundation
import SpriteKit

class Scenario: SKScene {
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        let mainMenu = MainMenu(parentScene: self)
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: self.view!.scene!.size.width, height: self.view!.scene!.size.height)
        self.addChild(mainMenu)
        var barrelTimeSpawn = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("spawnEnemyBarrel"), userInfo: nil, repeats: true)
        var anvilTimeSpawn = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("spawnEnemyAnvil"), userInfo: nil, repeats: true)
        
    }
    
    
    
// MARK: - create and spawn enemys
    func createBarrel(x: CGFloat) -> SKSpriteNode{
        let barrel = Barrel(nameEnemy: "Barrel", typeEnemy: "barrel", breakable: true)
        barrel.node.position = CGPoint(x: x, y: (self.scene?.size.height)!)
        barrel.node.zPosition = 1
        
        return barrel.node
    }
    
    @objc func spawnEnemyBarrel(){
        let maxRange = (self.scene?.size.width)! / 2.8
        let randomX = CGFloat.random(in: -maxRange...maxRange)
        let barrel = self.createBarrel(x: randomX)
        let moveDown = SKAction.moveTo(y: -(self.frame.size.height / 2), duration: 2)
        barrel.run(moveDown) {
            barrel.removeFromParent()
        }
        addChild(barrel)
        
    }
    
    func createAnvil(x: CGFloat) -> SKSpriteNode{
        let anvil = Anvil(nameEnemy: "Anvil", typeEnemy: "anvil", breakable: false)
        anvil.node.position = CGPoint(x: x, y: (self.scene?.size.height)!)
        anvil.node.zPosition = 1
        
        return anvil.node
    }
    
    @objc func spawnEnemyAnvil() {
        let maxRange = (self.scene?.size.width)! / 2.8
        let randomX = CGFloat.random(in: -maxRange...maxRange)
        let anvil = self.createAnvil(x: randomX)
        let moveDown = SKAction.moveTo(y: -(self.frame.size.height / 2), duration: 2)
        anvil.run(moveDown) {
            anvil.removeFromParent()
        }
        addChild(anvil)
     }
    
    
}

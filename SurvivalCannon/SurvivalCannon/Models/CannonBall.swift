//
//  CannonBall.swift
//  SurvivalCannon
//
//  Created by Lucas Dimer Justo on 15/09/21.
//

import Foundation
import SpriteKit

class CannonBall: SKSpriteNode {
    let damage: Double = 1.0
    init(){
        super.init(texture: SKTexture(imageNamed: "Ball"), color: UIColor(named: "black")!,size: CGSize(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07))
        self.physicsBody = SKPhysicsBody(circleOfRadius: UIScreen.main.bounds.width * 0.035)
        self.physicsBody?.contactTestBitMask = self.physicsBody!.collisionBitMask
        self.name = "CannonBall"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shot(cannonPosition: CGPoint, cannonSize: CGSize, screenHeight: CGFloat, scene: Scenario){
        self.position = CGPoint(x: cannonPosition.x, y: cannonPosition.y + cannonSize.height/2 + self.size.height/2)
        self.zPosition = 10
        var impulseAction = SKAction.applyImpulse(CGVector(dx: 0, dy: screenHeight/12), duration: 0.01)
        if screenHeight > 1000 {
            impulseAction = SKAction.applyImpulse(CGVector(dx: 0, dy: screenHeight/3), duration: 0.01)
        }
        self.run(SKAction.sequence([impulseAction, .wait(forDuration: 0.5)])){
            self.removeFromParent()
        }
        scene.addChild(self)
    }
}

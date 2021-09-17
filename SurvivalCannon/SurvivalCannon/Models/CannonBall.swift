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
}

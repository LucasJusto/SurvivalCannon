//
//  FinalScoreScene.swift
//  SurvivalCannon
//
//  Created by Lucca Molon on 13/09/21.
//

import Foundation
import SpriteKit


class FinalScore: SKSpriteNode {
    var myScene: SKScene?
    
    init(scene: SKScene) {
        super.init(texture: nil, color: .white, size: CGSize(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 1))
        self.myScene = scene
        self.position = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
        self.name = "finalScore"
        
        let background = SKSpriteNode(imageNamed: <#T##String#>)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

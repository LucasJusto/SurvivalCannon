//
//  MainMenuButton.swift
//  SurvivalCannon
//
//  Created by João Brentano on 13/09/21.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode {
    unowned var parentMenu: SKSpriteNode
    var action: () -> ()
    
    init(parentMenu: SKSpriteNode, position: CGPoint, text: String, action: @escaping () -> ()) {
        self.parentMenu = parentMenu
        self.action = action
        super.init(texture: SKTexture(imageNamed: "Button"), color: .green, size: CGSize(width: parentMenu.size.width * 0.5, height: parentMenu.size.height * 0.06))
        self.position = position
        self.isUserInteractionEnabled = true
        self.name = "mainMenuButton"
        self.zPosition = 1
        
        let label = SKLabelNode(text: text)
        label.fontSize = self.size.height * 0.60
        label.fontColor = UIColor(named: "buttonTextColor")
        label.fontName = "Copperplate"
        label.verticalAlignmentMode = .center
        label.name = self.name
        label.zPosition = 2
        self.addChild(label)
    }
    
    init(parentMenu: SKSpriteNode, position: CGPoint, size: CGSize, text: String, action: @escaping () -> ()) {
        self.parentMenu = parentMenu
        self.action = action
        super.init(texture: SKTexture(imageNamed: "Button"), color: .green, size: size)
        self.position = position
        self.isUserInteractionEnabled = true
        self.name = "mainMenuButton"
        self.zPosition = 1
        
        let label = SKLabelNode(text: text)
        label.fontSize = self.size.height * 0.60
        label.fontColor = UIColor(named: "buttonTextColor")
        label.fontName = "Copperplate"
        label.verticalAlignmentMode = .center
        label.name = self.name
        label.zPosition = 2
        self.addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scaleDown = SKAction.scale(to: 0.95, duration: 0.05)
        let scaleUp = SKAction.scale(to: 1, duration: 0.05)
        let scaleSequence = SKAction.sequence([scaleDown, scaleUp])
        self.run(scaleSequence)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        let node = self.atPoint(location ?? .zero)
        
        if node.name == self.name {
            self.action()
        }
    }
}

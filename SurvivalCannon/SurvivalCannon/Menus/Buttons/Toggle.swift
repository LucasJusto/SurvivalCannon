//
//  SettingsToggle.swift
//  SurvivalCannon
//
//  Created by João Brentano on 13/09/21.
//

import Foundation
import SpriteKit

class Toggle: SKSpriteNode {
    unowned var parentMenu: SKSpriteNode
    var value: Bool
    let title: String
    
    init(parentMenu: SKSpriteNode, position: CGPoint, title: String, value: Bool) {
        self.parentMenu = parentMenu
        self.value = value
        self.title = title
        super.init(texture: SKTexture(imageNamed: "Button"), color: .green, size: CGSize(width: parentMenu.size.width * 0.5, height: parentMenu.size.height * 0.06))
        self.position = position
        self.isUserInteractionEnabled = true
        self.name = "mainMenuButton"
        self.zPosition = 1
        addLabels()
    }
    
    func addLabels() {
        let title = SKLabelNode(text: title)
        title.fontSize = self.size.height * 0.60
        title.fontColor = UIColor(named: "toggleTitleColor")
        title.fontName = "Copperplate"
        title.position = CGPoint(x: 0, y: self.size.height * 0.60)
        title.name = self.name
        title.zPosition = 2
        self.addChild(title)
        
        let label = SKLabelNode(text: "\(getValueText())")
        label.fontSize = self.size.height * 0.60
        label.fontColor = UIColor(named: "buttonTextColor")
        label.fontName = "Copperplate"
        label.verticalAlignmentMode = .center
        label.name = self.name
        label.zPosition = 2
        self.addChild(label)
    }
    
    func getValueText() -> String {
        if value {
            return "ON"
        }
        return "OFF"
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
            value.toggle()
            removeAllChildren()
            addLabels()
        }
    }
}

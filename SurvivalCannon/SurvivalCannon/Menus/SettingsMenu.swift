//
//  SettingsMenu.swift
//  SurvivalCannon
//
//  Created by João Brentano on 13/09/21.
//

import Foundation
import SpriteKit

class SettingsMenu: SKSpriteNode {
    var parentScene: SKScene?
    var sound: Bool
    var music: Bool
    
    init(parentScene: SKScene, sound: Bool, music: Bool) {
        self.sound = sound
        self.music = music
        super.init(texture: nil, color: .white, size: CGSize(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 1))
        self.parentScene = parentScene
        self.position = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
        
        var y = UIScreen.main.bounds.height * -0.07
        self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "SOUND", value: false))
        
        y = UIScreen.main.bounds.height * -0.17
        self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "MUSIC", value: true))
        
        y = UIScreen.main.bounds.height * -0.29
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), size: CGSize(width: self.size.width * 0.3, height: self.size.height * 0.04), text: "BACK", action: {
            guard let scenario = parentScene as? Scenario else { return }
            scenario.removeAllChildren()
            scenario.setBackground()
            scenario.setMainMenu()
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        
        var y = UIScreen.main.bounds.height * -0.14
        self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "SOUND", value: false))
        
        y = UIScreen.main.bounds.height * -0.24
        self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "MUSIC", value: true))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

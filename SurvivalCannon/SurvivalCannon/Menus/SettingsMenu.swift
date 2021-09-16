//
//  SettingsMenu.swift
//  SurvivalCannon
//
//  Created by João Brentano on 13/09/21.
//

import Foundation
import SpriteKit

class SettingsMenu: SKSpriteNode {
    var parentScene: Scenario?
    var sound: Bool
    var music: Bool
    
    init(parentScene: Scenario, sound: Bool, music: Bool) {
        self.sound = sound
        self.music = music
        super.init(texture: nil, color: .white, size: CGSize(width: UIScreen.main.bounds.width * 1, height: UIScreen.main.bounds.height * 1))
        self.parentScene = parentScene
        self.position = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
        
        var y = UIScreen.main.bounds.height * -0.07
        if let musicBool = UserDefaults.standard.value(forKey: "isMusicEnabled") as? Bool {
            self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "MUSIC", value: musicBool, isSound: false, scenario: self.parentScene!))
        }
        else {
            self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "MUSIC", value: true, isSound: false, scenario: self.parentScene!))
        }
        y = UIScreen.main.bounds.height * -0.17
        if let soundBool = UserDefaults.standard.value(forKey: "isSoundEnabled") as? Bool {
            self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "SOUND", value: soundBool, isSound: true, scenario: self.parentScene!))
        }
        else {
            self.addChild(Toggle(parentMenu: self, position: CGPoint(x: 0, y: y), title: "SOUND", value: true, isSound: true, scenario: self.parentScene!))
        }
        y = UIScreen.main.bounds.height * -0.29
        self.addChild(Button(parentMenu: self, position: CGPoint(x: 0, y: y), size: CGSize(width: self.size.width * 0.3, height: self.size.height * 0.04), text: "BACK", action: {
            parentScene.removeAllButMusic()
            parentScene.setBackground()
            parentScene.setMainMenu()
        }))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

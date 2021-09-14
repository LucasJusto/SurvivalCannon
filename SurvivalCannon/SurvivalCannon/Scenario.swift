//
//  Scenario.swift
//  SurvivalCannon
//
//  Created by Lucas Dimer Justo on 10/09/21.
//

import Foundation
import SpriteKit
import CoreMotion

class Scenario: SKScene, SKPhysicsContactDelegate {
    
    let movementManager = CMMotionManager()
    let gyroscopeUpdateRate: Double = 1/1000 //1000 updates per sec
    let cannon: Cannon = Cannon()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        setBackground()
        setMainMenu()
//        setSettings()
//        setGround()
//        setCannon()
    }
    
    func setMainMenu() {
        let mainMenu = MainMenu(parentScene: self)
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.addChild(mainMenu)
    }
    
    func setSettings() {
        //MARK: - TODO: save/restore sound/music booleans
        let settingsMenu = SettingsMenu(parentScene: self, sound: true, music: false)
        settingsMenu.position = CGPoint(x: 0, y: 0)
        settingsMenu.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.addChild(settingsMenu)
    }
    
    func setGround() {
        let ground = SKSpriteNode(color: .black, size: CGSize(width: screenWidth * 2, height: 1))
        ground.position = CGPoint(x: 0, y: -screenHeight/2)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.zPosition = 1
        ground.physicsBody?.contactTestBitMask = ground.physicsBody!.collisionBitMask
        self.addChild(ground)
    }
    
    func setBackground() {
        // Background set-up
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "BG_menu")
        // 9:16 proportion for the size
        background.size = CGSize(width: ((UIScreen.main.bounds.height * 1)/16)*9, height: UIScreen.main.bounds.height * 1)
        background.zPosition = 0
        self.addChild(background)
    }
    
    func setCannon() {
        self.cannon.node.position = CGPoint(x: 0, y: -screenHeight/2 + cannon.node.size.height)
        self.addChild(cannon.node)
        updateGyroscope()
    }
    
    func updateGyroscope() {
        if movementManager.isGyroAvailable {
            movementManager.gyroUpdateInterval = gyroscopeUpdateRate
            movementManager.startGyroUpdates(to: .main) { data, error in
                if let dataNotNull = data {
                    let zAxis = dataNotNull.rotationRate.z
                    //moving right
                    let minZAxisChangeRight = -0.1 //at least -0.5 variation at z axis to move
                    let minZAxisChangeLeft = 0.1 //at least -0.5 variation at z axis to move
                    let pixelsToWalk: CGFloat = 3 //walks 3 pixels at each update
                    if zAxis < minZAxisChangeRight {
                        let nextPositionX = self.cannon.node.position.x + pixelsToWalk
                        if nextPositionX < self.screenWidth/2 && nextPositionX > -self.screenWidth/2{
                            self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                        }
                    }
                    if zAxis > minZAxisChangeLeft {
                        let nextPositionX = self.cannon.node.position.x - pixelsToWalk
                        if nextPositionX < self.screenWidth/2 && nextPositionX > -self.screenWidth/2{
                            self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                        }
                    }
                    
                }
            }
        }
    }
}

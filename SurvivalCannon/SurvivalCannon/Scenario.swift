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
    var lastTime: Double?
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        setBackground()
        setGround()
        setCannon()
        startSpawningEnemies()
    }
    
    func setMainMenu() {
        let mainMenu = MainMenu(parentScene: self)
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.addChild(mainMenu)
    }
    
    func startSpawningEnemies() {
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.spawnEnemy), userInfo: nil, repeats: true)
        //Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.spawnEnemyAnvil), userInfo: nil, repeats: true)
    }
    
// MARK: - create and spawn enemys
    func createBarrel(x: CGFloat) -> SKSpriteNode{
        let barrel = Barrel(nameEnemy: "Barrel", typeEnemy: "barrel", breakable: true)
        barrel.node.position = CGPoint(x: x, y: (self.scene?.size.height)!)
        barrel.node.zPosition = 1
        return barrel.node
    }
    
    @objc func spawnEnemy(){
        let maxRange = (self.scene?.size.width)! / 2.8
        let randomX = CGFloat.random(in: -maxRange...maxRange)
        let moveDown = SKAction.moveTo(y: -(self.frame.size.height / 2), duration: 4)
        var random = Int.random(in: 0...1)
        switch random {
        case 0:
            let barrel = self.createBarrel(x: randomX)
            barrel.run(moveDown) {
                barrel.removeFromParent()
            }
            addChild(barrel)
        case 1:
            let anvil = self.createAnvil(x: randomX)
            anvil.run(moveDown) {
                anvil.removeFromParent()
            }
            addChild(anvil)
        default:
            print("oops")
        }
    }
    
    func createAnvil(x: CGFloat) -> SKSpriteNode{
        let anvil = Anvil(nameEnemy: "Anvil", typeEnemy: "anvil", breakable: false)
        anvil.node.position = CGPoint(x: x, y: (self.scene?.size.height)!)
        anvil.node.zPosition = 1
        return anvil.node
    }
    
//    @objc func spawnEnemyAnvil() {
//        let maxRange = (self.scene?.size.width)! / 2.8
//        let randomX = CGFloat.random(in: -maxRange...maxRange)
//
//        let moveDown = SKAction.moveTo(y: -(self.frame.size.height / 2), duration: 4)
//
//     }
    
    
    func setSettings() {
        //MARK: - TODO: save/restore sound/music booleans
        let settingsMenu = SettingsMenu(parentScene: self, sound: true, music: false)
        settingsMenu.position = CGPoint(x: 0, y: 0)
        settingsMenu.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.addChild(settingsMenu)
    }
    
    func setGround() {
        let ground = SKSpriteNode(color: .black, size: CGSize(width: screenWidth * 2, height: 1))
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.zPosition = -1
        ground.physicsBody?.contactTestBitMask = ground.physicsBody!.collisionBitMask
        ground.alpha = 0
        for child in self.children {
            if child.name == "Rail" {
                ground.position = CGPoint(x: 0, y: 2 - child.frame.size.height/2)
                child.addChild(ground)
            }
        }
    }
    
    func setBackground() {
        // Background set-up
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "BG_menu")
        // 9:16 proportion for the size
        background.size = CGSize(width: ((UIScreen.main.bounds.height * 1)/16)*9, height: UIScreen.main.bounds.height * 1)
        background.zPosition = 0
        let rail: SKSpriteNode = SKSpriteNode(imageNamed: "Rail")
        rail.size = CGSize(width: screenWidth, height: screenWidth * 0.078)
        rail.position = CGPoint(x: 0, y: -screenHeight/2 + rail.size.height)
        rail.zPosition = 1
        rail.name = "Rail"
        self.addChild(rail)
        self.addChild(background)
    }
    
    func setCannon() {
        self.cannon.node.position = CGPoint(x: 0, y: -screenHeight/2 + cannon.node.size.height)
        self.addChild(cannon.node)
        updateDeviceMotion()
    }
    
    func updateDeviceMotion() {
        if movementManager.isDeviceMotionAvailable {
            movementManager.deviceMotionUpdateInterval = gyroscopeUpdateRate
            movementManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: .main) { (data, _) in
                guard let validData = data else { return }
                let zAxisChange = validData.attitude.roll
                let pixelsToWalk: CGFloat = 3
                let minMovementToMoveRight = 0.325// at least 0.325 change at zAxis to move right
                let minMovementToMoveleft = -0.325// at least -0.325 change at zAxis to move left
                //move right
                if zAxisChange > minMovementToMoveRight {
                    let nextPositionX = self.cannon.node.position.x + pixelsToWalk
                    if nextPositionX < self.screenWidth/2 && nextPositionX > -self.screenWidth/2{
                        self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                    }
                }
                if zAxisChange < minMovementToMoveleft {
                    let nextPositionX = self.cannon.node.position.x - pixelsToWalk
                    if nextPositionX < self.screenWidth/2 && nextPositionX > -self.screenWidth/2{
                        self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                    }
                }
            }
        }
    }
    
//    override func update(_ currentTime: CFTimeInterval) {
//        if(lastTime == nil){
//            lastTime = currentTime
//        }
//        else{
//            if((lastTime! - currentTime) >= 1){
//                lastTime = currentTime
//
//            }
//        }
//    }
}

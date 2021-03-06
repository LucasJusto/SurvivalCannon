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
    var cannon: Cannon = Cannon()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var lastTime: Double?
    let mainSound = SKAudioNode(fileNamed: "mainSound")
    var scoreLabel = ScoreLabel()
    var spawnEnemyTimer : Timer?
    var isSoundEnabled: Bool?
    var isMusicEnabled: Bool?
    var isGameOn = false
    let fromSkyToGroundEnemyTimeInitial: Double = 4
    var fromSkyToGroundEnemyTime: Double = 4
    var fromSkyToGroundEnemyTimeMin: Double = 1
    let fromSkyToGroundEnemyTimeDecay: Double = 0.375 //reduced from fromSkyToGroundEnemyTime once every some points achieved
    var spawnEnemyTimeInterval: Double = 2
    var spawnEmeyTimeIntervalInitial: Double = 2
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.physicsWorld.contactDelegate = self
        setBackground()
        setMainMenu()
        if let musicBool = UserDefaults.standard.value(forKey: "isMusicEnabled") as? Bool {
            isMusicEnabled = musicBool
        }
        else {
            isMusicEnabled = true
        }
        if let soundBool = UserDefaults.standard.value(forKey: "isSoundEnabled") as? Bool {
            isSoundEnabled = soundBool
        }
        else {
            isSoundEnabled = true
        }
        if isMusicEnabled! {
            setMusic()
        }
    }
    
    func gameBegin(){
        self.addChild(scoreLabel.node)
        fromSkyToGroundEnemyTime = fromSkyToGroundEnemyTimeInitial
        spawnEnemyTimeInterval = spawnEmeyTimeIntervalInitial
        setBackground()
        setRail()
        setGround()
        setCannon()
        startSpawningEnemies(timeInterval: spawnEnemyTimeInterval)
        isGameOn = true
        self.cannon.node.physicsBody?.isDynamic = true
    }
    
    func removeMusic() {
        for child in self.children {
            if child.name == "mainSound" {
                child.removeFromParent()
                break
            }
        }
    }
    
    func setMusic() {
        mainSound.isPositional = false
        mainSound.autoplayLooped = true
        mainSound.name = "mainSound"
        self.addChild(mainSound)
    }
    
    func setMainMenu() {
        let mainMenu = MainMenu(parentScene: self)
        mainMenu.position = CGPoint(x: 0, y: 0)
        mainMenu.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.addChild(mainMenu)
    }
    
    func startSpawningEnemies(timeInterval: Double) {
        self.spawnEnemyTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(self.spawnEnemy), userInfo: nil, repeats: true)
    }
    
    func stopSpawningEnemies() {
        self.spawnEnemyTimer?.invalidate()
        self.spawnEnemyTimer = nil
    }
    
    // MARK: - create and spawn enemys
    func createBarrel(x: CGFloat) -> SKSpriteNode{
        let barrel = Barrel(nameEnemy: "Barrel", typeEnemy: "barrel", breakable: true)
        barrel.node.position = CGPoint(x: x, y: screenHeight)
        barrel.node.zPosition = 5
        return barrel.node
    }
    
    @objc func spawnEnemy(){
        let maxRange = screenWidth / 2.5
        let randomX = CGFloat.random(in: -maxRange...maxRange)
        let barrelHeight = UIScreen.main.bounds.height * 0.1 * 1.38
        let moveDown = SKAction.moveTo(y: -((self.frame.size.height / 2) + barrelHeight/2), duration: fromSkyToGroundEnemyTime)
        let random = Int.random(in: 0...1)
        switch random {
            case 0:
                let barrel = self.createBarrel(x: randomX)
                barrel.run(moveDown) {
                    barrel.removeFromParent()
                    self.scoreLabel.update(points: 1)
                }
                addChild(barrel)
            case 1:
                let anvil = self.createAnvil(x: randomX)
                anvil.run(moveDown) {
                    anvil.removeFromParent()
                    self.scoreLabel.update(points: 1)
                }
                addChild(anvil)
            default:
                print("oops")
        }
    }
    
    func createAnvil(x: CGFloat) -> SKSpriteNode{
        let anvil = Anvil(nameEnemy: "Anvil", typeEnemy: "anvil", breakable: false)
        anvil.node.position = CGPoint(x: x, y: screenHeight)
        anvil.node.zPosition = 5
        return anvil.node
    }
    
    func removeAllButMusic() {
        for child in self.children {
            if child.name == nil || child.name != mainSound.name {
                child.removeFromParent()
            }
        }
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
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.zPosition = -1
        ground.physicsBody?.contactTestBitMask = ground.physicsBody!.collisionBitMask
        ground.alpha = 0
        for child in self.children {
            if child.name == "Rail" {
                ground.position = CGPoint(x: 0, y: 2 - child.frame.size.height/2)
                child.addChild(ground)
                break
            }
        }
    }
    
    func cannonShot(){
        let cannonBall = CannonBall()
        let cannonPosition = self.cannon.node.position
        cannonBall.position = CGPoint(x: cannonPosition.x, y: cannonPosition.y + self.cannon.node.size.height/2 + cannonBall.size.height/2)
        cannonBall.zPosition = 10
        var impulseAction = SKAction.applyImpulse(CGVector(dx: 0, dy: screenHeight/12), duration: 0.01)
        if screenHeight > 1000 {
            impulseAction = SKAction.applyImpulse(CGVector(dx: 0, dy: screenHeight/3), duration: 0.01)
        }
        cannonBall.run(impulseAction)
        self.addChild(cannonBall)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createAndPlaySound(soundName: "shotSound")
        cannonShot()
    }
    
    func setRail() {
        let rail: SKSpriteNode = SKSpriteNode(imageNamed: "Rail")
        rail.size = CGSize(width: screenWidth, height: screenWidth * 0.078)
        rail.position = CGPoint(x: 0, y: -screenHeight/2 + rail.size.height)
        rail.zPosition = 1
        rail.name = "Rail"
        self.addChild(rail)
    }
    
    func setBackground() {
        // Background set-up
        let background: SKSpriteNode = SKSpriteNode(imageNamed: "BG_menu")
        // 9:16 proportion for the size
        //background.size = CGSize(width: ((UIScreen.main.bounds.height * 1)/16)*9, height: UIScreen.main.bounds.height * 1)
        background.size = CGSize(width: screenWidth, height: screenHeight)
        background.zPosition = 0
        self.addChild(background)
    }
    
    func setCannon() {
        self.cannon = Cannon()
        self.cannon.node.position = CGPoint(x: 0, y: -screenHeight/2 + cannon.node.size.height)
        self.addChild(cannon.node)
        updateDeviceAcceleration()
    }
    
    func updateDeviceAcceleration() {
        if movementManager.isDeviceMotionAvailable {
            movementManager.deviceMotionUpdateInterval = gyroscopeUpdateRate
            movementManager.startAccelerometerUpdates(to: .main) { data, error in
                if self.isGameOn {
                    guard let validData = data else { return }
                    let xAxisAcceleration = validData.acceleration.x
                    var pixelsToWalk: CGFloat = 3.5
                    if self.screenHeight > 1000 {
                        pixelsToWalk = 5.5
                    }
                    let minMovementToMoveRight = 0.125// at least 0.125 acceleration at xAxis to move right
                    let minMovementToMoveleft = -0.125// at least -0.125 acceleration at xAxis to move left
                    //move right
                    if xAxisAcceleration > minMovementToMoveRight {
                        let nextPositionX = self.cannon.node.position.x + pixelsToWalk
                        if nextPositionX < self.screenWidth/2 && nextPositionX > -self.screenWidth/2{
                            self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                        }
                        else if self.cannon.node.position.x > self.screenWidth/2 || self.cannon.node.position.x <= -self.screenWidth/2 {
                            self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                        }
                    }
                    if xAxisAcceleration < minMovementToMoveleft {
                        let nextPositionX = self.cannon.node.position.x - pixelsToWalk
                        if nextPositionX < self.screenWidth/2 && nextPositionX > -self.screenWidth/2{
                            self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                        }
                        else if self.cannon.node.position.x > self.screenWidth/2 || self.cannon.node.position.x < -self.screenWidth/2 {
                            self.cannon.node.position = CGPoint(x: nextPositionX, y: self.cannon.node.position.y)
                        }
                    }
                }
            }
        }
    }
    
    func checkAndRemoveCannonBalls() {
        //it needs to use a copy, otherwise it will produce index out of bounds because of the self.cannonBalls.remove
        let copyOfSelfChildren = self.children.filter { node in
            node.name == "CannonBall"
        }
        
        if copyOfSelfChildren.count > 0 {
            for i in 0...copyOfSelfChildren.count-1 {
                let cannonBall = copyOfSelfChildren[i]
                if cannonBall.position.y > screenHeight/2{
                    cannonBall.removeFromParent()
                }
            }
        }
    }
    
    func createAndPlaySound(soundName: String) {
        if self.isSoundEnabled! {
            let sound = SKAudioNode(fileNamed: soundName)
            sound.isPositional = false
            sound.autoplayLooped = false
            self.addChild(sound)
            sound.run(SKAction.sequence([.play(), .wait(forDuration: 0.5)])){
                sound.removeFromParent()
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //contact between anvil and cannonBall
        if (contact.bodyA.node?.name == "anvil" || contact.bodyB.node?.name == "anvil") && (contact.bodyA.node?.name == "CannonBall" || contact.bodyB.node?.name == "CannonBall") {
            var ball: SKNode? = nil
            if contact.bodyA.node?.name == "CannonBall" {
                ball = contact.bodyA.node
            }
            else {
                ball = contact.bodyB.node
            }
            ball?.removeFromParent()
            self.scoreLabel.update(points: 1)
            createAndPlaySound(soundName: "metalSound")
        }
        //contact between barrel and cannonBall
        else if (contact.bodyA.node?.name == "barrel" || contact.bodyB.node?.name == "barrel") && (contact.bodyA.node?.name == "CannonBall" || contact.bodyB.node?.name == "CannonBall") {
            contact.bodyA.node?.removeFromParent()
            contact.bodyB.node?.removeFromParent()
            createAndPlaySound(soundName: "woodSound")
            scoreLabel.update(points: 2)
        }
        //contact between player and any enemy 
        else if ((contact.bodyA.node?.name == "anvil" || contact.bodyB.node?.name == "anvil") || (contact.bodyA.node?.name == "barrel" || contact.bodyB.node?.name == "barrel")) && (contact.bodyA.node?.name == "Cannon" || contact.bodyB.node?.name == "Cannon") {
            gameOver()
        }
    }
    
    func removeEnemiesActions() {
        for child in self.children {
            if child.name == "barrel" || child.name == "anvil" {
                child.removeAllActions()
            }
        }
    }
    
    func gameOver(){
        self.removeEnemiesActions()
        isGameOn = false
        self.cannon.node.physicsBody?.isDynamic = false
        stopSpawningEnemies()
        GameCenter.storeScore(points: scoreLabel.count)
        let finalScore = FinalScore(scene: self)
        self.addChild(finalScore)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.checkAndRemoveCannonBalls()
    }
}

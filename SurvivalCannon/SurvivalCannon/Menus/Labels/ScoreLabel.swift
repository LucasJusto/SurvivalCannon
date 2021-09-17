//
//  ScoreLabel.swift
//  SurvivalCannon
//
//  Created by Lucca Molon on 14/09/21.
//

import Foundation
import SpriteKit

class ScoreLabel {
    var node: SKLabelNode
    var count: Int
    var enemySpawnIntervalChanges: Int = 2
    var enemyFromSkyToGroundTimeChanges: Int = 6
    
    init() {
        node = SKLabelNode(text: "Score: 0")
        count = 0
        node.fontSize = UIScreen.main.bounds.height * 0.03
        node.fontName = "Copperplate"
        node.fontColor = hexStringToUIColor(hex: "#40200e")
        node.name = "scoreLabel"
        node.position = CGPoint(x: 0, y: UIScreen.main.bounds.height * 0.5 - node.fontSize * 2.5)
        node.zPosition = 10
        enemySpawnIntervalChanges = 2
        enemyFromSkyToGroundTimeChanges = 6
    }
    
    func resetScore() {
        count = 0
        node.text = "Score: \(count)"
        enemySpawnIntervalChanges = 2
        enemyFromSkyToGroundTimeChanges = 6
    }

    func update(points: Int) {
        self.pointSinalizer(points: points)
        count += points
        node.text = "Score: \(count)"

        if let myScene = self.node.parent as? Scenario {
            //checking if we should update enemyFromSkyToGround time
            if count >= 5 && enemyFromSkyToGroundTimeChanges-1 == 5 && myScene.fromSkyToGroundEnemyTime > myScene.fromSkyToGroundEnemyTimeMin {
                enemyFromSkyToGroundTimeChanges -= 1
                myScene.fromSkyToGroundEnemyTime -= myScene.fromSkyToGroundEnemyTimeDecay
            }
            else if count >= 10 && enemyFromSkyToGroundTimeChanges-1 == 4 && myScene.fromSkyToGroundEnemyTime > myScene.fromSkyToGroundEnemyTimeMin {
                enemyFromSkyToGroundTimeChanges -= 1
                myScene.fromSkyToGroundEnemyTime -= myScene.fromSkyToGroundEnemyTimeDecay
            }
            else if count >= 15 && enemyFromSkyToGroundTimeChanges-1 == 3 && myScene.fromSkyToGroundEnemyTime > myScene.fromSkyToGroundEnemyTimeMin {
                enemyFromSkyToGroundTimeChanges -= 1
                myScene.fromSkyToGroundEnemyTime -= myScene.fromSkyToGroundEnemyTimeDecay
            }
            else if count >= 20 && enemyFromSkyToGroundTimeChanges-1 == 2 && myScene.fromSkyToGroundEnemyTime > myScene.fromSkyToGroundEnemyTimeMin {
                enemyFromSkyToGroundTimeChanges -= 1
                myScene.fromSkyToGroundEnemyTime -= myScene.fromSkyToGroundEnemyTimeDecay
            }
            else if count >= 25 && enemyFromSkyToGroundTimeChanges-1 == 1 && myScene.fromSkyToGroundEnemyTime > myScene.fromSkyToGroundEnemyTimeMin {
                enemyFromSkyToGroundTimeChanges -= 1
                myScene.fromSkyToGroundEnemyTime -= myScene.fromSkyToGroundEnemyTimeDecay
            }
            else if count >= 30 && enemyFromSkyToGroundTimeChanges-1 == 0 && myScene.fromSkyToGroundEnemyTime > myScene.fromSkyToGroundEnemyTimeMin {
                enemyFromSkyToGroundTimeChanges -= 1
                myScene.fromSkyToGroundEnemyTime -= myScene.fromSkyToGroundEnemyTimeDecay
            }
            
            //checking if we should update enemySpawnInterval
//            if count >= 50 && enemySpawnIntervalChanges-1 == 1 {
//                enemySpawnIntervalChanges -= 1
//                myScene.stopSpawningEnemies()
//                myScene.spawnEnemyTimeInterval = 1.5
//                myScene.startSpawningEnemies(timeInterval: myScene.spawnEnemyTimeInterval)
//            }
//            else if count >= 200 && enemySpawnIntervalChanges-1 == 0{
//                enemySpawnIntervalChanges -= 1
//                myScene.stopSpawningEnemies()
//                myScene.spawnEnemyTimeInterval = 1
//                myScene.startSpawningEnemies(timeInterval: myScene.spawnEnemyTimeInterval)
//            }
        }
    }
    
    func pointSinalizer(points: Int) {
        let point = SKLabelNode(text: "+\(points)")
        point.fontSize = UIScreen.main.bounds.height * 0.05
        point.fontName = "Copperplate"
        point.fontColor = hexStringToUIColor(hex: "#40200e")
        point.zPosition = 50
        point.position = CGPoint(x: self.node.position.x, y: self.node.position.y - UIScreen.main.bounds.height * 0.1)
        let moveUP = SKAction.moveTo(y: self.node.position.y, duration: 0.5)
        point.run(moveUP) {
            point.removeFromParent()
        }
        self.node.parent!.addChild(point)
    }
    
}


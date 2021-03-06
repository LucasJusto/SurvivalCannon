//
//  GameViewController.swift
//  SurvivalCannon
//
//  Created by Lucas Dimer Justo on 09/09/21.
//

import UIKit
import SpriteKit
import GameplayKit
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameCenter.authenticateUser(view: self) {
            self.image.removeFromSuperview()
            if let view = self.view as! SKView? {
                // Load the SKScene from 'GameScene.sks'
                let scene = Scenario(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
                
                //view.showsFPS = true
                //view.showsNodeCount = true
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

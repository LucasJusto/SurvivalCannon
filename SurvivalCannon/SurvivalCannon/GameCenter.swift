//
//  GameCenter.swift
//  SurvivalCannon
//
//  Created by Lucas Dimer Justo on 13/09/21.
//

import Foundation
import GameKit
import UIKit

public class GameCenter {
    
    static public func authenticateUser(view: UIViewController, completion: @escaping () -> Void) {
        let player = GKLocalPlayer.local
        
        player.authenticateHandler = { viewController, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let gameCenterLoginView = viewController {
                view.present(gameCenterLoginView, animated: true, completion: nil)
            }
            completion()
        }
    }
    
    static public func presentLeaderboard(view: UIViewController & GKGameCenterControllerDelegate) {
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = view
        viewController.viewState = .leaderboards
        viewController.leaderboardIdentifier = "SurvivalCannonPointsLeaderboard"
    
        view.present(viewController, animated: true, completion: nil)
    }
    
    static public func storeScore(points: Int) {
        GKLeaderboard.submitScore(points, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["SurvivalCannonPointsLeaderboard"], completionHandler: { _ in
        })
    }
}

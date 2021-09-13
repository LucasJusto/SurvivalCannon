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
    
}

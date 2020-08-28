//
//  Player.swift
//  MTG Retro Counter
//
//  Created by Desertsoft Mobile Tecnologies on 8/4/19.
//  Copyright © 2019 Desertsoft Mobile Tecnologies. All rights reserved.
//

import UIKit

class Player {
    
    var health: Int = 40 // player healgh
    var name: String = "" // player name
    var poisonCount: Int = 0 // player poison count
    var playerID: Int = 0 // player ID for order purposes
    var playerColor: UIColor // player's color
    
    // holding player data for updating
    lazy var opp_CMD_DMG: [Int] = {
        
        return [
            0,
            0,
            0,
            0,
            0,
            0,
        ]
    }()
    
    init(name: String, input_id: Int, color: UIColor) {
        self.name = name
        self.playerID = input_id
        self.playerColor = color
    }
}

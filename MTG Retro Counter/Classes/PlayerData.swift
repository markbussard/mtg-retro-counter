//
//  PlayerData.swift
//  MTG Retro Counter
//
//  Created by Desertsoft Mobile Tecnologies on 8/4/19.
//  Copyright © 2019 Desertsoft Mobile Tecnologies. All rights reserved.
//


import UIKit

class PlayerData {
    
    var playerData: [Player] = []
    
    init() {
        let player1 = Player(name: "Player1", input_id: 1, color: UIColor(red: 0.15365970463650938, green: 0.3506684369824151, blue: 0.8496376811594202, alpha: 1.0))
        playerData.append(player1)
        
        let player2 = Player(name: "Player2", input_id: 2, color: UIColor(red: 0.6956521739130435, green: 0.1298771609835006, blue: 0.08364775798577809, alpha: 1.0))
        playerData.append(player2)
        
        let player3 = Player(name: "Player3", input_id: 3, color: UIColor(red: 0.04394337454052226, green: 0.7282608695652173, blue: 0.1133708765628283, alpha: 1.0))
        playerData.append(player3)
        
        let player4 = Player(name: "Player4", input_id: 4, color: UIColor(red: 0.923913043478261, green: 0.9030751878289022, blue: 0.18075054562789905, alpha: 1.0))
        playerData.append(player4)
        
        let player5 = Player(name: "Player5", input_id: 5, color: UIColor(red: 0.7137681159420288, green: 0.07169315361625861, blue: 0.6489997110998342, alpha: 1.0))
        playerData.append(player5)
        
        let player6 = Player(name: "Player6", input_id: 6, color: UIColor(red: 1.0, green: 0.5446295627485935, blue: 0.9975023990861424, alpha: 1.0))
        playerData.append(player6)
    }
}

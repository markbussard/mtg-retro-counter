//
//  PlayerTableViewCell.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//
// Class for the regular player table view cell
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerTopButton: UIButton!
    @IBOutlet weak var playerBottomButton: UIButton!
    
    var playerHealth: Int = 40
    
    // initializing view
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // setting the whole cell selection style to none
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        // setting the 8-bit font here
        playerTopButton.titleLabel?.font = UIFont(name: "8BIT WONDER", size: 45)
        playerBottomButton.titleLabel?.font = UIFont(name: "8BIT WONDER", size: 10)
    }
    
    // increase player health
    @IBAction func playerTopButtonPressed(_ sender: Any) {
        playerHealth += 1
        playerTopButton.setTitle(String(playerHealth), for: .normal)
    }
    
    // decrease player health
    @IBAction func playerBottomButtonPressed(_ sender: Any) {
        playerHealth -= 1
        playerTopButton.setTitle(String(playerHealth), for: .normal)
    }
}

//
//  MainPlayerPoisonCounterTableViewCell.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit

class MainPlayerPoisonCounterTableViewCell: UITableViewCell {
    
    // integer value to keep track of poison count
    @IBOutlet weak var playerPoisonCount: UITextField!
    
    // title label
    @IBOutlet weak var poisonCounterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // initialize to 0 to avoid nil issues
        playerPoisonCount.text = "0"
        
        // make cell non selectable, no interaction allowed besides poison counters
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        // setting font of poison counter label
        poisonCounterLabel.font = UIFont(name: "8BIT WONDER", size: 14)
    }
    // decrease player's poison count
    @IBAction func minusButtonPressed(_ sender: Any) {
        // take the text, convert to int and subtract 1, then set the text to new value in string cast
        let poisonNum = integer(from: playerPoisonCount) - 1
        playerPoisonCount.text = String(poisonNum)
    }
    // increase player's poison count
    @IBAction func plusButtonPressed(_ sender: Any) {
        // take the text, convert to int and add 1, then set the text to new value in string cast
        let poisonNum = integer(from: playerPoisonCount) + 1
        playerPoisonCount.text = String(poisonNum)
    }
    // function for converting text to an int
    func integer(from textField: UITextField) -> Int {
        guard let text = textField.text, let number = Int(text) else {
            return 0
        }
        return number
    }
}

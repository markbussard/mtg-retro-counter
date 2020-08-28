//
//  CommanderDamageTableViewCell.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//
// Cell and class for the player poison counter

import UIKit


class CommanderDamageTableViewCell: UITableViewCell {

    // player name
    @IBOutlet weak var playerNameLabel: UILabel!
    
    // damage to their opponent
    @IBOutlet weak var playerPoisonCount: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
        // initialize text to 0 when view is loaded to avoid nil issues
        playerPoisonCount.text = "0"
        playerNameLabel.font = UIFont(name: "8BIT WONDER", size: 15)
    }
    // function for converting text to int
    func integer(from textField: UITextField) -> Int {
        guard let text = textField.text, let number = Int(text) else {
            return 0
        }
        return number
    }
    
    // decrease player's poison counter
    @IBAction func minusButtonPressed(_ sender: Any) {
        // take the text, convert to int and subtract 1, then set the text to new value in string cast
        let poisonNum = integer(from: playerPoisonCount) - 1
        playerPoisonCount.text = String(poisonNum)
    }
    // increase player's poison counter
    @IBAction func plusButtonPressed(_ sender: Any) {
        let poisonNum = integer(from: playerPoisonCount) + 1
        playerPoisonCount.text = String(poisonNum)
    }
}

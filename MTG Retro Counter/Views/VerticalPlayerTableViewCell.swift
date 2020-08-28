//
//  VerticalPlayerTableViewCell.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//
// Class for vertical player table view cell
import UIKit

class VerticalPlayerTableViewCell: UITableViewCell {

    // player name
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var playerBottomButton: UIButton!
    @IBOutlet weak var playerTopButton: UIButton!
    
    // player health
    var playerHealth: Int = 40
    
    // initialize view
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // making the cell itself unselectable
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        // setting the 8-bit font
        playerTopButton.titleLabel?.font = UIFont(name: "8BIT WONDER", size: 45)
        playerNameLabel.font = UIFont(name: "8BIT WONDER", size: 10)
        
        // rotate player name label 90 degrees to the right
        playerNameLabel.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        
        // rotate top button title text 90 degrees to the right
        playerTopButton.titleLabel?.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        
        // input custom padding
        playerTopButton.titleEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    }
    
    @IBAction func playerBottomButtonPressed(_ sender: Any) {
        playerHealth -= 1
        playerTopButton.setTitle(String(playerHealth), for: .normal)
    }
    
    @IBAction func playerTopButtonPressed(_ sender: Any) {
        playerHealth += 1
        playerTopButton.setTitle(String(playerHealth), for: .normal)
    }
}

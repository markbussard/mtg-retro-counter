//
//  ChangeColorTableViewCell.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit

// setting up delegate to pass color that the player picks to player menu vc
protocol ChangeColorTableViewCellDelegate
{
    func changeColor(_ sender: UIButton)
    func textFieldDidEndEditing(cell: ChangeColorTableViewCell, value: String) -> ()
}

class ChangeColorTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var changeColorButton: UIButton!
    @IBOutlet weak var playerName: UITextField!
    var playerColor: UIColor!
    
    var delegate: ChangeColorTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCell.SelectionStyle.none
        
        // setting font of the player name
        playerName.font = UIFont(name: "8BIT WONDER", size: 24)
        
        // passing the new name that the player entered to player menu vc
        playerName.delegate = self
        playerName.returnKeyType = .done // changing "Return" to "Done" on the keyboars
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.textFieldDidEndEditing(cell: self, value: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // lets player menu videw controller know that it's time to change a color
    @IBAction func changeColorButtonPressed(_ sender: UIButton) {
        delegate?.changeColor(changeColorButton)
    }
}

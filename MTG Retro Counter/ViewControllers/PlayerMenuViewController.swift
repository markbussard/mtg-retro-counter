//
//  PlayerMenuViewController.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit
import EFColorPicker

protocol PlayerMenuViewControllerDelegate
{
    func passData(data: [Player])
}

class PlayerMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, EFColorSelectionViewControllerDelegate, ChangeColorTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: PlayerMenuViewControllerDelegate? // delegate for passing data back to view controllers
    
    // player data being passed from and back to view controller
    var playerData: [Player] = []
    
    var changeColorCell = ChangeColorTableViewCell() // going to be used to store data
    var mainPoisonCounterCell = MainPlayerPoisonCounterTableViewCell() // used to store data
    var commanderDamageCells: [CommanderDamageTableViewCell] = [] // array to store data of opponent damage
    
    var currentPlayer: Int = 1 // tracks the current player
    var numPlayers: Int = 2 // number of players, default starts at 2
    var currentIndex: Int = 1 // index starting at second player in array
    var isStandard: Bool = false
    
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide the navigatiopn bar to force user to press done and update data
        self.navigationController?.isNavigationBarHidden = true
        
        // setup playerData that was passed
        initialize()
        
        tableView.register(UINib(nibName: "ChangeColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ChangeColorTableViewCell")
        tableView.register(UINib(nibName: "MainPlayerPoisonCounterTableViewCell", bundle: nil), forCellReuseIdentifier: "MainPlayerPoisonCounterTableViewCell")
        tableView.register(UINib(nibName: "CommanderDamageTableViewCell", bundle: nil), forCellReuseIdentifier: "CommanderDamageTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }
    
    // hide navigation bar to force player to use the done button
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //self.tableView.reloadData()
    }
    
    // height per row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Double(tableView.frame.height / 8))
    }
    
    // estimate row height - necessary
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // number of rows - 8 total sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    // creating cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // change color cell for current player
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeColorTableViewCell") as! ChangeColorTableViewCell
            cell.backgroundColor = playerData[0].playerColor
            cell.playerName.text = playerData[0].name
            changeColorCell = cell
            cell.delegate = self
            
            return cell
        }
        // Current player poison counter cell
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlayerPoisonCounterTableViewCell") as! MainPlayerPoisonCounterTableViewCell
            cell.playerPoisonCount.text = String(playerData[0].opp_CMD_DMG[0])
            cell.backgroundColor = playerData[0].playerColor
            mainPoisonCounterCell = cell
    
            return cell
        }
        // Commander Damage cells
        while currentIndex < numPlayers && isStandard == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommanderDamageTableViewCell") as! CommanderDamageTableViewCell
            cell.backgroundColor = playerData[0].playerColor
            cell.playerNameLabel.text = playerData[currentIndex].name
            cell.playerPoisonCount.text = String(playerData[0].opp_CMD_DMG[currentIndex])
            commanderDamageCells.append(cell)
            currentIndex += 1
        
            return cell
        }
        // blank cells for the rest of the spaces
        let cell = UITableViewCell()
        cell.backgroundColor = playerData[0].playerColor
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell
    }
    
    // Handles passing data back to proper view controller
    // and going to previous view controller by popping
    @IBAction func doneButtonPressed(_ sender: Any) {
        // update current player poison counter
        playerData[0].opp_CMD_DMG[0] = Int(mainPoisonCounterCell.playerPoisonCount.text!)!
        // starting at index of 1 for this current player's opponent's damage values
        var index: Int = 1
        for cell in commanderDamageCells {
            playerData[0].opp_CMD_DMG[index] = Int(cell.playerPoisonCount.text!)!
            index += 1
        }
        
        // sort current player into proper slot
        for _ in 0..<playerData.count {
            for j in 1..<playerData.count {
                if playerData[j].playerID < playerData[j-1].playerID {
                    let temp = playerData[j-1]
                    playerData[j-1] = playerData[j]
                    playerData[j] = temp
                }
            }
        }
        // passing data back
        delegate?.passData(data: playerData)
        
        // resetting values for next time
        currentIndex = 1
        
        // navigates back to previous view controller
        self.navigationController?.popViewController(animated: true)
    }
    
    // setup playerData order
    func initialize() {
        // Move current player to first index in array
        let temp = playerData[0]
        playerData[0] = playerData[currentPlayer-1]
        playerData[currentPlayer-1] = temp
        
        // starting with the second value, sort the values in order
        for _ in 1..<playerData.count {
            for k in 2..<playerData.count {
                if playerData[k].playerID < playerData[k-1].playerID {
                    let temp = playerData[k-1]
                    playerData[k-1] = playerData[k]
                    playerData[k] = temp
                }
            }
        }
    }
    // returns color that current player chose and set their playerColor to it
    func colorViewController(_ colorViewCntroller: EFColorSelectionViewController, didChangeColor color: UIColor) {
        playerData[0].playerColor = color
        currentIndex = 1
        commanderDamageCells.removeAll()
        self.tableView.reloadData()
    }
    // returns new name that current player entered
    func textFieldDidEndEditing(cell: ChangeColorTableViewCell, value: String) {
        playerData[0].name = value
        currentIndex = 1
        commanderDamageCells.removeAll()
        self.tableView.reloadData()
    }
    // handle color change popup here
    func changeColor(_  sender: UIButton) {
        // create color sleection controller
        let colorSelectionController = EFColorSelectionViewController()
        // create navigation controller with its root view as the color selection controller
        let navCtrl = UINavigationController(rootViewController: colorSelectionController)
        
        navCtrl.navigationBar.backgroundColor = UIColor.white
        navCtrl.navigationBar.isTranslucent = false
        navCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        navCtrl.popoverPresentationController?.delegate = self
        navCtrl.popoverPresentationController?.sourceView = self.view
        navCtrl.popoverPresentationController?.sourceRect = sender.bounds
        navCtrl.preferredContentSize = colorSelectionController.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
        
        colorSelectionController.delegate = self
        colorSelectionController.color = self.view.backgroundColor ?? UIColor.white
        colorSelectionController.setMode(mode: EFColorSelectionMode.all)
        
        if UIUserInterfaceSizeClass.compact == self.traitCollection.horizontalSizeClass {
            let doneBtn: UIBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString("Done", comment: ""),
                style: UIBarButtonItem.Style.done,
                target: self,
                action: #selector(ef_dismissViewController(sender:))
            )
            colorSelectionController.navigationItem.rightBarButtonItem = doneBtn
        }
        self.present(navCtrl, animated: true, completion: nil)
    }
    // dismisses the color selection view controller when player has hit "Done"
    @objc func ef_dismissViewController(sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

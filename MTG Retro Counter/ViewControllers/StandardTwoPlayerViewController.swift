//
//  StandardTwoPlayerViewController.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit

class StandardTwoPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlayerMenuViewControllerDelegate {
    
    @IBOutlet weak var topTableView: UITableView!
    @IBOutlet weak var bottomTableView: UITableView!
    
    // holding player data for updating
    lazy var playerData: [Player] = {
        
        let data = PlayerData()
        
        return [
            data.playerData[0],
            data.playerData[1]
        ]
    }()
    
    var cellsArray: [PlayerTableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hiding default back button and replacing it with new button with a selector action
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // player 1
        topTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        topTableView.dataSource = self
        topTableView.delegate = self
        topTableView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        //player 2
        bottomTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        bottomTableView.dataSource = self
        bottomTableView.delegate = self
    }
    // when transition is being made from two player vc to the player menu vc,
    // transfer necessary data for proper loading of current player information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        playerData[0].health = cellsArray[1].playerHealth
        playerData[1].health = cellsArray[0].playerHealth
        
        cellsArray.removeAll()
        
        // player 1
        if segue.identifier  == "PlayerOneSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 1
            vc.numPlayers = 2
            vc.playerData = playerData
            vc.isStandard = true
        }
        // player 2
        else if segue.identifier == "PlayerTwoSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 2
            vc.numPlayers = 2
            vc.playerData = playerData
            vc.isStandard = true
        }
    }
    
    
    // sets the navigation controller back to showing if transitioning back from player menu vc
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topTableView.reloadData()
        bottomTableView.reloadData()
        
        self.navigationController?.isNavigationBarHidden = false
    }
    // shake motion to reset game
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        // alert controller
        let alertController = UIAlertController(title: "Are you sure you want to reset the game?", message: "Names and colors will not be reset", preferredStyle: .alert)
        
        // button to reset the game
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default) { (result: UIAlertAction) -> Void in
            let data = PlayerData()
            
            // resetting all the oppponents damage for each player
            self.playerData[0].opp_CMD_DMG = data.playerData[0].opp_CMD_DMG
            self.playerData[1].opp_CMD_DMG = data.playerData[0].opp_CMD_DMG
            
            // resetting all of the players health back to 40
            self.playerData[0].health = 40
            self.playerData[1].health = 40
            
            // reload tables
            self.topTableView.reloadData()
            self.bottomTableView.reloadData()
        }
        // button to cancel
        let stayAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (result: UIAlertAction) -> Void in
        }
        // add actions to alert controller
        alertController.addAction(resetAction)
        alertController.addAction(stayAction)
        // present the alert controller to screen
        self.present(alertController, animated: true)
    }
    
    // handles height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return topTableView.frame.height
    }
    // estimated height for rows
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //  number of rows for tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // creating cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // player 1 cell
        if tableView == topTableView {
            let cell = self.topTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            // player health
            cell.playerHealth = playerData[0].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[0].playerColor
            cell.playerTopButton.setTitle(String(playerData[0].health), for: .normal)
            
            // player bottom button setup[
            cell.playerBottomButton.backgroundColor = playerData[0].playerColor
            cell.playerBottomButton.setTitle(playerData[0].name, for: .normal)
            
            cellsArray.append(cell)
            
            return cell
        }
        // player 2 cell
        let cell = self.bottomTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
        // player health
        cell.playerHealth = playerData[1].health
        
        // player top button setup
        cell.playerTopButton.backgroundColor = playerData[1].playerColor
        cell.playerTopButton.setTitle(String(playerData[1].health), for: .normal)
        
        // player bottom button setup[
        cell.playerBottomButton.backgroundColor = playerData[1].playerColor
        cell.playerBottomButton.setTitle(playerData[1].name, for: .normal)
        
        cellsArray.append(cell)
        
        return cell
    }
    
    // receiving data from player menu view controller through here
    func passData(data: [Player]) {
        playerData = data
    }
    
    // alert action to ask if player really wants to leave the game
    @objc func goBack(_ sender: UIBarButtonItem) {
        // alert controller
        let alertController = UIAlertController(title: "Are you sure you want to leave the game?", message: "All data will be lost", preferredStyle: .alert)
        // action to stay in current game
        let stayAction = UIAlertAction(title: "Stay", style: UIAlertAction.Style.default) { (result: UIAlertAction) -> Void in
        }
        // action to go back
        let goBackAction = UIAlertAction(title: "Go Back", style: UIAlertAction.Style.default) { (result: UIAlertAction) -> Void in
            self.navigationController?.popViewController(animated: true)
        }
        // add actions to alert controller
        alertController.addAction(stayAction)
        alertController.addAction(goBackAction)
        
        // present the alert controller to screen
        self.present(alertController, animated: true)
    }
}

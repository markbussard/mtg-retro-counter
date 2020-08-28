//
//  SixPlayerViewController.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit

class SixPlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var top_leftTableView: UITableView!
    @IBOutlet weak var top_rightTableView: UITableView!
    
    @IBOutlet weak var middle_leftTableView: UITableView!
    @IBOutlet weak var middle_rightTableView: UITableView!
    
    @IBOutlet weak var bottom_leftTableView: UITableView!
    @IBOutlet weak var bottom_rightTableView: UITableView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    // holding player data for updating
    lazy var playerData: [Player] = {
        
        let data = PlayerData()
        
        return [
            data.playerData[0],
            data.playerData[1],
            data.playerData[2],
            data.playerData[3],
            data.playerData[4],
            data.playerData[5]
        ]
    }()
    
    var cellsArray: [VerticalPlayerTableViewCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hiding default back button and replacing it with new button with a selector action
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // top left - player 1
        self.top_leftTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.top_leftTableView.dataSource = self
        self.top_leftTableView.delegate = self
    
        // top left - player 2
        self.top_rightTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.top_rightTableView.dataSource = self
        self.top_rightTableView.delegate = self
        self.top_rightTableView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // middle left - player 3
        self.middle_leftTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.middle_leftTableView.dataSource = self
        self.middle_leftTableView.delegate = self
        
        // middle right - player 4
        self.middle_rightTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.middle_rightTableView.dataSource = self
        self.middle_rightTableView.delegate = self
        self.middle_rightTableView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // bottom left - player 5
        self.bottom_leftTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.bottom_leftTableView.dataSource = self
        self.bottom_leftTableView.delegate = self
        
        // bottom right - player 6
        self.bottom_rightTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.bottom_rightTableView.dataSource = self
        self.bottom_rightTableView.delegate = self
        self.bottom_rightTableView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    // when transition is being made from four player vc to the player menu vc,
    // transfer necessary data for proper loading of current player information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        playerData[0].health = cellsArray[5].playerHealth
        playerData[1].health = cellsArray[4].playerHealth
        playerData[2].health = cellsArray[3].playerHealth
        playerData[3].health = cellsArray[2].playerHealth
        playerData[4].health = cellsArray[1].playerHealth
        playerData[5].health = cellsArray[0].playerHealth
        
        cellsArray.removeAll()
        
        // player 1
        if segue.identifier  == "PlayerOneSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 1
            vc.numPlayers = 6
            vc.playerData = playerData
        }
        // player 2
        else if segue.identifier == "PlayerTwoSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 2
            vc.numPlayers = 6
            vc.playerData = playerData
        }
        // player 3
        else if segue.identifier == "PlayerThreeSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 3
            vc.numPlayers = 6
            vc.playerData = playerData
        }
        // player 4
        else if segue.identifier == "PlayerFourSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 4
            vc.numPlayers = 6
            vc.playerData = playerData
        }
        // player 5
        else if segue.identifier == "PlayerFiveSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 5
            vc.numPlayers = 6
            vc.playerData = playerData
        }
        // player 6
        else if segue.identifier == "PlayerSixSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 6
            vc.numPlayers = 6
            vc.playerData = playerData
        }
    }
    
    // reload data and cells when returning from player menu
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        top_leftTableView.reloadData()
        top_rightTableView.reloadData()
        middle_leftTableView.reloadData()
        middle_rightTableView.reloadData()
        bottom_leftTableView.reloadData()
        bottom_rightTableView.reloadData()
        
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
            self.playerData[2].opp_CMD_DMG = data.playerData[0].opp_CMD_DMG
            self.playerData[3].opp_CMD_DMG = data.playerData[0].opp_CMD_DMG
            self.playerData[4].opp_CMD_DMG = data.playerData[0].opp_CMD_DMG
            self.playerData[5].opp_CMD_DMG = data.playerData[0].opp_CMD_DMG

            // resetting all of the players health back to 40
            self.playerData[0].health = 40
            self.playerData[1].health = 40
            self.playerData[2].health = 40
            self.playerData[3].health = 40
            self.playerData[4].health = 40
            self.playerData[5].health = 40
            
            // reload tables
            self.top_leftTableView.reloadData()
            self.top_rightTableView.reloadData()
            self.middle_leftTableView.reloadData()
            self.middle_rightTableView.reloadData()
            self.bottom_leftTableView.reloadData()
            self.bottom_rightTableView.reloadData()
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

    // height for row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(stackView.frame.height)
    }
    
    // estimated row height - necessary
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //  number of rows for tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // cells being created for their correlated tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // player 1 cell
        if tableView == top_leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
            // player health
            cell.playerHealth = playerData[0].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[0].playerColor
            cell.playerTopButton.setTitle(String(playerData[0].health), for: .normal)
            
            // player bottom button setup
            cell.playerBottomButton.backgroundColor = playerData[0].playerColor
            cell.playerNameLabel.text = playerData[0].name
            
            cellsArray.append(cell)
            
            return cell
        }
        // player 2 cell
        if tableView == top_rightTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
            // player health
            cell.playerHealth = playerData[1].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[1].playerColor
            cell.playerTopButton.setTitle(String(playerData[1].health), for: .normal)
            
            // player bottom button setup
            cell.playerBottomButton.backgroundColor = playerData[1].playerColor
            cell.playerNameLabel.text = playerData[1].name
            
            cellsArray.append(cell)

            return cell
        }
        
        // player 3 cell
        if tableView == middle_leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
            // player health
            cell.playerHealth = playerData[2].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[2].playerColor
            cell.playerTopButton.setTitle(String(playerData[2].health), for: .normal)
            
            // player bottom button setup
            cell.playerBottomButton.backgroundColor = playerData[2].playerColor
            cell.playerNameLabel.text = playerData[2].name
            
            cellsArray.append(cell)
            
            return cell
        }
    
        // player 4  cell
        if tableView == middle_rightTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
            // player health
            cell.playerHealth = playerData[3].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[3].playerColor
            cell.playerTopButton.setTitle(String(playerData[3].health), for: .normal)
            
            // player bottom button setup
            cell.playerBottomButton.backgroundColor = playerData[3].playerColor
            cell.playerNameLabel.text = playerData[3].name
            
            cellsArray.append(cell)
            
            return cell
        }
        
        // player 5 cell
        if tableView == bottom_leftTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
            // player health
            cell.playerHealth = playerData[4].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[4].playerColor
            cell.playerTopButton.setTitle(String(playerData[4].health), for: .normal)
            
            // player bottom button setup
            cell.playerBottomButton.backgroundColor = playerData[4].playerColor
            cell.playerNameLabel.text = playerData[4].name
            
            cellsArray.append(cell)
            
            return cell
        }
        
        // player 6 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
        // player health
        cell.playerHealth = playerData[5].health
        
        // player top button setup
        cell.playerTopButton.backgroundColor = playerData[5].playerColor
        cell.playerTopButton.setTitle(String(playerData[5].health), for: .normal)
        
        // player bottom button setup
        cell.playerBottomButton.backgroundColor = playerData[5].playerColor
        cell.playerNameLabel.text = playerData[5].name
        
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

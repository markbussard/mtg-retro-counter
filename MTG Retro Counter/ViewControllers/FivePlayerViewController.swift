//
//  FivePlayerViewController.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit

class FivePlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topTableView: UITableView!
    
    @IBOutlet weak var bottom_topLeftTableView: UITableView!
    @IBOutlet weak var bottom_topRightTableView: UITableView!
    
    @IBOutlet weak var bottom_bottomLeftTableView: UITableView!
    @IBOutlet weak var bottom_bottomRightTableView: UITableView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    // holding player data for updating
    lazy var playerData: [Player] = {
        
        let data = PlayerData()
        
        return [
            data.playerData[0],
            data.playerData[1],
            data.playerData[2],
            data.playerData[3],
            data.playerData[4]
        ]
    }()
    
    var playerTableViewCell = PlayerTableViewCell()
    
    var cellsArray: [VerticalPlayerTableViewCell] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hiding default back button and replacing it with new button with a selector action
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        // top left - player 1
        self.topTableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        self.topTableView.dataSource = self
        self.topTableView.delegate = self
        self.topTableView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // top left - player 2
        self.bottom_topLeftTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.bottom_topLeftTableView.dataSource = self
        self.bottom_topLeftTableView.delegate = self
        
        // middle left - player 3
        self.bottom_topRightTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.bottom_topRightTableView.dataSource = self
        self.bottom_topRightTableView.delegate = self
        self.bottom_topRightTableView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // middle right - player 4
        self.bottom_bottomLeftTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.bottom_bottomLeftTableView.dataSource = self
        self.bottom_bottomLeftTableView.delegate = self
        
        // bottom left - player 5
        self.bottom_bottomRightTableView.register(UINib(nibName: "VerticalPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "VerticalPlayerTableViewCell")
        self.bottom_bottomRightTableView.dataSource = self
        self.bottom_bottomRightTableView.delegate = self
        self.bottom_bottomRightTableView?.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    // when transition is being made from four player vc to the player menu vc,
    // transfer necessary data for proper loading of current player information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        playerData[0].health = playerTableViewCell.playerHealth
        playerData[1].health = cellsArray[3].playerHealth
        playerData[2].health = cellsArray[2].playerHealth
        playerData[3].health = cellsArray[1].playerHealth
        playerData[4].health = cellsArray[0].playerHealth
        
        cellsArray.removeAll()
        // player 1
        if segue.identifier  == "PlayerOneSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 1
            vc.numPlayers = 5
            vc.playerData = playerData
        }
        // player 2
        else if segue.identifier == "PlayerTwoSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 2
            vc.numPlayers = 5
            vc.playerData = playerData
        }
        // player 3
        else if segue.identifier == "PlayerThreeSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 3
            vc.numPlayers = 5
            vc.playerData = playerData
        }
        // player 4
        else if segue.identifier == "PlayerFourSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 4
            vc.numPlayers = 5
            vc.playerData = playerData
        }
        // player 5
        else if segue.identifier == "PlayerFiveSegue" {
            let vc = segue.destination as! PlayerMenuViewController
            vc.currentPlayer = 5
            vc.numPlayers = 5
            vc.playerData = playerData
        }
    }
    
    // reload data and cells when returning from player menu
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topTableView.reloadData()
        bottom_topLeftTableView.reloadData()
        bottom_topRightTableView.reloadData()
        bottom_bottomLeftTableView.reloadData()
        bottom_bottomRightTableView.reloadData()
        
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
            
            // resetting all of the players health back to 40
            self.playerData[0].health = 40
            self.playerData[1].health = 40
            self.playerData[2].health = 40
            self.playerData[3].health = 40
            self.playerData[4].health = 40
           
            // reload tables
            self.topTableView.reloadData()
            self.bottom_topLeftTableView.reloadData()
            self.bottom_topRightTableView.reloadData()
            self.bottom_bottomLeftTableView.reloadData()
            self.bottom_bottomRightTableView.reloadData()
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

    // height per row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == topTableView {
            return CGFloat(topTableView.frame.height)
        }
        return CGFloat(stackView.frame.height)
    }
    
    // estimate row height - necessary
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
        if tableView == topTableView {
            let cell = self.topTableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            // player health
            cell.playerHealth = playerData[0].health
            
            // player top button setup
            cell.playerTopButton.backgroundColor = playerData[0].playerColor
            cell.playerTopButton.setTitle(String(playerData[0].health), for: .normal)
            
            // player bottom button setup
            cell.playerBottomButton.backgroundColor = playerData[0].playerColor
            cell.playerBottomButton.setTitle(playerData[0].name, for: .normal)
            
            playerTableViewCell = cell

            return cell
        }
        
        // player 2 cell
        if tableView == bottom_topLeftTableView {
            let cell = self.bottom_topLeftTableView.dequeueReusableCell(withIdentifier: "VerticalPlayerTableViewCell", for: indexPath) as! VerticalPlayerTableViewCell
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
        if tableView == bottom_topRightTableView {
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
        if tableView == bottom_bottomLeftTableView {
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

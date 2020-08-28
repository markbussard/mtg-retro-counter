//
//  HomeViewController.swift
//  MTG Retro Counter
//
//  Created by Mark Bussard on 8/4/19.
//  Copyright © 2019 Mark Bussard. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-4750260819662550/2397986959"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        //bannerView.center = CGPoint(x: imageView.frame.width / 2, y: imageView.frame.height / 2)
        imageView.autoresizesSubviews = true
        imageView.addSubview(bannerView)

        // popup to let user know the basic controls of the game
        let alertController = UIAlertController(title: "Thank you for using our app!\n", message: "To change a player’s life total, tap the upper half of the player box to increase life and lower half to decrease life\n\n" +
            "To change player name, keep track of poison counters or commander damage, or to change player’s color, press the icon on the top right of the player box\n\n" +
            "To reset the game, gently shake the phone from side to side. (GENTLY!)\n\n" +
            "Enjoy!", preferredStyle: .alert)
        
        // got it button
        let okAction = UIAlertAction(title: "Got it!", style: UIAlertAction.Style.default) { (result: UIAlertAction) -> Void in
        }
        // add action to alert controller
        alertController.addAction(okAction)
    
        // present the alert controller to screen
        self.present(alertController, animated: true)
    }
    // tcg store button link
    @IBAction func tcgPlayerButtonPressed(_ sender: Any) {
        if let url = NSURL(string: "https://shop.tcgplayer.com/all/product/show?sellerfilter=465a08c4&newSearch=false&orientation=list") {
            UIApplication.shared.open(url as URL)
        }
    }
    // facebook tappedoutgaming button link
    @IBAction func facebookButtonPressed(_ sender: Any) {
        if let url = NSURL(string: "https://www.facebook.com/tappedoutgaming/") {
            UIApplication.shared.open(url as URL)
        }
    }
    // company about us button link
    @IBAction func aboutUsPressed(_ sender: Any) {
        
    }
}


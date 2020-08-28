//
//  P1StandardFragment.swift
//  MTG Retro Counter
//
//  Created by Desertsoft Mobile Tecnologies on 8/5/19.
//  Copyright © 2019 Desertsoft Mobile Tecnologies. All rights reserved.
//

import UIKit

class P1StandardFragment: UIViewController {

    var p1life = 20
    @IBOutlet weak var p1LifeText: UITextView!
    @IBOutlet weak var p1NameText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func p1PlusBtn(_ sender: Any)
    {
        p1life+=1
        p1LifeText.text = String(p1life)
    }
    @IBAction func p1MinusBtn(_ sender: Any)
    {
        p1life-=1
        p1LifeText.text = String(p1life)
    }
    

}

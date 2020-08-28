//
//  P2StandardFragment.swift
//  MTG Retro Counter
//
//  Created by Desertsoft Mobile Tecnologies on 8/5/19.
//  Copyright © 2019 Desertsoft Mobile Tecnologies. All rights reserved.
//

import UIKit

class P2StandardFragment: UIViewController
{
    var p2life = 20
    @IBOutlet weak var p2LifeText: UITextView!
    @IBOutlet weak var p2NameText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func p2SPlusBtn(_ sender: Any)
    {
        p2life+=1
        p2LifeText.text = String(p2life)
    }
    
    @IBAction func P2SMinusBtn(_ sender: Any)
    {
        p2life-=1
        p2LifeText.text = String(p2life)
    }
    
}

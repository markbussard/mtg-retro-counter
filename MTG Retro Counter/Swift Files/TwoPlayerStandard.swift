//
//  TwoPlayerStandard.swift
//  MTG Retro Counter
//
//  Created by Desertsoft Mobile Tecnologies on 8/5/19.
//  Copyright © 2019 Desertsoft Mobile Tecnologies. All rights reserved.
//

import UIKit

class TwoPlayerStandard: UIViewController
{
    @IBOutlet weak var TPS_P2Container: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TPS_P2Container.transform = CGAffineTransform.init(rotationAngle: 3.14)
    }
    
   
    @IBAction func TPS_BackBtn(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
}

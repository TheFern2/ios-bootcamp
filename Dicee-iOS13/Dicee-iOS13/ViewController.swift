//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // IBOutlet allows me to reference a UI element
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        diceImageView1.image = UIImage(imageLiteralResourceName: getRandomImageString())
        diceImageView2.image = UIImage(imageLiteralResourceName: getRandomImageString())
    }
    
    func getRandomImageString() -> String {
        let dice = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
        let randomNumber = Int.random(in: 0...5)
        return dice[randomNumber]
    }
    
}


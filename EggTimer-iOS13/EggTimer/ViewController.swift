//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet weak var counterView: UIProgressView!
    @IBOutlet weak var eggLabel: UILabel!
    var eggTimes: [String: Int] = ["Soft": 300, "Medium": 480, "Hard": 720]
    var counter: Int = 0
    var originalCounter: Int = 0
    var timer: Timer?
    
    @objc func updateCounter() {
        if counter < originalCounter {
            counter += 1
            let percentage = Float(counter) / Float(originalCounter)
            print("\(counter) seconds. Progress: \(percentage)")
            counterView.progress = percentage
            
        } else {
            timer?.invalidate()
            timer = nil
            print("Time's up!")
            eggLabel.text = "Done"
        }
    }
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        if timer != nil {
            print("Timer is already running. Please wait until it finishes.")
            return
        }
        
        let hardness = sender.currentTitle!
        
        counterView.progress = 0
        counter = 0
        eggLabel.text = hardness
        
        if let value = eggTimes[hardness] {
            print("The value for '\(hardness)' is \(value).")
//            counter = value
            originalCounter = value // Store the original counter value
            timer?.invalidate() // Invalidate any existing timer
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        } else {
            print("The key '\(hardness)' does not exist.")
        }
    }
    

}

//
//  ViewController.swift
//  SungerBobGame
//
//  Created by Beyza Aydoğar on 13/08/2017.
//  Copyright © 2017 Beyza Aydogar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    @IBOutlet weak var sunger1: UIImageView!
    @IBOutlet weak var sunger2: UIImageView!
    @IBOutlet weak var sunger3: UIImageView!
    @IBOutlet weak var sunger4: UIImageView!
    @IBOutlet weak var sunger5: UIImageView!
    @IBOutlet weak var sunger6: UIImageView!
    @IBOutlet weak var sunger7: UIImageView!
    @IBOutlet weak var sunger8: UIImageView!
    @IBOutlet weak var sunger9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var sungerArray = [UIImageView]()
    var hideTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil{
            highScoreLabel.text = "0"
        }
        if let newScore = highScore as? Int {
            highScoreLabel.text = String(newScore)
            
        }
        
        scoreLabel.text = "Score: \(score)"
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.inreaseScore))
        
        sunger1.isUserInteractionEnabled = true
        sunger2.isUserInteractionEnabled = true
        sunger3.isUserInteractionEnabled = true
        sunger4.isUserInteractionEnabled = true
        sunger5.isUserInteractionEnabled = true
        sunger6.isUserInteractionEnabled = true
        sunger7.isUserInteractionEnabled = true
        sunger8.isUserInteractionEnabled = true
        sunger9.isUserInteractionEnabled = true
        
        sunger1.addGestureRecognizer(recognizer1)
        sunger2.addGestureRecognizer(recognizer2)
        sunger3.addGestureRecognizer(recognizer3)
        sunger4.addGestureRecognizer(recognizer4)
        sunger5.addGestureRecognizer(recognizer5)
        sunger6.addGestureRecognizer(recognizer6)
        sunger7.addGestureRecognizer(recognizer7)
        sunger8.addGestureRecognizer(recognizer8)
        sunger9.addGestureRecognizer(recognizer9)
        
        //timers
        counter = 30
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideSunger), userInfo: nil, repeats: true)
        
        //arrays
        
        sungerArray.append(sunger1)
        sungerArray.append(sunger2)
        sungerArray.append(sunger3)
        sungerArray.append(sunger4)
        sungerArray.append(sunger5)
        sungerArray.append(sunger6)
        sungerArray.append(sunger7)
        sungerArray.append(sunger8)
        sungerArray.append(sunger9)
        
        hideSunger()
    }

    @objc func hideSunger() {
    
        for sunger in sungerArray{
            sunger.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(sungerArray.count - 1)))
        sungerArray[random].isHidden = false
    
    }
    
    @objc func inreaseScore(){
        score = score + 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter = counter - 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            if self.score > Int(highScoreLabel.text!)!{
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
                
            }
            
            let alert = UIAlertController(title: "Time", message: "Time's up!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: .default, handler: { (UIAlertAction) in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:  #selector(ViewController.hideSunger), userInfo: nil, repeats: true)
                
            })
            
            alert.addAction(replayButton)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
            
        }
    }


}


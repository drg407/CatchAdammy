//
//  ViewController.swift
//  CatchAdammy
//
//  Created by David Guevara on 4/29/22.
//

import UIKit

class ViewController: UIViewController {
    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var adam1: UIImageView!
    @IBOutlet weak var adam2: UIImageView!
    @IBOutlet weak var adam3: UIImageView!
    @IBOutlet weak var adam4: UIImageView!
    @IBOutlet weak var adam5: UIImageView!
    @IBOutlet weak var adam6: UIImageView!
    @IBOutlet weak var adam7: UIImageView!
    @IBOutlet weak var adam8: UIImageView!
    @IBOutlet weak var adam9: UIImageView!
    
    // Vars
    var score = 0;
    var timer = Timer()
    var counter = 0
    var adamArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score)";
        
        // High Score Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        if (storedHighScore == nil) {
            highScore = 0
            highScoreLabel.text = "High Score: " + String(highScore)
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "High Score: " + String(highScore)
        }
        
        // Images
        adam1.isUserInteractionEnabled = true
        adam2.isUserInteractionEnabled = true
        adam3.isUserInteractionEnabled = true
        adam4.isUserInteractionEnabled = true
        adam5.isUserInteractionEnabled = true
        adam6.isUserInteractionEnabled = true
        adam7.isUserInteractionEnabled = true
        adam8.isUserInteractionEnabled = true
        adam9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))

        adam1.addGestureRecognizer(recognizer1)
        adam2.addGestureRecognizer(recognizer2)
        adam3.addGestureRecognizer(recognizer3)
        adam4.addGestureRecognizer(recognizer4)
        adam5.addGestureRecognizer(recognizer5)
        adam6.addGestureRecognizer(recognizer6)
        adam7.addGestureRecognizer(recognizer7)
        adam8.addGestureRecognizer(recognizer8)
        adam9.addGestureRecognizer(recognizer9)
        
        adamArray = [adam1, adam2, adam3, adam4, adam5, adam6, adam7, adam8, adam9]
        
        // Timer logic
        counter = 10
        timeLabel.text = "Time: " + String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(hideAdam), userInfo: nil, repeats: true)
        hideAdam()
        
    }
    
    @objc func hideAdam() {
        // Hide all Adams
        for adam in adamArray {
            adam.isHidden = true
            }
        // Display one Adam
        let random = Int(arc4random_uniform(UInt32(adamArray.count - 1)))
        adamArray[random].isHidden = false
        }

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: " + String(score)
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = "Time: " + String(counter)
        
        if (counter == 0) {
            timer.invalidate()
            hideTimer.invalidate()
            
            for adam in adamArray {
                adam.isHidden = true
                }
            
            // High Score Logic
            if (self.score > self.highScore) {
                self.highScore = self.score
                highScoreLabel.text = "High Score: " + String(self.highScore)
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            // Display Alert
            let alert = UIAlertController(title: "Times Up!", message: "Pray Again?", preferredStyle: UIAlertController.Style.alert)
            
            // Create Buttons
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                // Replay Function
                self.score = 0
                self.scoreLabel.text = "Score: " + String(self.score)
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideAdam), userInfo: nil, repeats: true)
            }
            
            // Add buttons to alert
            alert.addAction(okButton);
            alert.addAction(replayButton);
            
            // Display Alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}


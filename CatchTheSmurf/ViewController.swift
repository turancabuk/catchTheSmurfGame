//
//  ViewController.swift
//  CatchTheSmurf
//
//  Created by Turan Çabuk on 31.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // Variables
    var timer = Timer()
    var counter = 0
    var score = 0
    var smurfArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0

    // Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var smurf1: UIImageView!
    @IBOutlet weak var smurf2: UIImageView!
    @IBOutlet weak var smurf3: UIImageView!
    @IBOutlet weak var smurf4: UIImageView!
    @IBOutlet weak var smurf5: UIImageView!
    @IBOutlet weak var smurf6: UIImageView!
    @IBOutlet weak var smurf7: UIImageView!
    @IBOutlet weak var smurf8: UIImageView!
    @IBOutlet weak var smurf9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "score: \(score)"

        
        smurf1.isUserInteractionEnabled = true
        smurf2.isUserInteractionEnabled = true
        smurf3.isUserInteractionEnabled = true
        smurf4.isUserInteractionEnabled = true
        smurf5.isUserInteractionEnabled = true
        smurf6.isUserInteractionEnabled = true
        smurf7.isUserInteractionEnabled = true
        smurf8.isUserInteractionEnabled = true
        smurf9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        smurf1.addGestureRecognizer(recognizer1)
        smurf2.addGestureRecognizer(recognizer2)
        smurf3.addGestureRecognizer(recognizer3)
        smurf4.addGestureRecognizer(recognizer4)
        smurf5.addGestureRecognizer(recognizer5)
        smurf6.addGestureRecognizer(recognizer6)
        smurf7.addGestureRecognizer(recognizer7)
        smurf8.addGestureRecognizer(recognizer8)
        smurf9.addGestureRecognizer(recognizer9)
        
        smurfArray = [smurf1, smurf2, smurf3, smurf4, smurf5, smurf6, smurf7, smurf8, smurf9]

        
        counter = 10
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeFunc), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideSmurf), userInfo: nil, repeats: true)
        hideSmurf()
        

        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil{
            highscore = 0
            highscoreLabel.text = "highscore: \(highscore)"
        }
        if let newScore = storedHighscore as? Int{
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore) "
        }
        }
       
       
       @objc func hideSmurf() {
           
           for smurf in smurfArray {
               smurf.isHidden = true
           }
           
           let random = Int(arc4random_uniform(UInt32(smurfArray.count - 1)))
           smurfArray[random].isHidden = false
           
       }
       
       
       
       @objc func increaseScore() {
           score += 1
           scoreLabel.text = "Score: \(score)"
       }
       
       @objc func timeFunc() {
           
           counter -= 1
           timeLabel.text = String(counter)
           
           if counter == 0 {
               timer.invalidate()
               hideTimer.invalidate()
               
               for smurf in smurfArray {
                   smurf.isHidden = true

               }
               
               if self.score > self.highscore{
                   highscore = score
                   highscoreLabel.text = "highscore: \(score)"
                   UserDefaults.standard.set(self.highscore, forKey: "highscore")
                    
               }
                    
               
               
               //Alert
               
               let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
               let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
               let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                   
                   self.counter = 10
                   self.timeLabel.text = "\(self.counter)"
                   self.score = 0
                   self.scoreLabel.text = "\(score)"
                   
                   timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunc), userInfo: nil, repeats: true)
                   hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideSmurf), userInfo: nil, repeats: true)
                   
                   
                   
               }
               alert.addAction(okButton)
               alert.addAction(replayButton)
               self.present(alert, animated: true, completion: nil)
               
               
               
               
               
            
               
               
           }
           
       }


   }

        
            
   
         

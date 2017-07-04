//
//  ViewController.swift
//  BullsEye
//
//  Created by Leonel Menezes on 09/03/17.
//  Copyright © 2017 Leonel Menezes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    var targetValue: Int = 0
    var scoreEachRound = 0
    var score = 0
    var round = 0
    var timer = Timer()
    var flag = 0
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startNewRound()
        updateLabels()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert(){
        
        let difference = abs(currentValue - targetValue)
        let points = 100 - difference
        let title : String
        timer.invalidate()
        
        if difference == 0{
            title = "Perfect!!"
            score += 100
            scoreEachRound += 100;
        }else if difference < 5 {
            title = "You almost had it!"
            score += 50
            scoreEachRound += 50
        }else if difference < 10 {
            title = "Pretty good!"
            score += 10
            scoreEachRound += 10
        }else{
            title = "Not even close..."
        }
        scoreEachRound += points
        score += points
        
        let message = "The value of the slider is: \(currentValue)" +
                        "\nThe target value is: \(targetValue)" +
                        "\nYOU SCORED \(scoreEachRound) POINTS!!"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title:"OK", style: .default,
                                   handler: { action in
                                                self.startNewRound()
                                                self.updateLabels()
                                    
                                            })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func newGame(){
        
        
        score = 0
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        round = 0;
        slider.value = Float(currentValue)
        scoreEachRound = 0
        updateLabels()
        
        
        
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewRound() {
        targetValue = 1 + Int(arc4random_uniform(100))
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        scoreEachRound = 0
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func timerAction(){
        
        if currentValue < 100 && flag == 0{
            currentValue += 1
        }else{
            flag = 1
            currentValue -= 1
        }
        if(currentValue == 1){
            flag = 0
        }
        slider.value = Float(currentValue)
        
        
    }
    
    
    
    
    
}


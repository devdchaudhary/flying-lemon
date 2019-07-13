//
//  Game.swift
//  The Flying Lemon
//
//  Created by Devanshu on 08/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class Game: UIViewController {
    
    @IBOutlet var lemon: UIImageView!
    @IBOutlet var startGame: UIButton!
    @IBOutlet var topTunnel: UIImageView!
    @IBOutlet var bottomTunnel: UIImageView!
    @IBOutlet var bottom: UIImageView!
    @IBOutlet var top: UIImageView!
    @IBOutlet var replay: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var gameOver: UILabel!
    var lemonMovement: Timer?
    var tunnelMovement: Timer?
    var highScoreNumber: Int!
    var scoreNumber: Int = 0
    var lemonflying: Int = 30
    var randomTopTunnelPosition: Int!
    var randomBottomTunnelPosition: Int!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        topTunnel.isHidden = false
        
        bottomTunnel.isHidden = false
        
        highScoreNumber = UserDefaults.standard.integer(forKey: "HighScoreSaved")

        replay.isHidden = true
        
        gameOver.isHidden = true
        
    }

    func tapSound() {
        
        if let soundURL = Bundle.main.url(forResource: "Tap Sound", withExtension: "mp3") {
            
            var mySound: SystemSoundID = 0
            
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            
            AudioServicesPlaySystemSound(mySound);
            
        }
        
    }
    
    func pointSound() {
        
        if let soundURL = Bundle.main.url(forResource: "Point Sound", withExtension: "mp3") {
            
            var mySound: SystemSoundID = 0
            
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            
            AudioServicesPlaySystemSound(mySound);
            
    }
        
}
    
    func crashSound() {
        
        if let soundURL = Bundle.main.url(forResource: "Crash Sound", withExtension: "mp3") {
            
            var mySound: SystemSoundID = 0
            
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            
            AudioServicesPlaySystemSound(mySound);
            
        }
        
    }
    
    @objc func lemonMoving() {
        
        lemon.center = CGPoint(x: lemon.center.x, y: lemon.center.y - CGFloat(lemonflying))
        
        lemonflying = lemonflying - 5
        
        if lemonflying < -15 {
            
            lemonflying = -15
            
        }
        
        if lemonflying > 0 {
            
            lemon.image = UIImage(named: "Lemon up.png")
            
        }
        
        if lemonflying == 0 {
            
            lemon.image = UIImage(named: "Lemon straight.png")
        }
        
        if lemonflying < 0 {
            
            lemon.image = UIImage(named: "Lemon down.png")
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.tapSound()
        
        lemonflying = 30
        
    }
    
    func placeTunnels() {
        
        randomTopTunnelPosition = Int(arc4random() % 270)
        randomTopTunnelPosition = Int(randomTopTunnelPosition) - 250
        randomBottomTunnelPosition = Int(randomTopTunnelPosition) + 920
        topTunnel.center = CGPoint(x: 700, y: CGFloat(randomTopTunnelPosition))
        bottomTunnel.center = CGPoint(x: 700, y: CGFloat(randomBottomTunnelPosition))
        
    }
    
    @objc func tunnelMoving() {
        
        topTunnel.center = CGPoint(x: topTunnel.center.x - 1, y: topTunnel.center.y)
        
        bottomTunnel.center = CGPoint(x: bottomTunnel.center.x - 1, y: bottomTunnel.center.y)
       
        if topTunnel.center.x < -100 {
            
            placeTunnels()
            
        }
        
        if topTunnel.center.x == 100 {
            
            score()
            pointSound()
            
        }
        
        if lemon.frame.intersects(topTunnel.frame) {
            
            gameover()
            crashSound()
            
        }
        
        if lemon.frame.intersects(bottomTunnel.frame) {
            gameover()
            crashSound()
        }
        
        if lemon.frame.intersects(bottom.frame) {
            
            gameover()
            crashSound()
        }
        
        if lemon.frame.intersects(top.frame) {
            
            gameover()
            crashSound()
            
        }
    }
    
    func gameover() {
        
        if scoreNumber > highScoreNumber {
            
            UserDefaults.standard.set(Int(scoreNumber), forKey: "HighScoreSaved")
            
        }
        
        tunnelMovement?.invalidate()
        
        lemonMovement?.invalidate()
        
        crashSound()
                
        replay.isHidden = false
        
        gameOver.isHidden = false
        
        lemon.isHidden = true
        
        topTunnel.isHidden = true
        
        bottomTunnel.isHidden = true
        
    }
    
    @IBAction func startGame(_ sender: Any) {
        
        tapSound()
        
        startGame.isHidden = true
        
        lemonMovement = Timer.scheduledTimer(timeInterval: 0.020, target: self, selector: #selector(self.lemonMoving), userInfo: nil, repeats: true)
        
        tunnelMovement = Timer.scheduledTimer(timeInterval: 0.004, target: self, selector: #selector(self.tunnelMoving), userInfo: nil, repeats: true)
        
        placeTunnels()
    
    }
    
    func score() {
        
        scoreNumber = Int(scoreNumber) + 1
        
        scoreLabel.text = String(format: "%i", scoreNumber)
        
    }
    
    @IBAction func replayAction(_ sender: Any) {
        
       let mainmenunavigationcontroller = self.storyboard!.instantiateViewController(withIdentifier: "mainmenustoryboard")
        
        self.present(mainmenunavigationcontroller, animated: false, completion: nil)
        
    }
}

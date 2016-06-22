//
//  ViewController.swift
//  ooperciseRPG
//
//  Created by Alan Glasby on 21/06/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var player1Img: UIImageView!
    
    @IBOutlet weak var player2Img: UIImageView!
    
    @IBOutlet weak var outputLbl: UILabel!
    
    @IBOutlet weak var attack1Btn: UIButton!
    
    @IBOutlet weak var attack2Btn: UIButton!
    
    @IBOutlet weak var player1Lbl: UILabel!
    
    @IBOutlet weak var player2Lbl: UILabel!
    
    @IBOutlet weak var playAgainBtn: UIButton!
    
    
    var player1: Player!
    var player2: Player!
    var outputMessage = "Either player presses Attack to start"
    var gameInProgress = false
    var playerImages = ["",""]

    
    let secondsDelay = 3.0

    
    func randomiseAttackPwr() -> Int {
        return 10 + Int(arc4random_uniform(20))
    }
    
    
    func randomiseStartingHp() -> Int {
        return 110 + Int(arc4random_uniform(30))
    }
    
    
    func selectImageForPlayers() -> [String] {
        var imageNameArray = ["",""]
        imageNameArray[0] = ("enemy.png")
        imageNameArray[1] = ("player.png")
        return imageNameArray
    }
    
    
    func initialiseGame() {
        
        playerImages = selectImageForPlayers()
        
        player1 = Player(startingHp: randomiseStartingHp(), attackPwr: randomiseAttackPwr(), playerName: "DirtyLaundry25", playerImage: playerImages[0])
        player2 = Player(startingHp: randomiseStartingHp(), attackPwr: randomiseAttackPwr(), playerName: "EvenDirtierLaundry57", playerImage: playerImages[1])
        
        player1Lbl.text = "\(player1.playerHp) HP"
        player2Lbl.text = "\(player2.playerHp) HP"
        
        outputLbl.text = outputMessage
        
        player1Img.hidden = false
        player1Img.image = UIImage(named: player1.playerImage)
        attack1Btn.enabled = true
        
        player2Img.hidden = false
        player2Img.image = UIImage(named: player2.playerImage)
        attack2Btn.enabled = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseGame()
    }
    

    func disableAttackBtn (attackBtn: UIButton) {
 
        let delay = secondsDelay * Double(NSEC_PER_SEC)
        let enableBtnTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        attackBtn.enabled = false
        
        dispatch_after(enableBtnTime, dispatch_get_main_queue(), {attackBtn.enabled = true})
        
    }
    
   
    func clearOutputLblIfStarted() {
        
        if !gameInProgress {
            gameInProgress = true
            outputLbl.hidden = true
        }
        
    }
    func updateAttackResult(attacker: Player, attacked: Player, attackedPlayerLbl: UILabel, attackedPlayerImg: UIImageView, attackedPlayerBtn: UIButton, attackerPlayerBtn:UIButton) {

        if attacked.attemptAttack(attacker.attackPwr) {
            
            if !attacked.isAlive {
                
                attackedPlayerLbl.text = "Dead"
                attackedPlayerImg.hidden = true
                outputLbl.text = "The winner is \(attacker.name)"
                outputLbl.hidden = false
                playAgainBtn.hidden = false
                attackedPlayerBtn.enabled = false
                attackerPlayerBtn.enabled = false
                
            } else {
                attackedPlayerLbl.text = "\(attacked.playerHp) HP"
                disableAttackBtn(attackedPlayerBtn)
            }
        }
    }
    

    @IBAction func onPlayer1AttackTapped(sender: AnyObject) {
        

        clearOutputLblIfStarted()
        
        updateAttackResult(player1, attacked: player2, attackedPlayerLbl: player2Lbl, attackedPlayerImg: player2Img, attackedPlayerBtn: attack2Btn, attackerPlayerBtn: attack1Btn)
    }
    
    
    @IBAction func onPlayer2AttackTapped(sender: AnyObject) {
        
        clearOutputLblIfStarted()
        
        updateAttackResult(player2, attacked: player1, attackedPlayerLbl: player1Lbl, attackedPlayerImg: player1Img, attackedPlayerBtn: attack1Btn, attackerPlayerBtn: attack2Btn)
    }
    
    
    @IBAction func onPlayAgainTapped(sender: AnyObject) {
        initialiseGame()
    }
    

}


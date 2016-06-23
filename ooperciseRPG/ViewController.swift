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
    
    @IBOutlet weak var player: UIButton!
    
    @IBOutlet weak var enemy: UIButton!
    
    
    var player1: Player!
    var player2: Player!
    var gameInProgress = false
    var playerImages = ["",""]
    var player1Selected = false

    
    let outputMessage = "Either player presses Attack to start"
    let secondsDelay = 3.0

    
    func randomiseTrait(base: Int, range: Int) -> Int {
        return base + Int(arc4random_uniform(UInt32(range)))
    }
    
    
    func initialiseGame() {

        player1Img.hidden = true
        player2Img.hidden = true
        playAgainBtn.hidden = true
        attack1Btn.enabled = false
        attack2Btn.enabled = false
        
        player1 = Player(startingHp: randomiseTrait(110, range:30), attackPwr: randomiseTrait(10, range: 20), playerName: "DirtyLaundry25", playerImage: "")
        player2 = Player(startingHp: randomiseTrait(110, range:30), attackPwr: randomiseTrait(10, range: 20), playerName: "EvenDirtierLaundry57", playerImage: "")

        enemy.hidden = false
        player.hidden = false
        
        player1Selected = false
        
        outputLbl.text = "Player 1 select your character"
        
        player1Lbl.text = "\(player1.playerHp) HP"
        player2Lbl.text = "\(player2.playerHp) HP"
        
    }
    
    func startGame() {
        outputLbl.text = outputMessage
        enemy.hidden = true
        player.hidden = true
        attack1Btn.enabled = true
        attack2Btn.enabled = true
        player1Img.image = UIImage(named: player1.playerImage)
        player1Img.hidden = false
        
        player2Img.image = UIImage(named: player2.playerImage)
        player2Img.hidden = false
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
   
    @IBAction func onSelectEnemyTapped(sender: AnyObject) {
        if !player1Selected {
            player1.setPlayerImage("enemy.png")
            outputLbl.text = "Player 2 select your character"
            player1Selected = true
        } else {
            player2.setPlayerImage("enemy.png")
            startGame()
        }
    }
    
    @IBAction func onSelectPlayerTapped(sender: AnyObject) {
        if !player1Selected {
            player1.setPlayerImage("player.png")
            outputLbl.text = "Player 2 select your character"
            player1Selected = true
        } else {
            player2.setPlayerImage("player.png")
            startGame()
        }

    }

}


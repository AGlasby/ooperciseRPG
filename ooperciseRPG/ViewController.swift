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
    
    
    var player1: Player!
    var player2: Player!
    var outputMessage = "Either player presses Attack to start"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1 = Player(startingHp: 110, attackPwr: 20, playerName: "DirtyLaundry25")
        player1Lbl.text = "\(player1.playerHp) HP"
        
        player2 = Player(startingHp: 130, attackPwr: 20, playerName: "EvenDirtierLaundry57")
        player2Lbl.text = "\(player2.playerHp) HP"
        
        outputLbl.text = outputMessage
        
    }
    
    func updateAttackResult(attacker: Player, attacked: Player, attackedPlayerLbl: UILabel, attackedPlayerImg: UIImageView) {

        if attacker.attemptAttack(attacked.attackPwr) {
            if !attacked.isAlive {
                attackedPlayerLbl.text = "Dead"
                attackedPlayerImg.hidden = true
                outputLbl.text = "The winner is \(attacker.name)"
            } else {
                attackedPlayerLbl.text = "\(attacked.playerHp) HP"
            }
        }
    }
    

    @IBAction func onPlayer1AttackTapped(sender: AnyObject) {
        updateAttackResult(player1, attacked: player2, attackedPlayerLbl: player2Lbl, attackedPlayerImg: player2Img)

    }
    
    @IBAction func onPlayer2AttackTapped(sender: AnyObject) {
        updateAttackResult(player2, attacked: player1, attackedPlayerLbl: player1Lbl, attackedPlayerImg: player1Img)
    }

}


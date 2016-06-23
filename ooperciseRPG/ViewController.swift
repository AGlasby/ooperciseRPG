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
    
    @IBOutlet weak var imageStackView: UIStackView!
    
    
    var rpgGame: RpgGameController!
    var player1: Player!
    var player2: Player!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rpgGame = RpgGameController(play1Img: player1Img, play2Img: player2Img, play1Lbl: player1Lbl, play2Lbl: player2Lbl, outLbl: outputLbl, playAgnBtn: playAgainBtn, attk1Btn: attack1Btn, attk2Btn: attack2Btn, imgStckView: imageStackView)
        
        rpgGame.initialiseGame()
        player1 = rpgGame.player1
        player2 = rpgGame.player2
//        rpgGame.startGame()
    }
    

    @IBAction func onPlayer1AttackTapped(sender: AnyObject) {
               
        rpgGame.updateAttackResult(player1, attacked: player2, attackedPlayerLbl: player2Lbl, attackedPlayerImg: player2Img, attackedPlayerBtn: attack2Btn, attackerPlayerBtn: attack1Btn)
    }
    
    
    @IBAction func onPlayer2AttackTapped(sender: AnyObject) {
        
        rpgGame.updateAttackResult(player2, attacked: player1, attackedPlayerLbl: player1Lbl, attackedPlayerImg: player1Img, attackedPlayerBtn: attack1Btn, attackerPlayerBtn: attack2Btn)
    }
    
    
    @IBAction func onPlayAgainTapped(sender: AnyObject) {

        rpgGame.initialiseGame()
//        rpgGame.startGame()
    }
   
    @IBAction func onSelectEnemyTapped(sender: AnyObject) {
        
        rpgGame.selectEnemy()
    }
    
    @IBAction func onSelectPlayerTapped(sender: AnyObject) {
        
        rpgGame.selectPlayer()
    }

}


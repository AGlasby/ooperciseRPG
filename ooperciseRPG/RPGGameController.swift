//
//  RPGGameController.swift
//  ooperciseRPG
//
//  Created by Alan Glasby on 23/06/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import Foundation
import UIKit

class RpgGameController {

    private var _player1: Player!
    private var _player2: Player!
    
    private var _gameInProgress = false
    private var _player1Selected = false
    
    private var _play1Img: UIImageView!
    private var _play2Img: UIImageView!
    private var _outLbl: UILabel!
    private var _play1Lbl: UILabel!
    private var _play2Lbl: UILabel!
    private var _attk1Btn: UIButton!
    private var _attk2Btn: UIButton!
    private var _playAgnBtn: UIButton!
    private var _imgStckView: UIStackView!
    
    var player1: Player {
        return _player1
    }
    
    var player2: Player {
        return _player2
    }
    
    private let _playerImg = "player.png"
    private let _enemyImg = "enemy.png"
    private let _outputMessage = "Either player presses Attack to start"
    private let _secondsDelay = 3.0

    init(play1Img: UIImageView, play2Img: UIImageView, play1Lbl: UILabel, play2Lbl: UILabel, outLbl: UILabel, playAgnBtn: UIButton, attk1Btn: UIButton, attk2Btn: UIButton, imgStckView: UIStackView) {
    
        _outLbl = outLbl
        _imgStckView = imgStckView
        _attk1Btn = attk1Btn
        _attk2Btn = attk2Btn
        _play1Img = play1Img
        _play2Img = play2Img
        _playAgnBtn = playAgnBtn
        _play1Lbl = play1Lbl
        _play2Lbl = play2Lbl
        
        _player1 = Player(startingHp: self.randomiseTrait(110, range:30), attackPwr: self.randomiseTrait(10, range: 20), playerName: "DirtyLaundry25", playerImage: "")
        
        _player2 = Player(startingHp: randomiseTrait(110, range:30), attackPwr: randomiseTrait(10, range: 20), playerName: "EvenDirtierLaundry57", playerImage: "")

    }

    func randomiseTrait(base: Int, range: Int) -> Int {
        return base + Int(arc4random_uniform(UInt32(range)))
    }

    
    func clearOutputLblIfStarted() {
        
        if !_gameInProgress {
            _gameInProgress = true
            _outLbl.hidden = true
        }
    }
    
    func setOutputLbl(message: String) {
        self._outLbl.text = message
    }

    func disableAttackBtn (attackBtn: UIButton) {
        
        let delay = _secondsDelay * Double(NSEC_PER_SEC)
        let enableBtnTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        attackBtn.enabled = false
        
        dispatch_after(enableBtnTime, dispatch_get_main_queue(), {
            if self._gameInProgress {
                attackBtn.enabled = true}})
    }
    
    func initialiseGame() {
        
        _play1Img.hidden = true
        _play2Img.hidden = true
        _playAgnBtn.hidden = true
        _attk1Btn.enabled = false
        _attk2Btn.enabled = false
        
        self._gameInProgress = false
        self._player1Selected = false
        
        _imgStckView.hidden = false
        
        _player1Selected = false
        
        setOutputLbl("Player 1 select your character")
        
        _play1Lbl.text = "\(player1.playerHp) HP"
        _play2Lbl.text = "\(player2.playerHp) HP"
        
        
        setOutputLbl(_outputMessage)
        
        self._imgStckView.hidden = true
        
        self._attk1Btn.enabled = true
        self._attk2Btn.enabled = true
        self._play1Img.image = UIImage(named: player1.playerImage)
        self._play1Img.hidden = false
        
        self._play2Img.image = UIImage(named: player2.playerImage)
        self._play2Img.hidden = false
    }
    

    func updateAttackResult(attacker: Player, attacked: Player, attackedPlayerLbl: UILabel, attackedPlayerImg: UIImageView, attackedPlayerBtn: UIButton, attackerPlayerBtn:UIButton) {
        
        clearOutputLblIfStarted()
        
        if attacked.attemptAttack(attacker.attackPwr) {
            
            if !attacked.isAlive {
                
                attackedPlayerLbl.text = "Dead"
                attackedPlayerImg.hidden = true
                _outLbl.text = "The winner is \(attacker.name)"
                _outLbl.hidden = false
                self._playAgnBtn.hidden = false
                attackedPlayerBtn.enabled = false
                attackerPlayerBtn.enabled = false
                
            } else {
                attackedPlayerLbl.text = "\(attacked.playerHp) HP"
                disableAttackBtn(attackedPlayerBtn)
            }
        }
    }

//    func startGame() {
//        
//        setOutputLbl(_outputMessage)
//
//        self._imgStckView.hidden = true
//        
//        self._attk1Btn.enabled = true
//        self._attk2Btn.enabled = true
//        self._play1Img.image = UIImage(named: player1.playerImage)
//        self._play1Img.hidden = false
//
//        self._play2Img.image = UIImage(named: player2.playerImage)
//        self._play2Img.hidden = false
//    }

    func selectEnemy() {
        if !_player1Selected {
            player1.setPlayerImage(_enemyImg)
            setOutputLbl("Player 2 select your character")
            _player1Selected = true
        } else {
            player2.setPlayerImage(_enemyImg)
//            self.startGame()
        }
    }
    
    func selectPlayer() {
        if !_player1Selected {
            player1.setPlayerImage(_playerImg)
            setOutputLbl("Player 2 select your character")
            _player1Selected = true
        } else {
            player2.setPlayerImage(_playerImg)
//            self.startGame()
        }
        
    }
}




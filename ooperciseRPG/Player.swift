//
//  Player.swift
//  ooperciseRPG
//
//  Created by Alan Glasby on 21/06/2016.
//  Copyright © 2016 Alan Glasby. All rights reserved.
//

import Foundation

class Player {
    private var _playerHp: Int = 100
    private var _attackPwr: Int = 10
    private var _name: String
    private var _image: String
    
    var attackPwr: Int {
        return _attackPwr
    }
    
    var playerHp: Int {
        return _playerHp
    }
    
    var name: String {
        return _name
    }
    
    var playerImage: String {
        return _image
    }
    
    var isAlive: Bool {
        get {
            if playerHp <= 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    init(startingHp: Int, attackPwr: Int, playerName: String, playerImage: String) {
        self._playerHp = startingHp
        self._attackPwr = attackPwr
        self._name = playerName
        self._image = ""
    }
    
    func attemptAttack(attackPwr: Int) -> Bool {
        self._playerHp -= attackPwr
        return true
    }
    
    func setPlayerImage(playerImageName: String) {
        self._image = playerImageName
    }
    
    
}

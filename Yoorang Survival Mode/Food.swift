//
//  Food.swift
//  Yoorang
//
//  Created by eff employee on 10/17/16.
//  Copyright © 2016 eff employee. All rights reserved.
//


import Foundation
import UIKit
import SpriteKit

enum FoodType {
    case food
    case timer
    case bomb
    case powerUp
    case snow
    case coin
}

class Food : SKSpriteNode
{
    var foodType = FoodType.food
    var landed = false
    var collected = false
    
    func openCoinBox(){
        self.hidden = true
        for i in -2...2{
            let coin = Coin(imageNamed: "coinGold")
            coin.size = CGSizeMake(self.size.width, self.size.height)
            coin.position = self.position
            coin.addPhysicsBodyWithSize(coin.size, gravity: true, dynamic: true, rotation: false, friction: 1.0, restitution: 0.0, categoryBitMask: commonPowerUpCategory, contactTestBitMask: playerCategory, collisionBitMask: groundCategory)
            self.parent?.addChild(coin)
            coin.physicsBody?.applyImpulse(CGVectorMake(-CGFloat(i), CGFloat(8 - abs(i))))
        }
    }
}

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
    case energy
    case gem
}

class Food : SKSpriteNode
{
    var foodType = FoodType.food
    var landed = false
    var collected = false
    
    func spin(){
        self.runAction(SKAction.repeatActionForever(SKAction.rotateByAngle(6.28, duration: 3)), withKey: "spin")
    }
    
    func openCoinBox(){
        self.hidden = true
        for i in -2...2{
            let coin = Coin(imageNamed: "coinGold")
            coin.size = CGSizeMake(self.size.width/2, self.size.height/2)
            coin.position = self.position
            coin.addPhysicsBodyWithSize(coin.size, gravity: true, dynamic: true, rotation: false, friction: 1.0, restitution: 0.0, categoryBitMask: commonPowerUpCategory, contactTestBitMask: playerCategory, collisionBitMask: groundCategory)
            self.parent?.addChild(coin)
            if i == 0{
                coin.physicsBody?.applyImpulse(CGVectorMake(-CGFloat(i), CGFloat(4 - abs(i))))
            }else{
                coin.physicsBody?.applyImpulse(CGVectorMake(-CGFloat(i), CGFloat(5 - abs(i))))
            }
        }
    }
    
    func openEnergyBox(){
        self.hidden = true
        for i in -2...2{
            let coin = Gem(imageNamed: "gemBlue")
            coin.size = CGSizeMake(self.size.width/2, self.size.height/2)
            coin.position = self.position
            coin.addPhysicsBodyWithSize(coin.size, gravity: true, dynamic: true, rotation: false, friction: 1.0, restitution: 0.0, categoryBitMask: commonPowerUpCategory, contactTestBitMask: playerCategory, collisionBitMask: groundCategory)
            self.parent?.addChild(coin)
            if i == 0{
                coin.physicsBody?.applyImpulse(CGVectorMake(-CGFloat(i), CGFloat(3 - abs(i))))
            }else{
                coin.physicsBody?.applyImpulse(CGVectorMake(-CGFloat(i), CGFloat(4 - abs(i))))
            }
        }
    }
    
    func froze(){
        self.removeFromParent()
        if !frozed{
            frozed = true
            foodLayer.frozeDefroze()
            delay(2) {
                frozed = false
                foodLayer.frozeDefroze()
            }
        }
    }
    
    
}

//
//  Player.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/1/16.
//  Copyright © 2016 eff employee. All rights reserved.
//


import Foundation
import UIKit
import SpriteKit

class Player : SKSpriteNode
{
    var moveable = true
    var walkingFrames = [SKTexture]()
    var direction = 0 //-1 left, 0 stay, 1 right
    
    func update(delta: CFTimeInterval){
        walk(delta)
    }
    
    func setUpFrames(){
        for x in 2...10{
            walkingFrames.append(SKTexture(imageNamed: "p3_walk\(x)"))
        }
    }

    func walk(delta: CFTimeInterval){
        if direction == -1 {
            self.position.x -= CGFloat(delta * 200)
            if actionForKey("walkLeft") == nil{
                removeAllActions()
                walkLeftAnimation()
            }
        }else if direction == 1 {
            self.position.x += CGFloat(delta * 200)
            if actionForKey("walkRight") == nil{
                removeAllActions()
                walkRightAnimation()
            }
        }else{
            removeAllActions()
            self.texture = SKTexture(imageNamed: "p3_walk1")
        }
    }
    
    func walkLeftAnimation(){
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkingFrames, timePerFrame: 0.1)), withKey: "walkLeft")
    }
    
    func walkRightAnimation(){
        self.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(walkingFrames, timePerFrame: 0.1)), withKey: "walkRight")
    }
}

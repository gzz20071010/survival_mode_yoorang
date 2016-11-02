//
//  Coin.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/2/16.
//  Copyright © 2016 eff employee. All rights reserved.
//



import Foundation
import UIKit
import SpriteKit

class Coin : SKSpriteNode
{
//
//    func update(delta: NSTimeInterval){
//        if collected == true{
//            collect()
//        }
//    }
//    var collected = false
    
    func collect(){
        self.addEffectToNode(self.position, endPosition: CGPointMake(0, screenHeightNS), delay: 0.0, action: {self.removeFromParent()}())
    }
}

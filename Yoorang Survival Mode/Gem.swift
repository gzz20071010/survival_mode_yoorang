//
//  Gem.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/3/16.
//  Copyright © 2016 eff employee. All rights reserved.
//



import Foundation
import UIKit
import SpriteKit

class Gem : SKSpriteNode
{
    //
    //    func update(delta: NSTimeInterval){
    //        if collected == true{
    //            collect()
    //        }
    //    }
    //    var collected = false
    
    var collected = false
    
    func collect(){
        self.removeFromParent()
        if self.collected == false{
            let gem = SKSpriteNode(color: SKColorWithRGB(0, g: 255, b: 255), size: self.size)
            gem.alpha = 0.4
            progressBar.count += 1
            let yPos = progressBar.position.y - progressBar.size.height/2 + self.size.height * CGFloat(progressBar.count) - CGFloat(5.0)
            backgroundNode.addChild(gem)
            gem.addEffectToNode(self.position, endPosition: CGPointMake(progressBar.position.x, yPos), delay: 0.0, action: {}())
            self.collected = true
        }
    }
}

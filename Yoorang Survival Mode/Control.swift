//
//  Control.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/1/16.
//  Copyright © 2016 eff employee. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Control : SKSpriteNode
{
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //player.position.x = (touches.first?.locationInNode((self.parent?.parent)!).x)!
        if(touches.first?.locationInNode((self.parent?.parent)!).x)! < screenWidthNS/2{
            player.direction = -1
            player.xScale = -1
        }else{
            player.direction = 1
            player.xScale = 1
        }

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //player.position.x = (touches.first?.locationInNode((self.parent?.parent)!).x)!
        if(touches.first?.locationInNode((self.parent?.parent)!).x)! < screenWidthNS/2{
            player.direction = -1
            player.xScale = -1
        }else{
            player.direction = 1
            player.xScale = 1
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        player.texture = SKTexture(imageNamed: "p3_walk1")
        player.direction = 0
        
    }
    
    
}

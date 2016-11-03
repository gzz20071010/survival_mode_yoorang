//
//  BackgroundLayer.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/3/16.
//  Copyright © 2016 eff employee. All rights reserved.
//

import SpriteKit

class BackgroundLayer: SKSpriteNode {
    
    let bgSpeed = CGFloat(2)
    var background1 : SKSpriteNode!
    var background2 : SKSpriteNode!
    var background3 : SKSpriteNode!
    
    func update(delta: CFTimeInterval){
    
        for child in children{
            if let child = child as? SKSpriteNode{
                if child.name != nil{
                    child.position.y -= 2
                }
                if child.position.y <= -(child.size.height){
                    if child.name == "1" && childNodeWithName("2") != nil || child.name == "2" &&
                        childNodeWithName("1") != nil {
                        child.position = CGPointMake(child.position.x, child.position.y + child.size.height*2)
                    }
                }
            }
        }
    }
    
    func addBackground(){
        
        background1 = SKSpriteNode(imageNamed: "bgsm");
        background1.name = "1"
        background1.size = CGSizeMake(screenWidthNS, screenHeightNS);
        background1.anchorPoint = CGPointZero
        background1.position = CGPointMake(CGPointZero.x, CGPointZero.y);
        background1.zPosition = 0;
        self.addChild(background1);
        
        background2 = SKSpriteNode(imageNamed: "bgsm");
        background2.name = "2"
        background2.size = CGSizeMake(screenWidthNS, screenHeightNS);
        background2.anchorPoint = CGPointZero
        background2.position = CGPointMake(CGPointZero.x, CGPointZero.y+screenHeightNS);
        background2.zPosition = 0;
        self.addChild(background2);
        
        background1.alpha = 0.5
        background2.alpha = 0.5
    }

}

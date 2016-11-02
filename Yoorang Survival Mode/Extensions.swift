//
//  Extensions.swift
//  SpriteKit Introduction
//
//  Created by J. Ruof, Meruca on 24.10.15.
//  Copyright © 2015 RuMe Academy. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    
    func addPhysicsBodyWithSize(size: CGSize, gravity: Bool, dynamic: Bool, rotation: Bool, friction: CGFloat, restitution: CGFloat, categoryBitMask: UInt32, contactTestBitMask: UInt32, collisionBitMask: UInt32) {
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: size)
        self.physicsBody?.affectedByGravity = gravity
        self.physicsBody?.dynamic = dynamic
        self.physicsBody?.allowsRotation = rotation
        self.physicsBody?.friction = friction
        self.physicsBody?.restitution = restitution
        self.physicsBody?.categoryBitMask = categoryBitMask
        self.physicsBody?.contactTestBitMask = contactTestBitMask
        self.physicsBody?.collisionBitMask = collisionBitMask
        
    }
    
    func addPhysicsBodyWithSizeAlpha(texture: SKTexture, alphaThreshold: Float, size: CGSize, gravity: Bool, dynamic: Bool, rotation: Bool, friction: CGFloat, restitution: CGFloat, categoryBitMask: UInt32, contactTestBitMask: UInt32, collisionBitMask: UInt32) {
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: alphaThreshold, size: size)
        self.physicsBody?.affectedByGravity = gravity
        self.physicsBody?.dynamic = dynamic
        self.physicsBody?.allowsRotation = rotation
        self.physicsBody?.friction = friction
        self.physicsBody?.restitution = restitution
        self.physicsBody?.categoryBitMask = categoryBitMask
        self.physicsBody?.contactTestBitMask = contactTestBitMask
        self.physicsBody?.collisionBitMask = collisionBitMask
        
    }
}

extension SKNode{
    func addEffectToBall() {
        
        self.xScale = 0.8
        self.yScale = 0.8
        
        let scaleEffect = SKTScaleEffect(node: self, duration: 0.5, startScale:CGPointMake(self.xScale, self.yScale), endScale:CGPointMake(1, 1))
        scaleEffect.timingFunction = SKTTimingFunctionBackEaseOut
        
        self.runAction(SKAction.actionWithEffect(scaleEffect))
    }
    
//    func addEffectToHud(block:dispatch_block_t){
//        self.xScale = 0.2
//        self.yScale = 0.2
//        
//        let scaleEffect = SKTScaleEffect(node: self, duration: 0.5, startScale:CGPointMake(self.xScale, self.yScale), endScale:CGPointMake(1, 1))
//        scaleEffect.timingFunction = SKTTimingFunctionBackEaseOut
//    
//        self.runAction((SKAction.actionWithEffect(scaleEffect)), completion: {
//            self.runAction(SKAction.runBlock(block))
//        
//        })
//
//    }
    func addEffectToHud(block:dispatch_block_t){
        self.xScale = 0.2
        self.yScale = 0.2
        
        let scaleEffect = SKTScaleEffect(node: self, duration: 0.5, startScale:CGPointMake(self.xScale, self.yScale), endScale:CGPointMake(1, 1))
        scaleEffect.timingFunction = SKTTimingFunctionBackEaseOut
        
        self.runAction((SKAction.actionWithEffect(scaleEffect)), completion: {
            self.runAction(SKAction.runBlock(block))
            
        })
    }
    
    func shakeSKSpriteNode(duration:Float) {
        let amplitudeX:Float = 30;
        let amplitudeY:Float = 6;
        let numberOfShakes = duration / 2;
        var actionsArray:[SKAction] = [];
        for _ in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveByX(CGFloat(moveX), y: CGFloat(moveY), duration: 1);
            shakeAction.timingMode = SKActionTimingMode.EaseOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversedAction());
        }
        
        let actionSeq = SKAction.sequence(actionsArray);
        self.runAction(SKAction.repeatActionForever(actionSeq));
    }
    
    func shakeSKSpriteNodeV(duration:Float) {
        let amplitudeX:Float = 0;
        let amplitudeY:Float = 6;
        let numberOfShakes = duration / 2;
        var actionsArray:[SKAction] = [];
        for _ in 1...Int(numberOfShakes) {
            let moveX = Float(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX / 2;
            let moveY = Float(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY / 2;
            let shakeAction = SKAction.moveByX(CGFloat(moveX), y: CGFloat(moveY), duration: 1);
            shakeAction.timingMode = SKActionTimingMode.EaseOut;
            actionsArray.append(shakeAction);
            actionsArray.append(shakeAction.reversedAction());
        }
        
        let actionSeq = SKAction.sequence(actionsArray);
        self.runAction(SKAction.repeatActionForever(actionSeq));
    }
    
    func addEffectToHud(){
        self.xScale = 0.2
        self.yScale = 0.2
        
        let scaleEffect = SKTScaleEffect(node: self, duration: 0.5, startScale:CGPointMake(self.xScale, self.yScale), endScale:CGPointMake(1, 1))
        scaleEffect.timingFunction = SKTTimingFunctionBackEaseOut
        
        self.runAction((SKAction.actionWithEffect(scaleEffect)), completion: {})
    }
    
    func addEffectToNode(startPosition:CGPoint, endPosition:CGPoint, delay:NSTimeInterval, action:()){
        let moveEffect = SKTMoveEffect(node: self, duration: 1, startPosition: startPosition, endPosition: endPosition)
        moveEffect.timingFunction = SKTTimingFunctionExponentialEaseInOut
        self.runAction(SKAction.afterDelay(delay, performAction: SKAction.actionWithEffect(moveEffect)), completion: {
            action
        })
    }
    
    
    
    func addRepeatEffectToNode(startPosition:CGPoint, endPosition:CGPoint, delay:NSTimeInterval){
        let moveEffect = SKTMoveEffect(node: self, duration: 1, startPosition: startPosition, endPosition: endPosition)
        moveEffect.timingFunction = SKTTimingFunctionBounceEaseInOut
        self.runAction(SKAction.repeatActionForever(SKAction.afterDelay(delay, performAction: SKAction.actionWithEffect(moveEffect))), completion: {
        })
    }
    
    func addRepeatEffectToNodeWithDuration(startPosition:CGPoint, endPosition:CGPoint, duration:NSTimeInterval){
        let moveEffect = SKTMoveEffect(node: self, duration: duration, startPosition: startPosition, endPosition: endPosition)
        moveEffect.timingFunction = SKTTimingFunctionLinear
        
        //var delay = Int.random(3)
        self.runAction(SKAction.repeatActionForever(SKAction.afterDelay(1.0, performAction: SKAction.actionWithEffect(moveEffect))), completion: {
        })
    }
    
}

extension UIColor {
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

func delay(delay: Double, closure: ()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(),
        closure
    )
}

extension IntervalType {
    public func random() -> Bound {
        let range = (self.end as! Double) - (self.start as! Double)
        let randomValue = (Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX)) * range + (self.start as! Double)
        return randomValue as! Bound
    }
}



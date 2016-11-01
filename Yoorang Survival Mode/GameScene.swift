//
//  GameScene.swift
//  Tetris
//
//  Created by shengxiang guo on 5/17/16.
//  Copyright (c) 2016 shengxiang guo. All rights reserved.
//

import SpriteKit
import AVFoundation

enum GameState {
    case gamePrepare
    case gameStart
    case gamePaused
    case gameOver
}

let player = Player()

class GameScene: SKScene, SKPhysicsContactDelegate {
    //Time dt
    var lastTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    var currentTime: NSTimeInterval = 0
    var oldTime: NSTimeInterval = 0
    
    //HUD
    var hudSurvival:SKSpriteNode!
    var hudMode: SKSpriteNode!
    var invisibleGround: SKSpriteNode!
    
    
    //Backgound
    var backgroundNode:SKSpriteNode!
    
    //Control
    var control: Control!
    
    
    override func didMoveToView(view: SKView) {
        //paused = true
        addPhysics()
        addLayers()
    }
    
    
    func addPhysics(){
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: CGFloat(-5));
    }
    
    func addLayers(){
        
        //add white background
        backgroundNode = SKSpriteNode(color: SKColorWithRGB(255, g: 255, b: 255), size: CGSizeMake(screenWidthNS, screenHeightNS))
        backgroundNode.anchorPoint = CGPointZero
        addChild(backgroundNode)
        
        //add hud
        invisibleGround = SKSpriteNode()
        invisibleGround.position = CGPointMake(screenWidthNS/2, screenHeightNS/4)
        invisibleGround.size = CGSizeMake(screenWidthNS*2, screenHeightNS/4)
        invisibleGround.addPhysicsBodyWithSize(invisibleGround.size, gravity: false, dynamic: false, rotation: false, friction: 10.0, restitution: 0.0, categoryBitMask: groundCategory, contactTestBitMask: hudCategory, collisionBitMask: hudCategory)
        
        hudMode = SKSpriteNode(imageNamed: "mode")
        hudMode.position = CGPointMake(screenWidthNS*1.3/3, screenHeightNS + hudMode.size.height)
        hudMode.zPosition = 1
        hudMode.size = CGSizeMake(screenWidthNS/2, screenWidthNS/2*119/315)
        hudMode.addPhysicsBodyWithSize(hudMode.size, gravity: true, dynamic: true, rotation: true, friction: 10.0, restitution: 0.2, categoryBitMask: hudCategory, contactTestBitMask: hudCategory, collisionBitMask: hudCategory|groundCategory)
        
        hudSurvival = SKSpriteNode(imageNamed: "survival")
        hudSurvival.position = CGPointMake(screenWidthNS*1.01/2, screenHeightNS + hudSurvival.size.height*2.5)
        hudSurvival.zPosition = 1
        hudSurvival.size = CGSizeMake(screenWidthNS/2, screenWidthNS/2*119/315)
        hudSurvival.addPhysicsBodyWithSize(hudSurvival.size, gravity: true, dynamic: false, rotation: true, friction: 10.0, restitution: 0.1, categoryBitMask: hudCategory, contactTestBitMask: hudCategory, collisionBitMask: hudCategory|groundCategory)
        
        backgroundNode.addChild(invisibleGround)
        backgroundNode.addChild(hudMode)
        backgroundNode.addChild(hudSurvival)
        
        player.texture = SKTexture(imageNamed: "p3_walk1")
        player.size = CGSizeMake(screenWidthNS/6, screenWidthNS/6*97/72)
        player.position = CGPointMake(screenWidthNS/2, screenHeightNS/4)
        player.setUpFrames()
        backgroundNode.addChild(player)
        
        control = Control(imageNamed: "Rectangle 1")
        control.size = CGSizeMake(screenWidthNS, screenHeightNS*1/4)
        control.position = CGPointMake(screenWidthNS/2, -screenHeightNS/70)
        control.userInteractionEnabled = true
        backgroundNode.addChild(control)
    }
    
    func addContent(){
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let action = {
            self.hudMode.removeFromParent()
            self.hudSurvival.removeFromParent()
            self.invisibleGround.removeFromParent()
        }
        hudMode.addEffectToHud()
        hudSurvival.addEffectToHud(action)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask{
        case hudCategory | groundCategory :
            delay(0.2, closure: {
                self.hudSurvival.physicsBody?.dynamic = true
            })
        default:
            break
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        if lastTime > 0 {dt = currentTime - lastTime}
        else {dt = 0}
        lastTime = currentTime
        
        player.update(dt)
    }
}



















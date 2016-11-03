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

var player = Player()
let foodLayer = FoodLayer()
var progressBar = ProgressBar()
var timeSpan = 0.0
//Backgound
var backgroundNode:BackgroundLayer!
var gameState = GameState.gamePaused


class GameScene: SKScene, SKPhysicsContactDelegate {
    //Time dt
    var lastTime: NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    var currentTime: NSTimeInterval = 0
    var oldTime: NSTimeInterval = 0
    var oldTime1: NSTimeInterval = 0
    var timer: Timer!
    
    //HUD
    var hudSurvival:SKSpriteNode!
    var hudMode: SKSpriteNode!
    var invisibleGround: SKSpriteNode!
    
    //Control
    var control: Control!
    
    
    
    override func didMoveToView(view: SKView) {
        //paused = true
        addPhysics()
        addLayers()
    }
    
    
    func addPhysics(){
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity);
    }
    
    func addLayers(){
        
        //add white background
        backgroundNode = BackgroundLayer()
        backgroundNode.size = CGSizeMake(screenWidthNS, screenHeightNS)
        backgroundNode.anchorPoint = CGPointZero
        backgroundNode.addBackground()
        addChild(backgroundNode)
        
        //add hud
        invisibleGround = SKSpriteNode()
        invisibleGround.position = CGPointMake(screenWidthNS/2, screenHeightNS/3)
        invisibleGround.size = CGSizeMake(screenWidthNS*2, screenHeightNS/8)
        invisibleGround.addPhysicsBodyWithSize(invisibleGround.size, gravity: false, dynamic: false, rotation: false, friction: 10.0, restitution: 0.0, categoryBitMask: groundCategory, contactTestBitMask: hudCategory, collisionBitMask: hudCategory)
        
        hudMode = SKSpriteNode(imageNamed: "mode")
        hudMode.position = CGPointMake(screenWidthNS*1.3/3, screenHeightNS + hudMode.size.height)
        hudMode.zPosition = 2
        hudMode.size = CGSizeMake(screenWidthNS/2, screenWidthNS/2*119/315)
        hudMode.addPhysicsBodyWithSize(hudMode.size, gravity: true, dynamic: true, rotation: true, friction: 10.0, restitution: 0.2, categoryBitMask: hudCategory, contactTestBitMask: hudCategory, collisionBitMask: hudCategory|groundCategory)
        
        hudSurvival = SKSpriteNode(imageNamed: "survival")
        hudSurvival.position = CGPointMake(screenWidthNS*1.01/2, screenHeightNS + hudSurvival.size.height*2.5)
        hudSurvival.zPosition = 2
        hudSurvival.size = CGSizeMake(screenWidthNS/2, screenWidthNS/2*119/315)
        hudSurvival.addPhysicsBodyWithSize(hudSurvival.size, gravity: true, dynamic: true, rotation: true, friction: 10.0, restitution: 0.1, categoryBitMask: hudCategory, contactTestBitMask: hudCategory, collisionBitMask: hudCategory|groundCategory)
        
        backgroundNode.addChild(invisibleGround)
        backgroundNode.addChild(hudMode)
        delay(0.1) { 
            backgroundNode.addChild(self.hudSurvival)
        }
        
        player = Player()
        player.texture = SKTexture(imageNamed: "p3_walk1")
        player.size = CGSizeMake(screenWidthNS/10, screenWidthNS/10*97/72)
        player.position = CGPointMake(screenWidthNS/2, screenHeightNS/8 + player.size.height/2)
        player.zPosition = 2
        player.setUpFrames()
        player.physicsBody = SKPhysicsBody(texture: player.texture!, alphaThreshold: 0.8, size: player.size)
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.dynamic = true
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.collisionBitMask = groundCategory
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.contactTestBitMask = commonPowerUpCategory | spoilFoodCategory

        backgroundNode.addChild(player)
        
        control = Control(imageNamed: "Rectangle 1")
        control.size = CGSizeMake(screenWidthNS, screenHeightNS/4)
        control.position = CGPointMake(screenWidthNS/2, 0)
        control.zPosition = 100
        control.userInteractionEnabled = true
        control.addPhysicsBodyWithSize(control.size, gravity: false, dynamic: false, rotation: false, friction: 1.0, restitution: 0.3, categoryBitMask: groundCategory, contactTestBitMask: playerCategory | commonPowerUpCategory | spoilFoodCategory, collisionBitMask: commonPowerUpCategory)
        backgroundNode.addChild(control)
        
        timer = Timer(fontNamed: "AvenirNext-Bold")
        timer.fontSize = 25.0
        timer.horizontalAlignmentMode = .Center
        timer.verticalAlignmentMode = .Center
        timer.fontColor = SKColorWithRGB(0, g: 0, b: 0)
        timer.zPosition = 4
        timer.position = CGPointMake(screenWidthNS/2, screenHeightNS*7/8)
        backgroundNode.addChild(timer)
        
        progressBar = ProgressBar(imageNamed: "progressBar")
        progressBar.size = CGSizeMake(screenWidthNS/20, screenWidthNS/20*685/55)
        progressBar.position = CGPointMake(screenWidthNS/7, screenHeightNS/2)
        progressBar.hidden = true
        progressBar.alpha = 0.5
        backgroundNode.addChild(progressBar)
        
        backgroundNode.addChild(foodLayer)
    }
    
    func addContent(){
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if gameState == .gamePaused{
            let action = {
                self.hudMode.removeFromParent()
                self.hudSurvival.removeFromParent()
                self.invisibleGround.removeFromParent()
                gameState = .gameStart
                gravity = CGFloat(-5)
                self.physicsWorld.gravity = CGVector(dx: 0.0, dy: gravity);
                progressBar.hidden = false
            }
            hudMode.addEffectToHud()
            hudSurvival.addEffectToHud(action)
        }else if gameState == .gameOver{
            reset()
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        switch contactMask{

        case commonPowerUpCategory | groundCategory:
            if let nodeA = contact.bodyA.node as? Food{
                if nodeA.landed == false && nodeA.foodType == FoodType.coin{
                    nodeA.openCoinBox()
                }
                if nodeA.landed == false && nodeA.foodType == FoodType.energy{
                    nodeA.openEnergyBox()
                }
                nodeA.landed = true
            }else if let nodeB = contact.bodyB.node as? Food{
                if nodeB.landed == false && nodeB.foodType == FoodType.coin{
                    nodeB.openCoinBox()
                }
                if nodeB.landed == false && nodeB.foodType == FoodType.energy{
                    nodeB.openEnergyBox()
                }
                nodeB.landed = true
            }
            
        case commonPowerUpCategory | playerCategory:
            if let nodeA = contact.bodyA.node as? Food{
                nodeA.collected = true
                if nodeA.foodType == FoodType.snow{
                    nodeA.froze()
                }
            }else if let nodeB = contact.bodyB.node as? Food{
                nodeB.collected = true
                if nodeB.foodType == FoodType.snow{
                    nodeB.froze()
                }
            }else if let nodeA = contact.bodyA.node as? Coin{
                nodeA.collect()
            }else if let nodeB = contact.bodyB.node as? Coin{
                nodeB.collect()
            }else if let nodeA = contact.bodyA.node as? Gem{
                nodeA.collect()
            }else if let nodeB = contact.bodyB.node as? Gem{
                nodeB.collect()
            }

            
        case spoilFoodCategory | playerCategory:
            if let nodeA = contact.bodyA.node as? Player{
                if nodeA.alive{
                    nodeA.alive = false
                    nodeA.die()
                }
            }else if let nodeB = contact.bodyB.node as? Player{
                if nodeB.alive{
                    nodeB.alive = false
                    nodeB.die()
                }
            }

        default:
            break
        }
    }
    
    func reset(){
        foodLayer.removeAllChildren()
        backgroundNode.removeAllChildren()
        self.removeAllChildren()
        foodCounter = 0
        time = 0
        addLayers()
        gravity = -5
        gameState = .gamePaused

    }
    
    override func update(currentTime: CFTimeInterval) {
        if lastTime > 0 {dt = currentTime - lastTime}
        else {dt = 0}
        lastTime = currentTime
        

        
        if gameState == .gameStart{
            if oldTime == 0 {oldTime = currentTime}
            if oldTime1 == 0 {oldTime1 = currentTime}
            
            if currentTime - oldTime >= 2 {
                foodLayer.updatePattern()
                oldTime = 0
            }
            if currentTime - oldTime1 >= 1{
                timer.updateTimer()
                oldTime1 = 0
            }
        }
        
        player.update(dt)
        foodLayer.update(dt)
        backgroundNode.update(dt)
    }
}



















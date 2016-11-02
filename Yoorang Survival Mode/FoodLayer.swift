//
//  FoodLayer.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/2/16.
//  Copyright © 2016 eff employee. All rights reserved.
//

//
//  FoodLayer.swift
//  Yoorang
//
//  Created by eff employee on 10/17/16.
//  Copyright © 2016 eff employee. All rights reserved.
//
import SpriteKit

var pauseGame = false

class FoodLayer: SKSpriteNode {
    
    var lastFoodIndex = -1
    var foodIndex = -1
    var foodPositionIndex = 4
    var lastFoodPositionIndex = -1
    var patternIndex = -1
    
    var sprites = ["pizza","taco","sushi","fries","clock","box","trash","pizza","taco","sushi","fries","box","trash"
        ,"pizza","taco","sushi","fries","box","apple"]
    
    var lanePos5:[CGFloat] = [(screenWidthNS/5)/2, (screenWidthNS/5)*3/2, (screenWidthNS/5)*5/2, (screenWidthNS/5)*7/2, (screenWidthNS/5)*9/2]
    
    var lanePos10:[CGFloat] = [(screenWidthNS/10) - screenWidthNS/20,(screenWidthNS/10)*2 - screenWidthNS/20, (screenWidthNS/10)*3 - screenWidthNS/20,                                                  (screenWidthNS/10)*4 - screenWidthNS/20,(screenWidthNS/10)*5 - screenWidthNS/20, (screenWidthNS/10)*6 - screenWidthNS/20, (screenWidthNS/10)*7 - screenWidthNS/20,(screenWidthNS/10)*8 - screenWidthNS/20, (screenWidthNS/10)*9 - screenWidthNS/20, (screenWidthNS/10)*10 - screenWidthNS/20]
    
    func update(delta: CFTimeInterval) {
        if gameState == .gameStart{
            for child in children{
                child.physicsBody?.dynamic = true
            }
        }
        for child in children{
//            if let child = child as? Food{
//                if !child.landed{
//                    child.position.y -= CGFloat(200*delta)
//                }
//            }
            if let child = child as? Food{
                if child.collected && child.landed{
                    child.removeFromParent()
                }
            }
            
            if child.position.y < 0{
                child.removeFromParent()
            }
        }
    }
    
    func updatePattern(){
            patternIndex = Int.random(5)
            if patternIndex == 0{
                addFoodPattern333()
                timeSpan = 1.4/2
            }else if patternIndex == 1{
                addFoodPattern123654789()
                timeSpan = 1.8/2

            }else if patternIndex == 2{
                addFoodPattern1358()
                timeSpan = 1.8/2

            }else if patternIndex == 3{
                addFoodPattern125689()
                timeSpan = 2.8/2

            }else if patternIndex == 4{
                addFoodPattern246()
                timeSpan = 1.4/2

            }
            //addFood()
            //addFoodPattern246()
            //addFoodPattern123654789()
            //addFoodPattern1358()
            //addFoodPattern125689()
        
        //        else{
        //            if children.count < 1{
        //                addFood()
        //            }
        //        }
        //
    }
    
    func addFood(){
        
        while(foodIndex == lastFoodIndex){
            foodIndex = Int.random(sprites.count)
        }
        
        while(foodPositionIndex == lastFoodPositionIndex){
            foodPositionIndex = Int.random(10)
        }
        
        let food = Food(imageNamed: "\(sprites[6])")
        
        food.position = CGPoint(x: lanePos10[9], y: screenHeightNS)
        food.size = CGSizeMake(screenWidthNS/10, screenWidthNS/10)
        food.zPosition = 4
        food.addPhysicsBodyWithSize(food.size, gravity: false, dynamic: true, rotation: false, friction: 0.0, restitution: 0.0, categoryBitMask: spoilFoodCategory, contactTestBitMask: playerCategory, collisionBitMask: playerCategory)
        self.addChild(food)
        lastFoodIndex = foodIndex
        lastFoodPositionIndex = foodPositionIndex
    }
    
    func createFood(pos: Int){
        var food = Food()
        
        if (Int.random(20) == 18){
            food = Food(imageNamed: "boxCoin")
            food.foodType = .coin
            food.size = CGSizeMake(screenWidthNS/12, screenWidthNS/12)
            food.addPhysicsBodyWithSize(food.size, gravity: true, dynamic: false, rotation: false, friction: 0.0, restitution: 0.3, categoryBitMask: commonPowerUpCategory, contactTestBitMask: playerCategory, collisionBitMask: groundCategory)
        }else if(Int.random(20) == 19){
            food = Food(imageNamed: "snow")
            food.foodType = .snow
            food.size = CGSizeMake(screenWidthNS/12, screenWidthNS/12)
            food.addPhysicsBodyWithSize(food.size, gravity: true, dynamic: false, rotation: false, friction: 0.0, restitution: 0.3, categoryBitMask: commonPowerUpCategory, contactTestBitMask: playerCategory, collisionBitMask: groundCategory)
        }else{
            food.foodType = .food
            food = Food(imageNamed: "\(sprites[5])")
            food.size = CGSizeMake(screenWidthNS/12, screenWidthNS/12)
            food.addPhysicsBodyWithSize(food.size, gravity: true, dynamic: false, rotation: false, friction: 0.0, restitution: 0.0, categoryBitMask: spoilFoodCategory, contactTestBitMask: playerCategory, collisionBitMask: targetCategory)
        }
        food.position = CGPoint(x: lanePos10[pos], y: screenHeightNS)
        food.zPosition = 4

        self.addChild(food)
    }
    
    //0.7+0.7 = 1.4
    func addFoodPattern333(){
        for x in 0...2{
            createFood(x)
        }
        delay(0.7) {
            for x in 3...5{
                self.createFood(x)
            }
            delay(0.7) {
                for x in 6...8{
                    self.createFood(x)
                }
            }
        }
    }
    
    //0.2*9 = 1.8
    func addFoodPattern123654789(){
        createFood(0)
        delay(0.2) {
            self.createFood(1)
            delay(0.2) {
                self.createFood(2)
                delay(0.2) {
                    self.createFood(3)
                    delay(0.2) {
                        self.createFood(6)
                        delay(0.2) {
                            self.createFood(5)
                            delay(0.2) {
                                self.createFood(4)
                                delay(0.2) {
                                    self.createFood(7)
                                    delay(0.2) {
                                        self.createFood(8)
                                        delay(0.2) {
                                            self.createFood(9)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //0.7
    func addFoodPattern246(){
        for x in 0...9{
            if x%3 == 0{
                createFood(x)
            }else if x%3 == 1{
                delay(0.7, closure: {
                    self.createFood(x)
                })
            }else if x%3 == 2{
                delay(1.4, closure: {
                    self.createFood(x)
                })
            }
        }
    }
    
    //0.7*4 =2.8
    func addFoodPattern125689(){
        createFood(0)
        createFood(1)
        delay(0.7) {
            self.createFood(2)
            self.createFood(3)
            delay(0.7) {
                self.createFood(4)
                self.createFood(5)
                delay(0.7) {
                    self.createFood(6)
                    self.createFood(7)
                        delay(0.7) {
                            self.createFood(9)
                            self.createFood(8)
                        }
                }
            }
        }
    }
    
    //0.2*9 = 1.8
    func addFoodPattern1358(){
        createFood(0)
        delay(0.2) {
            self.createFood(3)
            delay(0.2) {
                self.createFood(6)
                delay(0.2) {
                    self.createFood(9)
                    delay(0.2) {
                        self.createFood(2)
                        delay(0.2) {
                            self.createFood(5)
                            delay(0.2) {
                                self.createFood(8)
                                delay(0.2) {
                                    self.createFood(1)
                                    delay(0.2) {
                                        self.createFood(4)
                                        delay(0.2) {
                                            self.createFood(7)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



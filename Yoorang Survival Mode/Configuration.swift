//
//  Configuration.swift
//  SpriteKitIntro
//
//  Created by shengxiang guo on 5/7/16.
//  Copyright © 2016 shengxiang guo. All rights reserved.
//

import SpriteKit

let groundCategory: UInt32 = 0x1 << 1          //

let playerCategory: UInt32 = 0x1 << 2          //monkey - collides with spoiled food, collects comon power up items, contact with instant power up item
let targetCategory: UInt32 = 0x1 << 3          //Not used

let spoilFoodCategory: UInt32 = 0x1 << 4       //spoilFood category - touch to lose 1 life
let commonPowerUpCategory: UInt32 = 0x1 << 5   //common power up category - accumulate 10 piece to trigger invincible button
let instantPowerUpCategory: UInt32 = 0x1 << 6  //instant power up category - instant effects including screen froze, revive etc
let hudCategory: UInt32 = 0x1 << 7

var time = 0                                //Time per level
var gravity:CGFloat = -3
var barFilled = false
var foodCounter = 0

var foodNeeded = 20
var reset = false
var customePause = false
var left = false
var right = false







//let scale = UIScreen.mainScreen().scale
//let screenWidth = UIScreen.mainScreen().bounds.width*scale
//let screenHeight = UIScreen.mainScreen().bounds.height*scale
let screenWidthNS = UIScreen.mainScreen().bounds.width
let screenHeightNS = UIScreen.mainScreen().bounds.height

let SHADOW_COLOR:CGFloat = 157.0/255.0


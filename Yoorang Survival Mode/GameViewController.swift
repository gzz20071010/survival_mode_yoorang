//
//  GameViewController.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/1/16.
//  Copyright © 2016 eff employee. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var scene:GameScene!

        scene = GameScene(size: view.bounds.size)
        
        // Configure the view
        let skView = self.view as! SKView
//                skView.showsFPS = true
//                skView.showsNodeCount = true
//                skView.showsPhysics = true
//        
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .ResizeFill
        //scene.gameDelegate = self

        skView.presentScene(scene)
    }

}

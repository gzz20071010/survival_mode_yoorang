//
//  Timer.swift
//  Yoorang Survival Mode
//
//  Created by eff employee on 11/2/16.
//  Copyright © 2016 eff employee. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class Timer : SKLabelNode
{
    func updateTimer(){
        ++time
        self.text = "Time: \(time)"
    }
}

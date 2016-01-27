//
//  Apple.swift
//  Snake
//
//  Created by seth white on 1/12/16.
//  Copyright © 2016 seth white. All rights reserved.
//

import UIKit
import SpriteKit

class Apple: Item {
    
    override init (){
        super.init()
        path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 10, 10)).CGPath
        fillColor = UIColor.redColor()
        strokeColor = UIColor.redColor()
        lineWidth = 5
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center:CGPoint(x:5, y:5))
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Item
        self.physicsBody?.contactTestBitMask = CollisionCategories.Snake
        self.physicsBody?.collisionBitMask = 0x0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func item_action(snake: Snake){
        NSLog("Item Action method")
        snake.addBodyPart()
    }
}

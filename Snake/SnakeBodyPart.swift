//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by seth white on 1/13/16.
//  Copyright © 2016 seth white. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    
    let BODY_PART_SIZE = 10.0
    
    var actions = Array<SKAction>();
    
    init (atPoint point: CGPoint){
        super.init()
        path = UIBezierPath(ovalInRect: CGRectMake(0, 0, CGFloat(BODY_PART_SIZE), CGFloat(BODY_PART_SIZE))).CGPath
        fillColor = UIColor.greenColor()
        strokeColor = UIColor.greenColor()
        lineWidth = 5
    
        // Set position of Body Part
        self.position = point
        
        // Set the offset of the postion for the Phsyics Body
        // TODO: Fix this to be based on the the size of the body part
        let a_position = CGPoint(x: 5, y:5)
        
        // Initialize the physics body with the correct position and size
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(BODY_PART_SIZE - 4), center: a_position)
        self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Item
        self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func runNextAction(){
        if (self.actions.count > 0){
            self.runAction(self.actions.removeFirst(), completion: self.runNextAction)
        }
    }
}

//
//  SnakeHead.swift
//  Snake
//
//  Created by seth white on 1/14/16.
//  Copyright © 2016 seth white. All rights reserved.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint){
        super.init(atPoint:point)
        
        // Override the Collision detection for the head
        self.physicsBody?.categoryBitMask = CollisionCategories.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Item | CollisionCategories.Snake
        self.physicsBody?.collisionBitMask = CollisionCategories.EdgeBody
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

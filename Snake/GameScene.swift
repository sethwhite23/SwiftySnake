//
//  GameScene.swift
//  Snake
//
//  Created by seth white on 1/6/16.
//  Copyright (c) 2016 seth white. All rights reserved.
//

import SpriteKit

struct CollisionCategories{
    static let Snake :     UInt32 = 0x1 << 0
    static let SnakeHead : UInt32 = 0x1 << 1
    static let Item:       UInt32 = 0x1 << 2
    static let EdgeBody:   UInt32 = 0x1 << 3
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var snake: Snake?
 
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.blackColor()
        
        // Set up game physics
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        self.physicsBody?.allowsRotation = false
         view.showsPhysics = true
        
        /* Set up snake */
        
        setupSnake();
        
        // Create initial item
        
        // Create counter-clockwise button
        let counterClockwiseButton = SKShapeNode()
        counterClockwiseButton.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 45, 45)).CGPath
        counterClockwiseButton.position = CGPointMake(view.scene!.frame.minX+30, view.scene!.frame.minY+30)
        counterClockwiseButton.fillColor = UIColor.grayColor()
        counterClockwiseButton.strokeColor = UIColor.grayColor()
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        
        self.addChild(counterClockwiseButton)
        
        
        // Create clockwise button
        
        let clockwiseButton = SKShapeNode()
        clockwiseButton.path = UIBezierPath(ovalInRect: CGRectMake(0, 0, 45, 45)).CGPath
        clockwiseButton.position = CGPointMake(view.scene!.frame.maxX-80, view.scene!.frame.minY+30)
        clockwiseButton.fillColor = UIColor.grayColor()
        clockwiseButton.strokeColor = UIColor.grayColor()
        clockwiseButton.lineWidth = 10
        clockwiseButton.name = "clockwiseButton"
        
        self.addChild(clockwiseButton)
        
        // Create Game Scene Divider
        
        // Setup initial item
        createNewItem()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if(touchedNode.name == "counterClockwiseButton"){
               NSLog("counterClockwise button pressed")
                snake!.moveCounterClockwise()
            }
            
            if(touchedNode.name == "clockwiseButton"){
                NSLog("clockwise button pressed")
                snake!.moveClockwise()
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        snake!.move()
    }
    
    func setupSnake(){
        NSLog("Setting up snake")
        snake = Snake(atPoint: CGPointMake(view!.scene!.frame.midX, view!.scene!.frame.midY))
        self.addChild(snake!)
    }
    
    func createNewItem(){
        NSLog("Creating new item");
    
        // Get a random point on the screen
        let randX  = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX)) + 1)
        let randY  = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY)) + 1)
        
        NSLog("Item location: x: " + String(randX) + " : y: " + String(randY))
        
        // Create a new Apple for now, but randomize this if we create more item types
        let new_item = Apple()
        let new_item_position = CGPointMake(randX, randY);
        
        new_item.position = new_item_position
        self.addChild(new_item)
    }

    func didBeginContact(contact: SKPhysicsContact) {
        
        NSLog("Inside did begin Contact")
        
        // Do nothing for now
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.SnakeHead != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Item != 0)){
                NSLog("Collision between Snake and Item")
                // Call the item action method
                if let item = secondBody.node as? Item {
                    item.item_action(snake!)
                    item.removeFromParent()
                    createNewItem()
                }
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.SnakeHead != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.EdgeBody != 0)){
                NSLog("Collision between Snake and EdgeBody")
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.Snake != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.SnakeHead != 0)){
                NSLog("Collision between Snake Body and Head")
        }

    }

}

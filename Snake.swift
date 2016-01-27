//
//  Snake.swift
//  Snake
//
//  Created by seth white on 1/6/16.
//  Copyright © 2016 seth white. All rights reserved.
//

import UIKit
import SpriteKit

let π = M_PI

class Snake: SKShapeNode {
    let SPEED = 125.0
    let FOLLOW_DISTANCE = 30.0
    
    var body = [SnakeBodyPart]()
    var angle: CGFloat = 0.0
    
    init (atPoint point: CGPoint){
        super.init()
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(){
        var previousBodyPart: SnakeBodyPart?
        
        for (index, currentBodyPart) in body.enumerate() {
            if (index == 0){
                moveHead(currentBodyPart)
            }
            else{
                if let p = previousBodyPart{
                    moveBodyPart(p, c: currentBodyPart)
                }
            }
            
            previousBodyPart = currentBodyPart
        }

    }
    
    func moveHead(head: SnakeBodyPart){
        let dx = CGFloat(SPEED) * sin(angle);
        let dy = CGFloat(SPEED) * cos(angle);
        let nextPosition = CGPointMake(head.position.x + dx, head.position.y + dy)
        let moveAction = SKAction.moveTo(nextPosition, duration: 1.0)
        
        head.runAction(moveAction)
    }
    
    func moveBodyPart(p: SnakeBodyPart, c: SnakeBodyPart){

        let moveAction = SKAction.moveTo(CGPointMake(p.position.x, p.position.y), duration: 1 )
        
        c.actions.append(moveAction)
        
        if (c.actions.count == 1){
            NSLog("Starting new action sequence")
            c.runAction(c.actions.removeFirst(), completion: c.runNextAction)
        }
    }
    
    func initializeMovement(){
    }
    
    func moveClockwise(){
        angle += CGFloat(π/2)
    }
    
    func moveCounterClockwise(){
        angle -= CGFloat(π/2)
    }
    
    func addBodyPart(){
        // Get the last n
        
        let newBodyPart = SnakeBodyPart(atPoint: CGPointMake(body[0].position.x, body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
}

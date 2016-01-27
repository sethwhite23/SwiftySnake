//
//  Item.swift
//  Snake
//
//  Created by seth white on 1/6/16.
//  Copyright © 2016 seth white. All rights reserved.
//

import UIKit
import SpriteKit

class Item: SKShapeNode {
    
    override init(){
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func item_action(snake: Snake){
        NSLog("Item Action method")
    }
}

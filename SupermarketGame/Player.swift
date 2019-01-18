//
//  Player.swift
//  SupermarketGame
//
//  Created by Mike Moran on 21/12/2018.
//  Copyright © 2018 Mike Moran. All rights reserved.
//

import Foundation
import SpriteKit

enum Direction {
    case up, down, left, right, none
}

enum DesiredDirection {
    case up, down, left, right, none
}

class Player:SKNode {
    
    var objectSprite:SKSpriteNode?
    var currentSpeed:Float = 5.0
    var currentDirection = Direction.none
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init:coder has not been implemented")
    }
    
    override init() {
        super.init()
        
        objectSprite = SKSpriteNode(imageNamed: "trolley_front")
        addChild(objectSprite!)
        
        let physicsBodySize = CGSize(width: objectSprite!.size.width, height: objectSprite!.size.height)
        self.physicsBody = SKPhysicsBody(rectangleOf: physicsBodySize)
        self.physicsBody!.friction = 0 // simulates roughness/smoothness of surface
        self.physicsBody!.isDynamic = true // true keeps object within boundaries better
        self.physicsBody!.restitution = 0 // bounciness when hitting boundaries
        self.physicsBody!.allowsRotation = false // allows physics body to be rotated
    }
    
    public func update() {
        
        switch currentDirection {
        case .right :
            objectSprite?.texture = SKTexture(imageNamed: "trolley_right")
            self.position.x += CGFloat(currentSpeed)
        case .left :
            objectSprite?.texture = SKTexture(imageNamed: "trolley_left")
            self.position.x -= CGFloat(currentSpeed)
        case .up :
            objectSprite?.texture = SKTexture(imageNamed: "trolley_back")
            self.position.y += CGFloat(currentSpeed)
        case .down:
            objectSprite?.texture = SKTexture(imageNamed: "trolley_front")
            self.position.y -= CGFloat(currentSpeed)
        case .none: self.position = CGPoint(x: self.position.x, y: self.position.y)
        }
    }
    
    func goUp() {
        currentDirection = .up
    }
    
    func goDown() {
        currentDirection = .down
    }
    
    func goLeft() {
        currentDirection = .left
    }
    
    func goRight() {
        currentDirection = .right
    }
}

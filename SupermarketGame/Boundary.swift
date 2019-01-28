//
//  Boundary.swift
//  SupermarketGame
//
//  Created by Mike Moran on 28/01/2019.
//  Copyright © 2019 Mike Moran. All rights reserved.
//

import Foundation
import SpriteKit


class Boundary:SKNode  {
    
    /* properties */
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    init (_ theDict:[String: String]) {
        
        super.init()
        
        let x:Int = Int(theDict["x"]!)!
        
        let y:Int = Int(theDict["y"]!)!
        
        let width:Int = Int(theDict["width"]!)!
        
        let height:Int = Int(theDict["height"]!)!
        
        let location:CGPoint = CGPoint(x: x, y: y * -1)
        let size:CGSize = CGSize(width: width, height: height)
        
        self.position = CGPoint(x: location.x + (size.width / 2), y: location.y - (size.height / 2))
        let rect:CGRect = CGRect( x: -(size.width / 2), y: -(size.height / 2), width: size.width, height: size.height)
        
        createBoundary(rect)
        
    }


    func createBoundary(_ rect:CGRect) {
        
        let shape = SKShapeNode(rect: rect, cornerRadius: 19)
        shape.fillColor = SKColor.clear
        shape.strokeColor = SKColor.white
        shape.lineWidth = 1
        
        addChild(shape)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: rect.size)
        self.physicsBody!.isDynamic = false
        self.physicsBody!.categoryBitMask = BodyType.boundary.rawValue
        self.physicsBody!.friction = 0
        self.physicsBody!.allowsRotation = false
        
        self.zPosition = 100
        
        
    }
}

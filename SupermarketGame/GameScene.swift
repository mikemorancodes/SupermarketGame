//
//  GameScene.swift
//  SupermarketGame
//
//  Created by Mike Moran on 21/12/2018.
//  Copyright © 2018 Mike Moran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var playerLocation:CGPoint = CGPoint(x:0,y:0)
    var currentSpeed:Float = 5.0
    var supermarketWorld:SKNode?
    var player:Player?
    
    override func didMove(to view: SKView) {
        
        supermarketWorld = childNode(withName: "supermarketWorld")
        playerLocation = supermarketWorld!.childNode(withName: "startingPoint")!.position
        
        player = Player()
        player!.position = playerLocation
        supermarketWorld!.addChild(player!)
        player!.currentSpeed = currentSpeed
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        player!.update()
    }
}

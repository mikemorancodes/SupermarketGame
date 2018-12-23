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
    var currentSpeed:Float = 2.0
    var supermarketWorld:SKNode?
    var player:Player?
    
    override func didMove(to view: SKView) {
        
        supermarketWorld = childNode(withName: "supermarketWorld")
        playerLocation = supermarketWorld!.childNode(withName: "startingPoint")!.position
        
        player = Player()
        player!.position = playerLocation
        supermarketWorld!.addChild(player!)
        player!.currentSpeed = currentSpeed
        
        addGestureRecognizers(view: view)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    func addGestureRecognizers(view: SKView) {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.handleSwipe))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
    }
    
    @objc func handleSwipe(gesture: UIGestureRecognizer) {
        //add gestures
        let swipeGesture = gesture as? UISwipeGestureRecognizer
        
        switch swipeGesture!.direction {
        case UISwipeGestureRecognizer.Direction.right:
            player!.goRight()
        case UISwipeGestureRecognizer.Direction.left:
            player!.goLeft()
        case UISwipeGestureRecognizer.Direction.up:
            player!.goUp()
        case UISwipeGestureRecognizer.Direction.down:
            player!.goDown()
        default:
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        player!.update()
    }
}

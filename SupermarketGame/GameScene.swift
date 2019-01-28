//
//  GameScene.swift
//  SupermarketGame
//
//  Created by Mike Moran on 21/12/2018.
//  Copyright © 2018 Mike Moran. All rights reserved.
//

import SpriteKit

enum BodyType:UInt32 {
    
    case hero = 1
    case boundary = 2
    case sensorUp = 4
    case sensorDown = 8
    case sensorRight = 16
    case sensorLeft = 32
    case star = 64
    case enemy = 128
    case boundary2 = 256
    
}

class GameScene: SKScene, SKPhysicsContactDelegate, XMLParserDelegate {
    
    var playerLocation:CGPoint = CGPoint(x:0,y:0)
    var currentSpeed:Float = 2.0
    var supermarketWorld:SKNode?
    var player:Player?
    
    override func didMove(to view: SKView) {
        
        view.showsPhysics = true
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
        self.enumerateChildNodes(withName: "*") {
            node, stop in
            
            node.removeFromParent()
            
        }
        
        supermarketWorld = SKNode()
        addChild(supermarketWorld!)
        
//        supermarketWorld = childNode(withName: "supermarketWorld")
//        playerLocation = supermarketWorld!.childNode(withName: "startingPoint")!.position
        
        player = Player()
        player!.position = playerLocation
        supermarketWorld!.addChild(player!)
        player!.currentSpeed = currentSpeed
        
        addGestureRecognizers(view: view)
        
        parseTMXFileWithName("Level1Map")
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
    
    func parseTMXFileWithName(_ name:String) {
        
        let path:String = Bundle.main.path(forResource: name , ofType: "tmx")!
        let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let parser:XMLParser = XMLParser(data: data)
        
        parser.delegate = self
        parser.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        let type:AnyObject? = attributeDict["type"] as AnyObject?
        
        if (type as? String == "Boundary") {
            
            let newBoundary:Boundary = Boundary(attributeDict)
            supermarketWorld!.addChild(newBoundary)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        player!.update()
    }
}

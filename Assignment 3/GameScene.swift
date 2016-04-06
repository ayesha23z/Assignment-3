//
//  GameScene.swift
//  Assignment 3
//
//  Created by Ayesha on 4/3/16.
//  Copyright (c) 2016 Ayesha. All rights reserved.
//  Assignment 3

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let mazeman = SKSpriteNode(imageNamed: "caveman")
    let waterBlock = SKSpriteNode(imageNamed: "water")
    let waterBlock2 = SKSpriteNode(imageNamed: "water")
    let dino4 = SKSpriteNode(imageNamed: "dino4")
    let dino2 = SKSpriteNode(imageNamed: "dino2")
    let dino1 = SKSpriteNode(imageNamed: "dino1")
    let rockText = SKLabelNode(text: "0")
    let livesText = SKLabelNode(text: "3")
    let batteryText = SKLabelNode(text: "90")
    var numberOfRocks = 10
    var percentage = 300
    let fire = SKSpriteNode(imageNamed: "fire")

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let bgImage = SKSpriteNode(imageNamed: "bg.png")
        bgImage.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.addChild(bgImage)
        
        /* Setup your scene here */
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view!.addGestureRecognizer(gestureRecognizer)
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedRight:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedLeft:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedUp:"))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipedDown:"))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        
        mazeman.size = CGSize(width: 64, height: 64)
        mazeman.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        mazeman.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        self.addChild(mazeman)
        mazeman.physicsBody?.categoryBitMask = 2
        mazeman.physicsBody?.collisionBitMask = 1
        mazeman.physicsBody?.contactTestBitMask = 4
        
        for x in 0...15{
            let block = SKSpriteNode(imageNamed: "block")
            block.size = CGSize(width: 64, height: 64)
            block.position = CGPoint(x: (64*x)+32, y: 32)
            self.addChild(block)
        }
        
        for x in 0...15{
            let block = SKSpriteNode(imageNamed: "block")
            block.size = CGSize(width: 64, height: 64)
            block.position = CGPoint(x: CGFloat((64*x)+32), y: frame.size.height - 32)
            self.addChild(block)
        }
        
        for x in 0...15{
            let block = SKSpriteNode(imageNamed: "block")
            block.size = CGSize(width: 64, height: 64)
            block.position = CGPoint(x: CGFloat((64*x)+32), y: frame.size.height - 96)
            self.addChild(block)
        }
        
        let welcomeScreen = SKSpriteNode(imageNamed: "game-status-panel")
        welcomeScreen.size = CGSize(width: frame.size.width - 10, height: 120)
        welcomeScreen.position = CGPoint(x: frame.size.width/2, y: frame.size.height - 65)
        self.addChild(welcomeScreen)

        let welcomeText = SKLabelNode(text: "HELLO, WELCOME TO MAZEMAN!")
        welcomeText.fontSize = 45
        welcomeText.fontName = "Avenir-Heavy"
        welcomeText.position = CGPoint(x: frame.size.width/2, y: frame.size.height - 80)
        self.addChild(welcomeText)
        
        dino2.size = CGSize(width: 64, height: 64)
        dino2.position = CGPoint(x: CGRectGetMaxX(frame) - 32, y: CGRectGetMidY(frame))
        dino2.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        dino2.physicsBody?.collisionBitMask = 0
        dino2.physicsBody?.categoryBitMask = 16
        dino2.physicsBody?.contactTestBitMask = 2
        dino2.xScale = -1
        self.addChild(dino2)
        let random = Double(arc4random_uniform(4) + 1)
        let pause = SKAction.waitForDuration(random)
        let scaleAction = SKAction.scaleXBy(-1, y: 1, duration: 0.5)
        let moveLeft = SKAction.moveByX(-CGRectGetMaxX(frame) + 64, y: 0, duration: 4)
        let sequence2 = SKAction.sequence([scaleAction, pause, moveLeft, scaleAction, pause, moveLeft.reversedAction()])
        dino2.runAction(SKAction.repeatActionForever(sequence2), withKey:  "movingLeft")
        
        dino4.size = CGSize(width: 64, height: 64)
        dino4.position = CGPoint(x: CGRectGetMinX(frame), y: frame.size.height - 96)
        self.addChild(dino4)
        let moveLeftD4 = SKAction.moveByX(CGRectGetMaxX(frame), y: 0, duration: 4)
        let sequence3 = SKAction.sequence([moveLeftD4, moveLeftD4.reversedAction()])
        dino4.runAction(SKAction.repeatActionForever(sequence3), withKey:  "movingLeft")
        
        let star = SKSpriteNode(imageNamed: "star")
        star.size = CGSize(width: 64, height: 64)
        star.position = CGPoint(x: 32, y: 32)
        self.addChild(star)
        //add label over image
        let starText = SKLabelNode(text: "0")
        starText.fontSize = 30
        starText.fontName = "Avenir-Heavy"
        starText.position = CGPoint(x: 32, y: 20)
        self.addChild(starText)

        
        let rock = SKSpriteNode(imageNamed: "rock")
        rock.size = CGSize(width: 60, height: 60)
        rock.position = CGPoint(x: 96, y: 32)
        self.addChild(rock)
        //add label over image
        rockText.fontSize = 30
        rockText.fontName = "Avenir-Heavy"
        rockText.position = CGPoint(x: 96, y: 20)
        self.addChild(rockText)

        
        let lives = SKSpriteNode(imageNamed: "heart")
        lives.size = CGSize(width: 60, height: 60)
        lives.position = CGPoint(x: 160, y: 32)
        self.addChild(lives)
        //add label over image
        livesText.fontSize = 30
        livesText.fontName = "Avenir-Heavy"
        livesText.position = CGPoint(x: 160, y: 20)
        self.addChild(livesText)

        let battery = SKSpriteNode(imageNamed: "battery")
        battery.size = CGSize(width: 110, height: 100)
        battery.position = CGPoint(x: 235, y: 32)
        self.addChild(battery)
        //add label over image
        batteryText.fontSize = 30
        batteryText.fontName = "Avenir-Heavy"
        batteryText.position = CGPoint(x: 235, y: 20)
        self.addChild(batteryText)
        
        waterBlock.size = CGSize(width: 60, height: 64)
        waterBlock.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 10))
        waterBlock.physicsBody?.categoryBitMask = 4
        waterBlock.physicsBody?.collisionBitMask = 0
        waterBlock.position = CGPoint(x: 416, y: 32)
        self.addChild(waterBlock)
        
        waterBlock2.size = CGSize(width: 60, height: 66)
        waterBlock2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 10))
        waterBlock2.physicsBody?.categoryBitMask = 4
        waterBlock2.physicsBody?.collisionBitMask = 0
        waterBlock2.position = CGPoint(x: 736, y: 32)
        self.addChild(waterBlock2)
        
        dino1.size = CGSize(width: 64, height: 64)
        dino1.position = CGPoint(x: 736, y: CGRectGetMinY(frame) + 32)
        dino1.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        dino1.physicsBody?.collisionBitMask = 0
        dino1.physicsBody?.categoryBitMask = 16
        dino1.physicsBody?.contactTestBitMask = 2
        self.addChild(dino1)
        let random2 = Double(arc4random_uniform(4) + 1)
        let pause2 = SKAction.waitForDuration(random2)
        let moveUp = SKAction.moveByX(0, y: CGRectGetMaxY(frame) - 180, duration: 4)
        let sequence = SKAction.sequence([pause2, moveUp, pause2, moveUp.reversedAction()])
        dino1.runAction(SKAction.repeatActionForever(sequence), withKey:  "moving")
        
        self.addChild(fire)
        fire.position = CGPoint(x: -64, y: -64)
        let random3 = Int(arc4random_uniform(6) + 5)
        NSTimer.scheduledTimerWithTimeInterval(Double(random3), target: self, selector: "fireBall", userInfo: nil, repeats: false)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: 60, width: frame.size.width, height: frame.size.height - 64 - 128))//wall
        
        let leftCollision = SKPhysicsBody(edgeFromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: frame.size.height))
        let topCollision = SKPhysicsBody(edgeFromPoint: CGPoint(x: 0, y: frame.size.height - 128), toPoint: CGPoint(x: frame.size.width, y: frame.size.height - 128))
        let rightCollision = SKPhysicsBody(edgeFromPoint: CGPoint(x: frame.size.width, y: 0), toPoint: CGPoint(x: frame.size.width, y: frame.size.height))
        let bottomLeftCollision = SKPhysicsBody(edgeFromPoint: CGPoint(x: 0, y: 64), toPoint: CGPoint(x: 384 - 10, y: 64))
        let bottomCenterCollision = SKPhysicsBody(edgeFromPoint: CGPoint(x: 448 + 10, y: 64), toPoint: CGPoint(x: 704 - 10, y: 64))
        let bottomRightCollision = SKPhysicsBody(edgeFromPoint: CGPoint(x: 768 + 10, y: 64), toPoint: CGPoint(x: frame.size.width, y: 64))
        
        self.physicsBody = SKPhysicsBody(bodies: [leftCollision, rightCollision, topCollision, bottomCenterCollision, bottomLeftCollision, bottomRightCollision])
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = 1
        
        physicsWorld.contactDelegate = self
        NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "addRock", userInfo: nil, repeats: true)

    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        rockText.text = String(numberOfRocks)
        let numberOfLives = Int(ceil(Double(percentage) / 100))
        batteryText.text = String(percentage - ((numberOfLives - 1) * 100))
        livesText.text = String(numberOfLives)
        if numberOfLives < 1{
            gameOverScreen()
        }
    }
    
    func addRock() {
        if numberOfRocks != 20 {
            numberOfRocks = numberOfRocks + 1
        }
    }
    
    func fireBall() {
        fire.size = CGSize(width: 64, height: 64)
        fire.position = dino4.position
        fire.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        fire.physicsBody?.collisionBitMask = 0
        fire.physicsBody?.categoryBitMask = 16
        fire.physicsBody?.contactTestBitMask = 2
        let moveDownFire = SKAction.moveByX(0, y: -200, duration: 1)
        fire.runAction(SKAction.repeatActionForever(moveDownFire), withKey:  "moving")
        let random = Int(arc4random_uniform(6) + 5)
        NSTimer.scheduledTimerWithTimeInterval(Double(random), target: self, selector: "fireBall", userInfo: nil, repeats: false)
    }
    
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        if numberOfRocks > 0 {
            let shootingRocks = SKSpriteNode(imageNamed: "rock")
            shootingRocks.size = CGSize(width: 30, height: 30)
            shootingRocks.position = mazeman.position
            shootingRocks.physicsBody = SKPhysicsBody(circleOfRadius: 15)
            shootingRocks.physicsBody?.categoryBitMask = 8
            shootingRocks.physicsBody?.collisionBitMask = 0
            shootingRocks.physicsBody?.contactTestBitMask = 16
            self.addChild(shootingRocks)
            let tap = gestureRecognizer.locationOfTouch(0, inView: view)
            let location = convertPoint(tap, fromNode: self)
            shootingRocks.physicsBody?.velocity = CGVector(dx:(location.x - shootingRocks.position.x) , dy: (-location.y + shootingRocks.position.y))
            shootingRocks.physicsBody?.linearDamping = 0
            numberOfRocks = numberOfRocks - 1
        }
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        print("swiped right")
        mazeman.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        mazeman.physicsBody?.applyImpulse(CGVector(dx: 15, dy: 0))
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        print("swiped left")
        mazeman.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        mazeman.physicsBody?.applyImpulse(CGVector(dx: -15, dy: 0))
    }
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        print("swiped up")
        mazeman.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        mazeman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 15))
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        print("swiped down")
        mazeman.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        mazeman.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -15))
    }

    
    func gameOverScreen(){
        let gameOverScreen = GameOver(size: scene!.size)
        scene!.view?.presentScene(gameOverScreen, transition: SKTransition.crossFadeWithDuration(1))
    }
    
    func reAddDino(sender : NSTimer) {
        if sender.userInfo as! String == "1" {
            addChild(dino1)
        } else if sender.userInfo as! String == "2" {
            addChild(dino2)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact){
        print("contact")
        if contact.bodyA == waterBlock.physicsBody ||  contact.bodyA == waterBlock2.physicsBody {
            gameOverScreen()
        }
        if contact.bodyB == dino2.physicsBody {
            percentage = percentage - 80
        }
        if contact.bodyB == dino1.physicsBody {
            percentage = percentage - 60
        }
        if contact.bodyB == fire.physicsBody {
            percentage = percentage - 100
        }
        
        
        //for rocks
        if contact.bodyA == dino2.physicsBody {
            dino2.removeFromParent()
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "reAddDino:", userInfo: "2", repeats: false)
        }
        if contact.bodyA == dino1.physicsBody {
            dino1.removeFromParent()
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "reAddDino:", userInfo: "1", repeats: false)
        }
        if contact.bodyA == fire.physicsBody {
            fire.removeFromParent()
            addChild(fire)
            fire.position = CGPoint(x: -64, y: -64)
        }
    }
}

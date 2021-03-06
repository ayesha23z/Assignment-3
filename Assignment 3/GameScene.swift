//
//  GameScene.swift
//  Assignment 3
//
//  Created by Ayesha on 4/3/16.
//  Copyright (c) 2016 Ayesha. All rights reserved.
//  Assignment 3

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    let mazeman = SKSpriteNode(imageNamed: "caveman")
    let waterBlock = SKSpriteNode(imageNamed: "water")
    let waterBlock2 = SKSpriteNode(imageNamed: "water")
    let dino4 = SKSpriteNode(imageNamed: "dino4")
    let dino2 = SKSpriteNode(imageNamed: "dino2")
    let dino1 = SKSpriteNode(imageNamed: "dino1")
    let dino3 = SKSpriteNode(imageNamed: "dino3")
    let welcomeText = SKLabelNode(text: "HELLO, WELCOME TO MAZEMAN!")
    let rockText = SKLabelNode(text: "0")
    let livesText = SKLabelNode(text: "3")
    let batteryText = SKLabelNode(text: "90")
    let starText = SKLabelNode(text: "0")
    let food = SKSpriteNode(imageNamed: "food")
    let star2 = SKSpriteNode(imageNamed: "star")
    var numberOfRocks = 10
    var percentage = 300
    var currentRocks = 0
    var points = 0
    let fire = SKSpriteNode(imageNamed: "fire")
    var gameGrid = [[Bool]]()
    var currentVector: CGVector?
    
    
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
        
        //physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        mazeman.size = CGSize(width: 64, height: 64)
        mazeman.position = CGPoint(x: 32 , y: 96)
        mazeman.xScale = -1
        mazeman.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        mazeman.physicsBody?.affectedByGravity = false
        mazeman.physicsBody?.allowsRotation = false
        self.addChild(mazeman)
        mazeman.physicsBody?.categoryBitMask = 2
        mazeman.physicsBody?.collisionBitMask = 1 | 32
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

        welcomeText.fontSize = 35
        welcomeText.fontName = "Avenir-Heavy"
        welcomeText.position = CGPoint(x: frame.size.width/2, y: frame.size.height - 80)
        self.addChild(welcomeText)
        
        let randomDino2 = Double(arc4random_uniform(9))
        print("random number is \(randomDino2)")
        //var dinoPosDino2 = (randomDino2 * 64) + 96
        dino2.size = CGSize(width: 64, height: 64)
        dino2.position = CGPoint(x: Double(CGRectGetMaxX(frame) - 32), y: (randomDino2 * 64) + 96)
        dino2.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        dino2.physicsBody?.affectedByGravity = false
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
        
        dino3.size = CGSize(width: 64, height: 64)
        dino3.position = CGPoint(x: 32, y: CGRectGetMaxY(frame) - 160)
        dino3.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        dino3.physicsBody?.affectedByGravity = false
        dino3.physicsBody?.collisionBitMask = 1
        dino3.physicsBody?.categoryBitMask = 16
        dino3.physicsBody?.contactTestBitMask = 1 | 2
        dino3.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: 100, dy: 100), duration: 1.0)))
        currentVector = CGVector(dx: 100, dy: 100)
        self.addChild(dino3)
        
        let star = SKSpriteNode(imageNamed: "star")
        star.size = CGSize(width: 64, height: 64)
        star.position = CGPoint(x: 32, y: 32)
        self.addChild(star)
        //add label over image
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
        waterBlock.physicsBody?.affectedByGravity = false
        waterBlock.physicsBody?.categoryBitMask = 4
        waterBlock.physicsBody?.collisionBitMask = 0
        waterBlock.position = CGPoint(x: 416, y: 32)
        self.addChild(waterBlock)
        
        waterBlock2.size = CGSize(width: 60, height: 66)
        waterBlock2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 10))
        waterBlock2.physicsBody?.affectedByGravity = false
        waterBlock2.physicsBody?.categoryBitMask = 4
        waterBlock2.physicsBody?.collisionBitMask = 0
        waterBlock2.position = CGPoint(x: 736, y: 32)
        self.addChild(waterBlock2)
        
        let randomDino = Double(arc4random_uniform(2) + 1)
        print("random number is \(randomDino)")
        
        dino1.size = CGSize(width: 64, height: 64)
        if randomDino == 1{
            dino1.position = CGPoint(x: 416, y: CGRectGetMinY(frame) + 32)
        }else {
            dino1.position = CGPoint(x: 736, y: CGRectGetMinY(frame) + 32)
        }
        dino1.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        dino1.physicsBody?.affectedByGravity = false
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
        
        //game grid
        for i in 1...16 {
            gameGrid.append([Bool]())
            for _ in 1...9 {
                gameGrid[i-1].append(false)
            }
        }
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "gameGridBox", userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "reduceEnergy", userInfo: nil, repeats: true)
       
        food.size = CGSize(width: 64, height: 64)
        food.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 64))
        food.physicsBody?.affectedByGravity = false
        food.physicsBody?.categoryBitMask = 64
        food.physicsBody?.collisionBitMask = 0
        food.physicsBody?.contactTestBitMask = mazeman.physicsBody!.categoryBitMask | 16
        self.addChild(food)
        
        star2.size = CGSize(width: 64, height: 64)
        star2.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 64))
        star2.physicsBody?.affectedByGravity = false
        star2.physicsBody?.categoryBitMask = 64
        star2.physicsBody?.collisionBitMask = 0
        star2.physicsBody?.contactTestBitMask = mazeman.physicsBody!.categoryBitMask
        self.addChild(star2)
        
        var foodx = 0
        var foody = 0
        var starx = 0
        var stary = 0
        
        while(true) {
            foodx = Int(arc4random_uniform(16))
            foody = Int(arc4random_uniform(9))
            if !gameGrid[foodx][foody] {
                gameGrid[foodx][foody] = true
                break
            }
        }
        
        while(true) {
            starx = Int(arc4random_uniform(16))
            stary = Int(arc4random_uniform(9))
            if !gameGrid[starx][stary] {
                gameGrid[starx][stary] = true
                break
            }
        }
        food.position = CGPoint(x: (64 * foodx) + 32, y:(64*foody) + 96)//use this without the x
        star2.position = CGPoint(x: (64 * starx) + 32, y:(64*stary) + 96)
        
        NSTimer.scheduledTimerWithTimeInterval(Double(arc4random_uniform(20)) + 41, target: self, selector: "gravityWarning", userInfo: nil, repeats: true)
        
        NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "reduceEnergy", userInfo: nil, repeats: false)
    }
    
    func gravityWarning() {
        welcomeText.text = "Gravity in 3 seconds"
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "gravity", userInfo: nil, repeats: false)
    }

    func gravity() {
        mazeman.physicsBody?.affectedByGravity = true
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "turnOff", userInfo: nil, repeats: false)
    }

    func turnOff() {
        mazeman.physicsBody?.affectedByGravity = false
    }
    
    func reduceEnergy(){
        percentage = percentage - 1
    }
    
    func gameGridBox() {
        let x = Int(arc4random_uniform(16))
        let y = Int(arc4random_uniform(9))
        if !gameGrid[x][y] {
            gameGrid[x][y] = true
            let block = SKSpriteNode(imageNamed: "block")
            block.size = CGSize(width: 64, height: 64)
            block.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 64, height: 64))
            block.physicsBody?.affectedByGravity = false
            block.physicsBody?.categoryBitMask = 32
            block.physicsBody?.collisionBitMask = 0
            block.position = CGPoint(x: (64 * x) + 32, y:(64*y) + 96)
            self.addChild(block)
            currentRocks = currentRocks + 1
            if currentRocks != 15 {
                NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "gameGridBox", userInfo: nil, repeats: false)
            }
        } else {
            gameGridBox()
        }
    }
    


    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if percentage > 300 {
            percentage = percentage - (percentage - 300)
        }
        rockText.text = String(numberOfRocks)
        let numberOfLives = Int(ceil(Double(percentage) / 100))
        batteryText.text = String(percentage - ((numberOfLives - 1) * 100))
        livesText.text = String(numberOfLives)
        starText.text = String(points)
        if numberOfLives < 1{
            self.runAction(SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: true))
            gameOverScreen()
            
        }
        
        if mazeman.physicsBody?.velocity.dx < 0 {
            mazeman.xScale = 1
        } else {
            mazeman.xScale = -1
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
        fire.physicsBody?.affectedByGravity = false
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
            shootingRocks.physicsBody?.affectedByGravity = false
            shootingRocks.physicsBody?.categoryBitMask = 8
            shootingRocks.physicsBody?.collisionBitMask = 0
            shootingRocks.physicsBody?.contactTestBitMask = 16
            self.addChild(shootingRocks)
            let tap = gestureRecognizer.locationOfTouch(0, inView: view)
            let location = convertPointFromView(tap)
            let x = (location.x - mazeman.position.x)
            let y = (location.y - mazeman.position.y)
            self.runAction(SKAction.playSoundFileNamed("shootRock.aiff", waitForCompletion: false))
            shootingRocks.physicsBody?.velocity = CGVector(dx:x/sqrt(x*x + y*y)*200 , dy: y/sqrt(x*x + y*y)*200)
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
        gameOverScreen.score = points
        self.runAction(SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: false))
        scene!.view?.presentScene(gameOverScreen, transition: SKTransition.crossFadeWithDuration(1))
    }
    
    func deadDinoText(){
            welcomeText.text = "Good job! You've killed a dinosaur!"
    }
    
    func updateWelcomeText(){
        welcomeText.fontSize = 35
        welcomeText.text = "Hurry and get the star!"
    }

    func fireGoneText(){
        welcomeText.text = "Good, you've put out the fire! Keep moving!"
    }
    func gotStarText(){
        welcomeText.fontSize = 30
        welcomeText.text = "You've got the star! Keep going to increase your score!"
    }
    func gotFoodText(){
        welcomeText.fontSize = 30
        welcomeText.text = "You just ate! Remember to keep your energy up!"
    }

    func reAddDino(sender : NSTimer) {
        if sender.userInfo as! String == "1" {
            addChild(dino1)
        } else if sender.userInfo as! String == "2" {
            addChild(dino2)
        } else {
            dino3.removeAllActions()
            dino3.position = CGPoint(x: 32, y: CGRectGetMidY(frame))
            currentVector = CGVector(dx: 100, dy: 100)
            self.addChild(dino3)
            dino3.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: 100, dy: 100), duration: 1.0)))
        }
    }
    
    func reAddStar() {
        var starx = 0
        var stary = 0
        while(true) {
            starx = Int(arc4random_uniform(16))
            stary = Int(arc4random_uniform(9))
            if !gameGrid[starx][stary] {
                gameGrid[starx][stary] = true
                break
            }
        }
        star2.position = CGPoint(x: (64 * starx) + 32, y:(64*stary) + 96)
        addChild(star2)
    }
    
    func reAddFood() {
        var foodx = 0
        var foody = 0
        while(true) {
            foodx = Int(arc4random_uniform(16))
            foody = Int(arc4random_uniform(9))
            if !gameGrid[foodx][foody] {
                gameGrid[foodx][foody] = true
                break
            }
        }
        food.position = CGPoint(x: (64 * foodx) + 32, y:(64*foody) + 96)
        addChild(food)
    }
    //dinos hitting mazeman
    func didBeginContact(contact: SKPhysicsContact){
        print("contact")
        if contact.bodyA == waterBlock.physicsBody ||  contact.bodyA == waterBlock2.physicsBody {
            percentage = 0
        } else if contact.bodyB == dino2.physicsBody && contact.bodyA == mazeman.physicsBody {
            percentage = percentage - 80
            self.runAction(SKAction.playSoundFileNamed("scream.wav", waitForCompletion: false))
        } else if contact.bodyB == dino1.physicsBody && contact.bodyA == mazeman.physicsBody {
            percentage = percentage - 60
            self.runAction(SKAction.playSoundFileNamed("scream.wav", waitForCompletion: false))
        } else if contact.bodyB == fire.physicsBody && contact.bodyA == mazeman.physicsBody {
            percentage = percentage - 100
            self.runAction(SKAction.playSoundFileNamed("scream.wav", waitForCompletion: false))
        } else if contact.bodyA == star2.physicsBody{
            points = points + 1
        } else if contact.bodyB == dino3.physicsBody && contact.bodyA == mazeman.physicsBody {
            percentage = percentage - 100
            self.runAction(SKAction.playSoundFileNamed("scream.wav", waitForCompletion: false))
        }
        
        let random = Double(arc4random_uniform(5) + 1)
        //for rocks hitting dinos
        if contact.bodyA == dino2.physicsBody {
            dino2.removeFromParent()
            self.runAction(SKAction.playSoundFileNamed("death.wav", waitForCompletion: false))
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "deadDinoText", userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(random, target: self, selector: "reAddDino:", userInfo: "2", repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "updateWelcomeText", userInfo: "2", repeats: false)
        } else if contact.bodyA == dino1.physicsBody {
            dino1.removeFromParent()
            self.runAction(SKAction.playSoundFileNamed("death.wav", waitForCompletion: false))
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "deadDinoText", userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(random, target: self, selector: "reAddDino:", userInfo: "1", repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "updateWelcomeText", userInfo: "1", repeats: false)
        } else if contact.bodyA == fire.physicsBody {
            fire.removeFromParent()
            fire.position = CGPoint(x: -64, y: -64)
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "fireGoneText", userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "updateWelcomeText", userInfo: nil, repeats: false)
            addChild(fire)
        } else if contact.bodyA == dino3.physicsBody {
            dino3.removeFromParent()
            self.runAction(SKAction.playSoundFileNamed("death.wav", waitForCompletion: false))
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "deadDinoText", userInfo: nil, repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(random, target: self, selector: "reAddDino:", userInfo: "3", repeats: false)
            NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "updateWelcomeText", userInfo: "3", repeats: false)
        }
        
        //for food and star
        else if contact.bodyA == star2.physicsBody {
            if contact.bodyB == mazeman.physicsBody {
                self.runAction(SKAction.playSoundFileNamed("star.wav", waitForCompletion: false))
                star2.removeFromParent()
                NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "gotStarText", userInfo: nil, repeats: false)
                NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "updateWelcomeText", userInfo: "3", repeats: false)
                reAddStar()
            }
        } else if contact.bodyA == food.physicsBody {
            if contact.bodyB == mazeman.physicsBody {
                food.removeFromParent()
                self.runAction(SKAction.playSoundFileNamed("food.wav", waitForCompletion: false))
                NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "gotFoodText", userInfo: nil, repeats: false)
                NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "updateWelcomeText", userInfo: "3", repeats: false)
                reAddFood()
            } else if contact.bodyB != fire.physicsBody { //this doesn't cover fire
                food.removeFromParent()
                NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "reAddFood", userInfo: nil, repeats: false)
            }
        }
        
        //random dino
        else if contact.bodyB == dino3.physicsBody && contact.bodyA == physicsBody {
            var x = 0
            var y = 0
            if dino3.position.x < 32 {
                x = Int(arc4random_uniform(200))
                y = Int(arc4random_uniform(400)) - 200
            } else if dino3.position.y > CGRectGetMaxY(frame) - 160 {
                x = Int(arc4random_uniform(400)) - 200
                y = -Int(arc4random_uniform(200))
            } else if dino3.position.y < 96 {
                x = Int(arc4random_uniform(400)) - 200
                y = Int(arc4random_uniform(200))
            } else {
                x = -Int(arc4random_uniform(200))
                y = Int(arc4random_uniform(400)) - 200
            }
            if x < 0 {
                dino3.xScale = -1
            } else {
                dino3.xScale = 1
            }
            dino3.removeAllActions()
            dino3.runAction(SKAction.repeatActionForever(SKAction.moveBy(CGVector(dx: x, dy: y), duration: 1.0)))
            
        }
        
        
    }
}

//
//  GameOver.swift
//  Assignment 3
//
//  Created by Ayesha on 4/4/16.
//  Copyright © 2016 Ayesha. All rights reserved.
//

import SpriteKit

class GameOver: SKScene {
    
    let beginNew = SKLabelNode(text: "Begin New Game")
    
    override func didMoveToView(view: SKView) {
        
 
        let currentScore = SKLabelNode(text: "Current Score is")
        currentScore.fontSize = 75
        currentScore.fontName = "Avenir-Heavy"
        //currentScore.fontColor: UIColor(blueColor)
        currentScore.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame) + 100)
        self.addChild(currentScore)
        
        let highScores = SKLabelNode(text: "High Scores")
        highScores.fontSize = 45
        highScores.fontName = "Avenir-Heavy"
        //currentScore.fontColor: UIColor(blueColor)
        highScores.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        self.addChild(highScores)
        
        
        beginNew.fontSize = 45
        beginNew.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)-100)
        beginNew.fontName = "Avenir-Heavy"
        self.addChild(beginNew)
        
    }
    
    func getHighScores(){
        
    }
    
    func beginNewGame(){
        let gameScene = GameScene(size: scene!.size)
        scene!.view?.presentScene(gameScene, transition: SKTransition.crossFadeWithDuration(1))
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if beginNew.containsPoint(location){
                beginNewGame()
            }
        }
    }

    
}

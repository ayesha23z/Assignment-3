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
    let highScoresLabel = SKLabelNode(text: "High Scores")
    var score: Int?
    var highScores: [Int]?
    override func didMoveToView(view: SKView) {
        let currentScore = SKLabelNode(text: "Current Score is \(score!)")
        currentScore.fontSize = 75
        currentScore.fontName = "Avenir-Heavy"
        //currentScore.fontColor: UIColor(blueColor)
        currentScore.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame) + 100)
        self.addChild(currentScore)
        
        highScoresLabel.fontSize = 45
        highScoresLabel.fontName = "Avenir-Heavy"
        //currentScore.fontColor: UIColor(blueColor)
        highScoresLabel.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
        self.addChild(highScoresLabel)
        
        
        beginNew.fontSize = 45
        beginNew.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)-100)
        beginNew.fontName = "Avenir-Heavy"
        self.addChild(beginNew)
        getHighScores()
        
    }
    
    func getHighScores(){
        if var scores = NSUserDefaults.standardUserDefaults().objectForKey("scores") as? [Int] {
            if scores.count == 3 {
                var placeholder: Int = score!
                for (index, element) in scores.enumerate() {
                    if element < placeholder {
                        let temp = scores[index]
                        scores[index] = placeholder
                        placeholder = temp
                        
                    }
                }
            } else {
                scores.append(score!)
            }
            
            highScores = scores
        } else {
            highScores = [score!]
        }
        
        NSUserDefaults.standardUserDefaults().setObject(highScores, forKey: "scores")
        
        if highScores?.count == 3 {
            highScoresLabel.text = "High Scores \(highScores![0]), \(highScores![1]), \(highScores![2])"
        } else if highScores?.count == 2 {
            highScoresLabel.text = "High Scores \(highScores![0]), \(highScores![1])"
        } else {
            highScoresLabel.text = "High Scores \(highScores![0])"
        }
        
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

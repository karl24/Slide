//
//  GameScene.swift
//  Slide
//
//  Created by karl fernando on 12/1/17.
//  Copyright © 2017 Karl Fernando. All rights reserved.
// Now has git!

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate{
    
    private var label : SKLabelNode?
    private var gamePlayLabel : SKLabelNode?
    private var highScoreLabel : SKLabelNode?
    private var bestScoreTextLabel : SKLabelNode?
    private var scoreTextLabel : SKLabelNode?
    private var scoreLabel : SKLabelNode?
    var character = Ball()
    var redObstacle = Obstacle(at: "redObstacle")
    var greenObstacle = Obstacle(at: "greenObstacle")
    var yellowObstacle = Obstacle(at: "yellowObstacle")
    var blueObstacle = Obstacle(at: "blueObstacle")
    var purpleObstacle = Obstacle(at: "purpleObstacle")
    var gameover = false
    var startGame = false
    var score = 0
    let ballMovingSound = SKAction.playSoundFileNamed("ballMovingSound.wav", waitForCompletion: false)
    let ballDieSound = SKAction.playSoundFileNamed("ballDieSound.wav", waitForCompletion: false)
    let scoredOnePointSound = SKAction.playSoundFileNamed("scoredOnePointSound.wav", waitForCompletion: false)
    let backgroundMusic = SKAction.playSoundFileNamed("backgroundMusic.wav",waitForCompletion: true)
    let defaults = UserDefaults.standard
    let action = SKAction.changeVolume(by: 1, duration: Double.infinity)
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 10.0
            
        }
        
        self.gamePlayLabel = self.childNode(withName: "//gamePlayScore") as? SKLabelNode
        if let gamePlayLabel = self.gamePlayLabel {
            gamePlayLabel.alpha = 0.0
            gamePlayLabel.isHidden = true
        }
        
        self.highScoreLabel = self.childNode(withName: "//highScore") as? SKLabelNode
        if let highScoreLabel = self.highScoreLabel {
            if defaults.integer(forKey: "highscore") > score {
                highScoreLabel.text = defaults.string(forKey: "highscore")
            }
            highScoreLabel.alpha = 10.0
        }

        self.bestScoreTextLabel = self.childNode(withName: "//highScoreText") as? SKLabelNode
        if let bestScoreTextLabel = self.bestScoreTextLabel {
            bestScoreTextLabel.alpha = 10.0
        }
        
        self.scoreTextLabel = self.childNode(withName: "//scoreText") as? SKLabelNode
        if let scoreTextLabel = self.scoreTextLabel {
            scoreTextLabel.alpha = 10.0
        }
        
        self.scoreLabel = self.childNode(withName: "//scoreLabel") as? SKLabelNode
        if let scoreLabel = self.scoreLabel {
            scoreLabel.alpha = 10.0
        }
        
        // Allows collision to occur
        physicsWorld.contactDelegate = self
        
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // Adds all the graphics to the screen
        addChild(character.makeBall(at: CGPoint(x: 0, y: 0)))
        addChild(redObstacle.makeObstacle(at: Int(self.size.height), name: "redObstacle"))
        addChild(greenObstacle.makeObstacle(at: Int(self.size.height), name: "greenObstacle"))
        addChild(yellowObstacle.makeObstacle(at: Int(self.size.height), name: "yellowObstacle"))
        addChild(blueObstacle.makeObstacle(at: Int(self.size.height), name: "blueObstacle"))
        addChild(purpleObstacle.makeObstacle(at: Int(self.size.height), name: "purpleObstacle"))
       
        
    
        run(SKAction.repeatForever(backgroundMusic))

  
        
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
     
        destroy(ball: ball)
    }
    
    func destroy(ball: SKNode) {
        print(score)
        
        // SAVES THE HIGH SCORE
        if score > defaults.integer(forKey: "highscore"){
            defaults.set(score, forKey: "highscore")
        }
       
        if ball.name == "ballRed" {
            if let Explosion = SKEmitterNode(fileNamed: "ExplosionRed") {
                Explosion.position = ball.position
                addChild(Explosion)
            
            }
        }
        if ball.name == "ballYellow" {
            if let Explosion = SKEmitterNode(fileNamed: "ExplosionYellow") {
                Explosion.position = ball.position
                addChild(Explosion)
                
            }
        }
        if ball.name == "ballGreen" {
            if let Explosion = SKEmitterNode(fileNamed: "ExplosionGreen") {
                Explosion.position = ball.position
                addChild(Explosion)
                
            }
        }
        if ball.name == "ballBlue" {
            if let Explosion = SKEmitterNode(fileNamed: "ExplosionBlue") {
                Explosion.position = ball.position
                addChild(Explosion)
                
            }
        }
        if ball.name == "ballPurple" {
            if let Explosion = SKEmitterNode(fileNamed: "ExplosionPurple") {
                Explosion.position = ball.position
                addChild(Explosion)
                
            }
        }
        
        if let label = self.label {
            label.run(SKAction.fadeAlpha(to: 10, duration: 4))
            
        }
        if let highScoreLabel = self.highScoreLabel {
            highScoreLabel.run(SKAction.fadeAlpha(to: 10, duration: 4))
            highScoreLabel.text = defaults.string(forKey: "highscore")
            
        }
        
        if let gamePlayLabel = self.gamePlayLabel {
            gamePlayLabel.isHidden = true
        }
        
        if let bestScoreTextLabel = self.bestScoreTextLabel {
            bestScoreTextLabel.run(SKAction.fadeAlpha(to: 10, duration: 4))
            
        }
        
        if let scoreTextLabel = self.scoreTextLabel {
            scoreTextLabel.run(SKAction.fadeAlpha(to: 10, duration: 4))
            
        }
        
        if let scoreLabel = self.scoreLabel {
            scoreLabel.run(SKAction.fadeAlpha(to: 10, duration: 4))
            scoreLabel.text = String(score)
            
        }
        run(SKAction.group([ballDieSound,action]))
        startGame = false
        gameover = true
        ball.isHidden = true
        ball.physicsBody?.isDynamic = false
    
        
    }
    
    func didBegin(_ contact: SKPhysicsContact){
  
        guard let nodeA = contact.bodyA.node else {
            return
        }
        guard let nodeB = contact.bodyB.node else {
            return
        }
        
        
        if nodeB.name == "ballRed" || nodeB.name == "ballBlue" || nodeB.name == "ballGreen" || nodeB.name == "ballYellow" || nodeB.name == "ballPurple"{
            collisionBetween(ball: nodeB, object: nodeA)
        }
        
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Once you touch the screen, game starts
        startGame = true
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        // resets the ball to the middle of the screen for a new game
        if gameover == true {
            character.ball.isHidden = false
            character.ball.position.x = 0
            character.ball.position.y = 0
            gameover = false
        }
    
     
        
        // Moves the ball left and right
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.x < 0){
                character.moveBallLeft()
                run(SKAction.group([ballMovingSound,action]))
            }
            else {
                character.moveBallRight()
                run(SKAction.group([ballMovingSound,action]))
            }
        }

        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // If the game is started, move the obstacles down
        if startGame == true {
            // the Title will fade away once the game starts
            if let label = self.label {
                label.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
                
            }
            if let highScoreLabel = self.highScoreLabel {
                highScoreLabel.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
            }
            if let gamePlayLabel = self.gamePlayLabel {
                gamePlayLabel.isHidden = false
                gamePlayLabel.run(SKAction.fadeAlpha(to: 10, duration: 0.5))
                
            }
            if let bestScoreTextLabel = self.bestScoreTextLabel {
                bestScoreTextLabel.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
                
            }
            if let scoreTextLabel = self.scoreTextLabel {
                scoreTextLabel.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
            }
            
            if let scoreLabel = self.scoreLabel {
                scoreLabel.run(SKAction.fadeAlpha(to: 0, duration: 0.5))
            }

            
            redObstacle.moveObstacle(at: self.size.height,at: -self.size.height/2)
            greenObstacle.moveObstacle(at: self.size.height, at: -self.size.height/2)
            yellowObstacle.moveObstacle(at: self.size.height, at: -self.size.height/2)
            blueObstacle.moveObstacle(at: self.size.height, at: -self.size.height/2)
            purpleObstacle.moveObstacle(at: self.size.height, at: -self.size.height/2)
        }
        // Changes the obstacles to different positions and change the ball color
        if redObstacle.obstacle.position.y <= -self.size.height/2 + redObstacle.obstacle.size.height {
            redObstacle.changeXPosition(at: self.size.height)
            greenObstacle.changeXPosition(at: self.size.height)
            yellowObstacle.changeXPosition(at: self.size.height)
            blueObstacle.changeXPosition(at: self.size.height)
            purpleObstacle.changeXPosition(at: self.size.height)
            character.changeBallColor()
            score+=1
            run(SKAction.group([scoredOnePointSound,action]))
            if let gamePlayLabel = self.gamePlayLabel {
                gamePlayLabel.isHidden = false
                gamePlayLabel.text = String(score)
                
            }
            // Makes the obstacles move faster every time
            redObstacle.increaseObstacleSpeed()
            greenObstacle.increaseObstacleSpeed()
            yellowObstacle.increaseObstacleSpeed()
            blueObstacle.increaseObstacleSpeed()
            purpleObstacle.increaseObstacleSpeed()
            
            

        }
        
        // Resets the obstacles
        if startGame == false {
            redObstacle.obstacle.position.y = self.size.height
            greenObstacle.obstacle.position.y = self.size.height
            yellowObstacle.obstacle.position.y = self.size.height
            blueObstacle.obstacle.position.y = self.size.height
            purpleObstacle.obstacle.position.y = self.size.height
            score = 0
            if let gamePlayLabel = self.gamePlayLabel {
                gamePlayLabel.isHidden = true
                gamePlayLabel.text = String(score)
            }
            redObstacle.resetObstacleSpeed()
            greenObstacle.resetObstacleSpeed()
            yellowObstacle.resetObstacleSpeed()
            blueObstacle.resetObstacleSpeed()
            purpleObstacle.resetObstacleSpeed()
        }
        
        // Turns off the obstacle that the ball needs to go thru
        if character.ball.name == "ballRed" {
            redObstacle.turnOffObstacleCollision()  
            turnOnObstacleCollision(firstObstacle: blueObstacle, secondObstacle: yellowObstacle, thirdObstacle: greenObstacle, fourthObstacle: purpleObstacle)
        }
        if character.ball.name == "ballBlue" {
            blueObstacle.turnOffObstacleCollision()
            turnOnObstacleCollision(firstObstacle: redObstacle, secondObstacle: yellowObstacle, thirdObstacle: greenObstacle, fourthObstacle: purpleObstacle)
        }
        if character.ball.name == "ballYellow" {
            yellowObstacle.turnOffObstacleCollision()
            turnOnObstacleCollision(firstObstacle: blueObstacle, secondObstacle: redObstacle, thirdObstacle: greenObstacle, fourthObstacle: purpleObstacle)
        }
        if character.ball.name == "ballGreen" {
            greenObstacle.turnOffObstacleCollision()
            turnOnObstacleCollision(firstObstacle: blueObstacle, secondObstacle: yellowObstacle, thirdObstacle: redObstacle, fourthObstacle: purpleObstacle)
        }
        if character.ball.name == "ballPurple" {
            purpleObstacle.turnOffObstacleCollision()
            turnOnObstacleCollision(firstObstacle: blueObstacle, secondObstacle: yellowObstacle, thirdObstacle: greenObstacle, fourthObstacle: redObstacle)
        }
        
        
    }

    
    
    func turnOnObstacleCollision(firstObstacle: Obstacle, secondObstacle: Obstacle, thirdObstacle: Obstacle, fourthObstacle: Obstacle) {
        
        firstObstacle.turnOnObstacleCollision()
        secondObstacle.turnOnObstacleCollision()
        thirdObstacle.turnOnObstacleCollision()
        fourthObstacle.turnOnObstacleCollision()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
       
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }

    
    
    
   }

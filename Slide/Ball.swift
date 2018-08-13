//
//  Ball.swift
//  Slide
//
//  Created by karl fernando on 12/2/17.
//  Copyright © 2017 Karl Fernando. All rights reserved.
//


import Foundation
import SpriteKit
import GameKit

class Ball {
    
    
    var ball = SKSpriteNode(imageNamed: "ballRed")
    
    func makeBall(at position: CGPoint)-> SKSpriteNode {
        
        ball.position = position
        // creates the collision recognition
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
        ball.physicsBody?.isDynamic = false
        ball.name = "ballRed"
        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
        return ball
    }
    
    func moveBallRight() {
        ball.physicsBody?.isDynamic = false
        let jumpUpAction = SKAction.moveBy(x: 100, y: 300, duration: 0.3)
        let jumpSequence = SKAction.sequence([jumpUpAction])
        ball.run(jumpSequence)
        ball.physicsBody?.isDynamic = true
    }
    
    func moveBallLeft() {
        ball.physicsBody?.isDynamic = false
        let jumpUpAction = SKAction.moveBy(x: -100, y: 300, duration: 0.3)
        let jumpSequence = SKAction.sequence([jumpUpAction])
        ball.run(jumpSequence)
        ball.physicsBody?.isDynamic = true
    }
    
    func changeBallColor() {
        let random = Int(arc4random_uniform(UInt32(5))+1)
        if random == 1 {
            ball.name = "ballBlue"
            ball.texture = SKTexture(imageNamed: "ballBlue")
        }else if random == 2 {
            ball.name = "ballRed"
            ball.texture = SKTexture(imageNamed: "ballRed")
        }else if random == 3 {
            ball.name = "ballYellow"
            ball.texture = SKTexture(imageNamed: "ballYellow")
        }else if random == 4 {
            ball.name = "ballPurple"
            ball.texture = SKTexture(imageNamed: "ballPurple")
        }else if random == 5 {
            ball.name = "ballGreen"
            ball.texture = SKTexture(imageNamed: "ballGreen")
        }
    }
    
}

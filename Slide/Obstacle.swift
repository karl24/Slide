//
//  Obstacle.swift
//  Slide
//
//  Created by karl fernando on 12/3/17.
//  Copyright © 2017 Karl Fernando. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit


class Obstacle {
    var obstacle = SKSpriteNode(imageNamed: "obstacle")
    
    static var xValues = [-256,-128,0,128,256]
    static var resetArray = false
    init(at color: String) {
        obstacle = SKSpriteNode(imageNamed: color)
        
    }
  
    var speed = CGFloat(-3.0)
    
    func makeObstacle(at positionY: Int, name n: String)-> SKSpriteNode {
        //obstacle.position = position
        let random = Int(arc4random_uniform(UInt32(Obstacle.xValues.count)))
        obstacle.position = CGPoint(x: Obstacle.xValues[random], y: positionY)
        Obstacle.xValues.remove(at: random)
        //obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.frame.size)
        obstacle.physicsBody?.isDynamic = false
        obstacle.name = n
        Obstacle.resetArray = true
        return obstacle
    }
    
    func resetObstacleSpeed() {
        speed = -3
    }
    
    func increaseObstacleSpeed() {
        if speed >= -6 {
            speed-=0.2
        }
    }
    
    static func randomHorizontalMovement() -> CGFloat{
        return CGFloat(arc4random_uniform(UInt32(20)))
    }
    
    func moveObstacleHorizontallyOnReset(amount a: CGFloat) {
        obstacle.position.x += a
    }
    
    func moveObstacleHorizontallyContinuous() {
        
    }
    
    func turnOnObstacleCollision() {
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.frame.size)
        obstacle.physicsBody?.isDynamic = false
    }
    
    func turnOffObstacleCollision() {
        obstacle.physicsBody?.collisionBitMask = 0
        obstacle.physicsBody?.contactTestBitMask = 0
        obstacle.physicsBody?.categoryBitMask = 0 
    }
    
    func moveObstacle(at position: CGFloat, at bottom: CGFloat) {
        if obstacle.position.y > bottom + obstacle.size.height {
            obstacle.position.y.add(speed)
        }else {
            obstacle.position.y = position
        }
        
    }
    
    
    func changeXPosition(at positionY: CGFloat) {
        if Obstacle.resetArray == true {
            Obstacle.xValues = [-256,-128,0,126,256]
            Obstacle.resetArray = false
        }
        let random = Int(arc4random_uniform(UInt32(Obstacle.xValues.count)))
        obstacle.position = CGPoint(x: Obstacle.xValues[random], y: Int(positionY))
        Obstacle.xValues.remove(at: random)
        
        if(Obstacle.xValues.count == 0) {
            Obstacle.resetArray = true
        }
    }
}

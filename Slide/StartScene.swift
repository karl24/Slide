//
//  StartScene.swift
//  Slide
//
//  Created by karl fernando on 12/12/17.
//  Copyright © 2017 Karl Fernando. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    private var EntertainmentLabel : SKLabelNode?
    var MainYoyo = SKSpriteNode()
    
    var TextureAtlas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    var reverse = false
    
    override func didMove(to view: SKView) {
 
        self.EntertainmentLabel = self.childNode(withName: "//Entertainment") as? SKLabelNode
        self.EntertainmentLabel?.run(SKAction.fadeIn(withDuration: 3))
        
        TextureAtlas = SKTextureAtlas(named:"yoyo")
        
        for i in 1...TextureAtlas.textureNames.count{
            let name = "yoyo\(i).png"
            TextureArray.append(SKTexture(imageNamed:name))
            
        }
        
        MainYoyo = SKSpriteNode(imageNamed: "yoyo1.png" )
        
        MainYoyo.size = CGSize(width: 350, height: 500)
        MainYoyo.position = CGPoint(x: -60, y: -200)
        self.addChild(MainYoyo)
        
        var gameScene = GameScene(size: view.bounds.size)
        // Setting a file for that scene
        gameScene = GameScene(fileNamed: "GameScene")!
        // Setting the scale
        gameScene.scaleMode = SKSceneScaleMode.aspectFill
        let action1 = SKAction.animate(with: TextureArray, timePerFrame: 0.04)
        let action2 = SKAction.animate(with: TextureArray.reversed(), timePerFrame: 0.04)
        let actionSequence = SKAction.sequence([action1,action2])
        MainYoyo.run(actionSequence, completion: {
            self.scene?.view?.presentScene(gameScene, transition: SKTransition.fade(withDuration: 0.5))
            
            
        })
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       

        
        
    }
    
}

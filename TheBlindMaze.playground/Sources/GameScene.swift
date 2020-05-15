import Foundation
import SpriteKit
import UIKit

public class GameScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "MapaCompleto.png")
    let blackoutMap = SKSpriteNode(imageNamed: "MapaBlackout.png")
    let char = SKSpriteNode(imageNamed: "CharDown1.png")
    let end = SKSpriteNode(imageNamed: "Objetivo.png")
    let gamepad = SKSpriteNode(imageNamed: "BackgroundGamepad.png")
    let ground = SKSpriteNode(imageNamed: "Ground.png")
    
    var charToRight: [SKTexture] = []
    var charToLeft: [SKTexture] = []
    var charToDown: [SKTexture] = []
    var charToUp: [SKTexture] = []
    
    
    var blackoutButton: SKButtonNode?
    
    var matrix:Matrix = Matrix()
    var line = 0
    var column = 0
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
        matrix.map = Matrix.firstLevel()
        
        self.blackoutMap.scale(to: CGSize(width: 700, height: 625))
        self.blackoutMap.position = CGPoint(x: 0, y: 0)
        self.blackoutMap.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(blackoutMap)
        
        self.ground.scale(to:CGSize(width: 90, height: 90))
        self.ground.position = CGPoint(x:5, y:510)
        self.ground.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(ground)
        
        self.end.scale(to: CGSize(width: 80, height: 80))
        self.end.position = CGPoint(x: 610, y: 535)
        self.end.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(end)
        
        self.gamepad.scale(to: CGSize(width: 95, height: 95))
        self.gamepad.position = CGPoint(x: 130, y: 50)
        self.addChild(gamepad)
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        self.char.position = CGPoint(x: 5, y: 540)
        self.char.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(char)
        
        self.backgroundColor = .black
        self.createGamepad()
        
    }
    
    func createGamepad(){
        
        let rightButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadRight.png"), label: .init(text: "")) {
            
            self.moveRight()
        }
        
        let leftButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadLeft.png"), label: .init(text: "")) {
            
            self.moveLeft()
        }
        
        let downButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadDown.png"), label: .init(text: "")) {
            
            self.moveDown()
        }
        
        let upButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadUp.png"), label: .init(text: "")) {
            
            self.moveUp()
        }
        
        rightButton.position = CGPoint(x: 156, y:53)
        leftButton.position = CGPoint(x: 105, y:53)
        downButton.position = CGPoint(x: 131, y:27)
        upButton.position = CGPoint(x:131, y: 80)
                
        rightButton.setScale(0.25)
        leftButton.setScale(0.25)
        downButton.setScale(0.25)
        upButton.setScale(0.25)

        self.addChild(rightButton)
        self.addChild(leftButton)
        self.addChild(downButton)
        self.addChild(upButton)
        
    }
    
    func moveRight(){
        self.column += 1
        
        if(self.column >= self.matrix.map[self.line].count){
            print("Invalid position!")
            self.column -= 1
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
        }
        else if(self.matrix.map[self.line][self.column]){
            print("You lost!")
            self.char.position = CGPoint(x: 5, y: 540)
            self.ground.position = CGPoint(x: 5, y: 510)
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
            self.line = 0
            self.column = 0
        }
        else{
            let prefix = "CharRight"
            let ids = [1,2,1,3,1,2,1,3]
            var animation: [SKTexture] = []
            
            let toRight = SKAction.moveBy(x: 100, y: 0, duration: 1.0)
            
            for i in ids {
                let pose = SKTexture(imageNamed: "\(prefix)\(i)")
                animation.append(pose)
            }
            
            self.charToRight = animation
            
            self.char.scale(to: CGSize(width: 90, height: 90))
            
            self.char.run(SKAction.animate(with: self.charToRight, timePerFrame: 0.125, resize: false, restore: true))
            self.char.run(toRight)
            
            self.char.texture = SKTexture(imageNamed: "CharRight1.png")
            
            self.ground.run(toRight)

        }
        
    }
    
    func moveLeft(){
        self.column -= 1
        
        if(self.column < 0){
            print("Invalid position!")
            self.column += 1
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
        }
        else if(self.matrix.map[self.line][self.column]){
            print("You lost!")
            self.char.position = CGPoint(x: 5, y: 540)
            self.ground.position = CGPoint(x: 5, y: 510)
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
            self.line = 0
            self.column = 0
        }
        else{
            let prefix = "CharLeft"
            let ids = [1,2,1,3,1,2,1,3]
            var animation: [SKTexture] = []
            
            let toLeft = SKAction.moveBy(x: -100, y: 0, duration: 1.0)
            
            for i in ids {
                let pose = SKTexture(imageNamed: "\(prefix)\(i)")
                animation.append(pose)
            }
            
            self.charToLeft = animation
            
            self.char.scale(to: CGSize(width: 90, height: 90))
            
            self.char.run(SKAction.animate(with: self.charToLeft, timePerFrame: 0.125, resize: false, restore: true))
            self.char.run(toLeft)
            
            self.char.texture = SKTexture(imageNamed: "CharLeft1.png")
            self.ground.run(toLeft)

        }
    }
    
    func moveDown(){
        self.line += 1
        
        if(self.line >= self.matrix.map.count){
            print("Invalid position!")
            self.line -= 1
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
        }
        else if(self.matrix.map[self.line][self.column]){
            print("You lost!")
            
            let sceneMoveTo = LoserScene(size: self.size)
            sceneMoveTo.scaleMode = self.scaleMode
            
            let transition = SKTransition.moveIn(with: .down, duration: 0.3)
            self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
            
            self.char.position = CGPoint(x: 5, y: 540)
            self.ground.position = CGPoint(x: 5, y: 510)
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
            self.line = 0
            self.column = 0
        }
        else{
            let prefix = "CharDown"
            let ids = [1,2,1,3,1,2,1,3]
            var animation: [SKTexture] = []
            
            let toDown = SKAction.moveBy(x: 0, y: -100, duration: 1.0)
            
            for i in ids {
                let pose = SKTexture(imageNamed: "\(prefix)\(i)")
                animation.append(pose)
            }
            
            self.charToDown = animation
            
            self.char.scale(to: CGSize(width: 90, height: 90))
            
            self.char.run(SKAction.animate(with: self.charToDown, timePerFrame: 0.125, resize: false, restore: true))
            self.char.run(toDown)
            self.char.texture = SKTexture(imageNamed: "CharDown1.png")
            
            self.ground.run(toDown)


        }
    }
    
    func moveUp(){
        self.line -= 1
        
        if(self.line < 0){
            print("Invalid position!")
            self.line += 1
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
        }
        else if(self.matrix.map[self.line][self.column]){
            print("You lost!")
            self.char.position = CGPoint(x: 5, y: 540)
            self.ground.position = CGPoint(x: 5, y:510)
            print("map[\(self.line)][\(self.column)] = \(self.matrix.map[self.line][self.column])")
            self.line = 0
            self.column = 0
        }
        else{
            let prefix = "CharUp"
            let ids = [1,2,1,3,1,2,1,3]
            var animation: [SKTexture] = []
            
            let toUp = SKAction.moveBy(x: 0, y: 100, duration: 1.0)
            
            for i in ids {
                let pose = SKTexture(imageNamed: "\(prefix)\(i)")
                animation.append(pose)
            }
            
            self.charToUp = animation
            
            self.char.scale(to: CGSize(width: 90, height: 90))
            
            self.char.run(SKAction.animate(with: self.charToUp, timePerFrame: 0.125, resize: false, restore: true))
            self.char.run(toUp)
            self.char.texture = SKTexture(imageNamed: "CharUp1.png")
            
            self.ground.run(toUp)

        }
    }
}

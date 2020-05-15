import Foundation
import SpriteKit
import UIKit

public class GameScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "MapaCompleto.png")
    let blackoutMap = SKSpriteNode(imageNamed: "MapaBlackout.png")
    let char = SKSpriteNode(imageNamed: "CharDown1.png")
    let end = SKSpriteNode(imageNamed: "Objetivo.png")
    let gamepad = SKSpriteNode(imageNamed: "BackgroundGamepad.png")
    
    var charToRight: [SKTexture] = []
    var charToLeft: [SKTexture] = []
    var charToDown: [SKTexture] = []
    var charToUp: [SKTexture] = []
        
    var matrix:Matrix = Matrix()
    var line = 0
    var column = 0
    
    var timeLabel = SKLabelNode(text: "")
    var count = 60
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
        matrix.map = Matrix.firstLevel()
        self.backgroundColor = .black
        
        self.blackoutMap.scale(to: CGSize(width: 700, height: 625))
        self.blackoutMap.position = CGPoint(x: 0, y: 0)
        self.blackoutMap.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(blackoutMap)
        
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
        
        self.createGamepad()
        self.createTimeLabel()
        self.setTimer()
        
    }
    
    func createGamepad(){
        
        let rightButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadRight.png"), label: .init(text: "")) {
            
            self.moveRight()
        }
        print("Right")
        
        let leftButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadLeft.png"), label: .init(text: "")) {
            
            self.moveLeft()
        }
        print("Left")
        
        let downButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadDown.png"), label: .init(text: "")) {
            
            self.moveDown()
        }
        print("Down")
        
        let upButton = SKButtonNode(image: SKSpriteNode(imageNamed: "GamepadUp.png"), label: .init(text: "")) {
            
            self.moveUp()
        }
        print("Up")
        
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
            self.lost()
            
            self.char.position = CGPoint(x: 5, y: 540)
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
            self.lost()
            
            self.char.position = CGPoint(x: 5, y: 540)
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
            self.lost()
            
            self.char.position = CGPoint(x: 5, y: 540)
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
            self.lost()
            
            self.char.position = CGPoint(x: 5, y: 540)
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
    
        }
    }
    
    func setTimer(){
        let wait = SKAction.wait(forDuration: 1)
        let block = SKAction.run({
            [unowned self] in

            if self.count > 0{
                self.count -= 1
            }else{
                self.removeAction(forKey: "countdown")
                self.lost()
            }
        })
        
        let sequence = SKAction.sequence([wait,block])

        run(SKAction.repeatForever(sequence), withKey: "countdown")
    }
    
    func createTimeLabel(){
                
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 14)
        
        var nameString = NSMutableAttributedString(string: "TIME LEFT: \(count) s", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 14, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        
        timeLabel.attributedText = nameString
        timeLabel.position = CGPoint(x: 500, y: 50)
        
        self.timeLabel.run(.repeatForever(.sequence([.run{nameString = NSMutableAttributedString(string: "TIME LEFT: \(self.count) s", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 14, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]) ; self.self.timeLabel.attributedText = nameString}, .wait(forDuration: 1)])))
        
        self.addChild(timeLabel)
    }
    
    func lost(){
        let sceneMoveTo = LoserScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        
        let transition = SKTransition.moveIn(with: .down, duration: 0.3)
        self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
    }
}

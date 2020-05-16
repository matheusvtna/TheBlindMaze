import Foundation
import SpriteKit
import UIKit

public class TutorialScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "MapaCompleto.png")
    let menuBackground = SKSpriteNode(imageNamed: "MenuBackgroundBlackout.png")
    let char = SKSpriteNode(imageNamed: "CharDown1.png")
    
    var tutorialLabel = SKLabelNode(text: "")
    
    var buttonOk = SKShapeNode()
    var buttonOkLabel = SKLabelNode()
            
    let blackoutButton = SKShapeNode()
    let blackoutButtonLabel = SKLabelNode()
    
    var timeLabel = SKLabelNode(text: "")
    var count = 30
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.map.scale(to: CGSize(width: 700, height: 625))
        self.map.position = CGPoint(x: 0, y: 0)
        self.map.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(map)
        
        self.menuBackground.scale(to: CGSize(width: 700, height: 625))
        self.menuBackground.anchorPoint = CGPoint(x:0, y:0)
        self.menuBackground.position = CGPoint(x:0, y:0)
        self.addChild(menuBackground)
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        self.char.anchorPoint = CGPoint(x:0, y:0)
        self.char.position = CGPoint(x: self.frame.midX - 45, y: 110)
        self.addChild(char)
        
        self.backgroundColor = .black
        
        self.createTutorialLabel()
        self.createButtonOk()
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if self.buttonOk.contains(touchLocation) {
            self.char.removeFromParent()
            self.tutorialLabel.removeFromParent()
            self.menuBackground.removeFromParent()
            self.buttonOk.removeFromParent()
            self.buttonOkLabel.removeFromParent()
            
            self.createBlackoutButton()
            self.createTimeLabel()
            self.setTimer()
        }
        else if self.blackoutButton.contains(touchLocation){
            self.blackout()
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
                self.blackout()
            }
        })
        
        let sequence = SKAction.sequence([wait,block])

        run(SKAction.repeatForever(sequence), withKey: "countdown")
    }
    
    func createBlackoutButton(){
        let pixeledFont = UIFont(name: "Pixeled", size: 18)

        let blackoutButtonString = NSMutableAttributedString(string: "BLACKOUT", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 20, weight: .ultraLight), .foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        self.blackoutButton.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 60), cornerRadius: 20).cgPath
        self.blackoutButton.position = CGPoint(x:130, y:30)
        self.blackoutButton.fillColor = .black
        self.blackoutButton.lineWidth = 1
        self.blackoutButton.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.blackoutButtonLabel.attributedText = blackoutButtonString
        self.blackoutButtonLabel.position = CGPoint(x: blackoutButton.frame.midX, y: blackoutButton.frame.midY - 15)
        
        self.addChild(blackoutButton)
        self.addChild(blackoutButtonLabel)
    }
    
    func createTutorialLabel(){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 14)
        
        let nameString = NSMutableAttributedString(string: "WELCOME TO THE BLIND MAZE.\nYOU HAVE 30 SECONDS UNTIL NIGHTFALL. SO, MEMORIZE ALL THE OBSTACLES IN THE MAP TO GUIDE FULANINHO THROUGH GAMEPAD AND MAKE SURE HE WILL REACH THE FRUIT BASKET IN NO MORE THAN 1 MINUTE.YOU CAN ACCELERATE EVENING BY CLICKING THE BLACKOUT BUTTON.\nCLICK OK AND THE MAZE WILL APPEAR.\n\nGOOD LUCK!", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 30, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSMutableAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.tutorialLabel.attributedText = nameString
        self.tutorialLabel.numberOfLines = 3
        self.tutorialLabel.preferredMaxLayoutWidth = 650
        self.tutorialLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 80)
        self.addChild(tutorialLabel)
        
    }
    
    func createButtonOk(){
        
        let pixeledFont = UIFont(name: "Pixeled", size: 20)

        let buttonOkString = NSMutableAttributedString(string: "OK", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 20, weight: .ultraLight), .foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        self.buttonOk.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 50), cornerRadius: 20).cgPath
        self.buttonOk.position = CGPoint(x:self.frame.midX - 100, y:self.frame.midY - 270)
        self.buttonOk.fillColor = .black
        self.buttonOk.lineWidth = 1
        self.buttonOk.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.buttonOkLabel.attributedText = buttonOkString
        self.buttonOkLabel.position = CGPoint(x: buttonOk.frame.midX, y: buttonOk.frame.midY - 15)
        
        self.addChild(buttonOk)
        self.addChild(buttonOkLabel)
    }
    
    func createTimeLabel(){
                
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 14)
        
        var nameString = NSMutableAttributedString(string: "TIME LEFT: \(count) s", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 14, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        
        timeLabel.attributedText = nameString
        timeLabel.position = CGPoint(x: 510, y: 50)
        
        self.timeLabel.run(.repeatForever(.sequence([.run{nameString = NSMutableAttributedString(string: "TIME LEFT: \(self.count) s", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 14, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]) ; self.self.timeLabel.attributedText = nameString}, .wait(forDuration: 1)])))
        
        self.addChild(timeLabel)
    }
        
    func blackout(){
        print("Blackout")
        
        let sceneMoveTo = GameScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        
        let transition = SKTransition.fade(with: .black, duration: 2.0)
        self.scene?.view?.presentScene(sceneMoveTo,transition: transition)
    }
    
}

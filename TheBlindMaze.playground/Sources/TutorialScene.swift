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
            
    var blackoutButton: SKButtonNode?
    var timeLabel = SKLabelNode(text: "")
    
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
            
        }
        
    }
    
    func createTutorialLabel(){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 14)
        
        let nameString = NSMutableAttributedString(string: "WELCOME TO THE BLIND MAZE.\nYOU HAVE 1 MINUTE UNTIL NIGHTFALL. SO, MEMORIZE ALL THE OBSTACLES IN THE MAP TO GUIDE FULANINHO THROUGH GAMEPAD AND MAKE SURE HE REACHES THE FRUIT BASKET.YOU CAN ACCELERATE EVENING BY CLICKING THE BLACKOUT BUTTON.\nCLICK OK AND THE MAZE WILL APPEAR.\n\nGOOD LUCK!", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 30, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSMutableAttributedString.Key.paragraphStyle: paragraphStyle])
        
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
        
        var count = 60
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 14)
        
        var nameString = NSMutableAttributedString(string: "TEMPO RESTANTE: \(count) s", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 30, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)])
        
        timeLabel.attributedText = nameString
        timeLabel.position = CGPoint(x: 400, y: 50)
        
        self.timeLabel.run(.repeatForever(.sequence([.run{print("\(count)") ; count -= 1; nameString = NSMutableAttributedString(string: "TEMPO RESTANTE: \(count) s", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 30, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]) ; self.self.timeLabel.attributedText = nameString}, .wait(forDuration: 1)])))
        
        self.addChild(timeLabel)
                
    }
    
    func createBlackoutButton(){
        self.blackoutButton = SKButtonNode(image: .init(color: .black, size: .init(width: 160, height: 60)), label: .init(text: "Blackout")){
            self.blackout()
        }
        
        self.blackoutButton!.position = CGPoint(x: 100, y: 60)
        self.addChild(blackoutButton!)

    }
    
    func blackout(){
        let sceneMoveTo = GameScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        
        let transition = SKTransition.fade(with: .black, duration: 2.0)
        self.scene?.view?.presentScene(sceneMoveTo,transition: transition)

    }
    
}

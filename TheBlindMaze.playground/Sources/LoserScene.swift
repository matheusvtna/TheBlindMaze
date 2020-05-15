import Foundation
import SpriteKit

public class LoserScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "Waterfall.png")
    let char = SKSpriteNode(imageNamed: "CharFall1.png")
    
    let loserLabel = SKLabelNode()
    let menuButton = SKShapeNode()
    let menuButtonLabel = SKLabelNode()
    
    var charToFalling: [SKTexture] = []
    
    var count = 4

    override public func didMove(to view: SKView) {
        super.didMove(to: view)
    
        self.map.scale(to: CGSize(width: 700, height: 625))
        self.map.position = CGPoint(x: 0, y: 0)
        self.map.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(map)
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        self.char.position = CGPoint(x: self.frame.midX - 45, y: 540)
        self.char.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(char)
        
        self.animateChar()
        self.setTimer()
    }
    
    func animateChar(){
        let prefix = "CharFall"
        let ids = [1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3]
        var animation: [SKTexture] = []
        
        let falling = SKAction.moveBy(x: 0, y: -700, duration: 7.0)
        
        for i in ids {
            let pose = SKTexture(imageNamed: "\(prefix)\(i)")
            animation.append(pose)
        }
        
        self.charToFalling = animation
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        
        self.char.run(SKAction.animate(with: self.charToFalling, timePerFrame: 0.125, resize: false, restore: true))
        self.char.run(falling)
        
    }
    
    func setTimer(){
        let wait = SKAction.wait(forDuration: 1)
        let block = SKAction.run({
            [unowned self] in

            if self.count > 0{
                self.count -= 1
            }else{
                self.removeAction(forKey: "countdown")
                self.createLabel()
                self.createButtonBack()
            }
        })
        
        let sequence = SKAction.sequence([wait,block])

        run(SKAction.repeatForever(sequence), withKey: "countdown")
    }
    
    func createLabel(){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 40)
        
        let loserString = NSMutableAttributedString(string: "YOU LOST...", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 50, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), NSMutableAttributedString.Key.paragraphStyle: paragraphStyle])
        
        self.loserLabel.attributedText = loserString
        self.loserLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        self.addChild(loserLabel)
        
    }
    
    func createButtonBack(){
        let pixeledFont = UIFont(name: "Pixeled", size: 20)

        let menuButtonString = NSMutableAttributedString(string: "BACK TO MENU", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 20, weight: .ultraLight), .foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        self.menuButton.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 300, height: 50), cornerRadius: 20).cgPath
        self.menuButton.position = CGPoint(x:self.frame.midX - 150, y:self.frame.midY - 25)
        self.menuButton.fillColor = .black
        self.menuButton.lineWidth = 1
        self.menuButton.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.menuButtonLabel.attributedText = menuButtonString
        self.menuButtonLabel.position = CGPoint(x: menuButton.frame.midX, y: menuButton.frame.midY - 15)
        
        self.addChild(menuButton)
        self.addChild(menuButtonLabel)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if self.menuButton.contains(touchLocation) {
            let sceneMoveTo = MenuScene(size: self.size)
            sceneMoveTo.scaleMode = self.scaleMode
            
            let transition = SKTransition.moveIn(with: .up, duration: 0.3)
            self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
            
        }
        
    }
    
    
}


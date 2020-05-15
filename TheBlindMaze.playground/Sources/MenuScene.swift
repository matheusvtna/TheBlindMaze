import Foundation
import SpriteKit

public class MenuScene: SKScene{
    
    let menuBackground = SKSpriteNode(imageNamed: "MenuBackground.png")
    var changeBackground: [SKTexture] = []
    
    let nameLabel = SKLabelNode()
    
    let startButton = SKShapeNode()
    let startButtonLabel = SKLabelNode()
    
    var char = SKSpriteNode(imageNamed: "CharLeft1.png")
    var charWalk: [SKTexture] = []
    
    override public func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.menuBackground.scale(to: CGSize(width: 700, height: 645))
        self.menuBackground.anchorPoint = CGPoint(x:0, y:0)
        self.menuBackground.position = CGPoint(x:0, y:0)
        self.addChild(menuBackground)
        
//        self.nameShape.scale(to: CGSize(width: 700, height: 200))
//        self.nameShape.anchorPoint = CGPoint(x:0, y:0)
//        self.nameShape.position = CGPoint(x:0, y:300)
//        self.addChild(nameShape)
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        self.char.anchorPoint = CGPoint(x:0, y:0)
        self.char.position = CGPoint(x: 5, y: 110)
        self.addChild(char)
        
        createLabel()
        createButton()
        animateChar()
        animateBackground()
        
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if self.startButton.contains(touchLocation) {
            let sceneMoveTo = GameScene(size: self.size)
            sceneMoveTo.scaleMode = self.scaleMode
            
            let transition = SKTransition.moveIn(with: .down, duration: 0.3)
            self.scene?.view?.presentScene(sceneMoveTo ,transition: transition)
            
        }
        
    }
    
    func createLabel(){
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let pixeledFont = UIFont(name: "Pixeled", size: 50)
        
        let nameString = NSMutableAttributedString(string: "THE BLIND MAZE", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 50, weight: .ultraLight), .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        self.nameLabel.attributedText = nameString
        self.nameLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(nameLabel)
        
    }
    
    func createButton(){
        let pixeledFont = UIFont(name: "Pixeled", size: 20)

        let startButtonString = NSMutableAttributedString(string: "START", attributes: [NSMutableAttributedString.Key.font : pixeledFont ?? UIFont.systemFont(ofSize: 20, weight: .ultraLight), .foregroundColor : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        self.startButton.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 200, height: 50), cornerRadius: 20).cgPath
        self.startButton.position = CGPoint(x:self.frame.midX - 100, y:self.frame.midY - 300)
        self.startButton.fillColor = .black
        self.startButton.lineWidth = 1
        self.startButton.strokeColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.startButtonLabel.attributedText = startButtonString
        self.startButtonLabel.position = CGPoint(x: startButton.frame.midX, y: startButton.frame.midY - 15)
        
        self.addChild(startButton)
        self.addChild(startButtonLabel)
    }
    
    func animation(prefix1: String, prefix2: String, ids: [Int]) -> [SKTexture]{
        
        var frames: [SKTexture] = []
        
        for i in ids {
            let pose = SKTexture(imageNamed: "\(prefix1)\(i)")
            frames.append(pose)
        }
        
        for i in ids {
            let pose = SKTexture(imageNamed: "\(prefix2)\(i)")
            frames.append(pose)
        }
        
        return frames
        
    }
    
    func animateChar(){
        
        let ids = [1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3,1,2,1,3]
                
        self.charWalk = animation(prefix1: "CharRight", prefix2: "CharLeft", ids: ids)
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        
        let toRight = SKAction.moveTo(x: 705, duration: 3.0)
        
        let toLeft = SKAction.moveTo(x: -95, duration: 3.0)
        
        let sequence = SKAction.sequence([toRight, toLeft])
        
        let runForever = SKAction.repeatForever(sequence)
                
        self.char.run(runForever)
        self.char.run(SKAction.repeatForever(SKAction.animate(with: self.charWalk, timePerFrame: 0.125, resize: false, restore: true)))
        
    }
    
    func animateBackground(){
        
        var frames: [SKTexture] = []
        
        frames.append(SKTexture(imageNamed: "MenuBackground.png"))
        frames.append(SKTexture(imageNamed: "MenuBackgroundBlackout.png"))
        
        self.changeBackground = frames
        
        self.menuBackground.run(SKAction.repeatForever(SKAction.animate(with: self.changeBackground, timePerFrame: 3.0, resize: false, restore: true)))
    
    }    
    
}

import Foundation
import SpriteKit
import UIKit

public class GameScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "Mapa.png")
    let inf = SKSpriteNode(imageNamed: "BarraInferior.png")
    let char = SKSpriteNode(imageNamed: "CharRight1.png")
    var nivel = 0
    var charToDown: [SKTexture] = []
    
    override public func didMove(to view: SKView) {
        self.map.scale(to: CGSize(width: 700, height: 500))
        self.map.position = CGPoint(x: 0, y: 200)
        self.map.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(map)
        
        self.char.scale(to: CGSize(width: 90, height: 90))
        self.char.position = CGPoint(x: 5, y: 605)
        self.char.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(char)
        
        self.inf.scale(to: CGSize(width: 700, height: 200))
        self.inf.position = CGPoint(x: 0, y: 000)
        self.inf.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(inf)
        
        self.createButtons()
        
    }
    
    func createButtons(){
        
        let rightButton = SKButtonNode(image: .init(color: .red, size: .init(width: 40, height: 30)), label: .init(text: "R")) {
            
            let prefix = "CharRight"
            let ids = [1,2,1,3,1]
            var animation: [SKTexture] = []
            
            let toRight = SKAction.moveBy(x: 100, y: 0, duration: 1.0)
            
            for i in ids {
                let pose = SKTexture(imageNamed: "\(prefix)\(i)")
                animation.append(pose)
            }
            
            self.charToDown = animation
            
            self.char.scale(to: CGSize(width: 90, height: 90))
            self.char.run(SKAction.animate(with: self.charToDown, timePerFrame: 0.25, resize: false, restore: true))
            self.char.run(toRight)
        }
        
        rightButton.position = CGPoint(x: 260, y:100)
        self.addChild(rightButton)
        
    }
    
    
}

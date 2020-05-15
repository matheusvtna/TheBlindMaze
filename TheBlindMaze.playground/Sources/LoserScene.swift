import Foundation
import SpriteKit

public class LoserScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "Waterfall.png")
    let char = SKSpriteNode(imageNamed: "CharFall1.png")

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
        
    }
    
    func animateChar(){
        
        
        
    }
}


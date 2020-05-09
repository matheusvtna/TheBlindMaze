import Foundation
import SpriteKit
import UIKit

public class MapScene: SKScene{
    
    let map = SKSpriteNode(imageNamed: "Mapa.png")
    let inf = SKSpriteNode(imageNamed: "BarraInferior.png")
    let char = SKSpriteNode(imageNamed: "Robin1.png")

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
            let toRight = SKAction.moveBy(x: 100, y: 0, duration: 2.0)
            self.char.run(toRight)
        }
        
        rightButton.position = CGPoint(x: 248, y:117)
        self.addChild(rightButton)
        
    }
    
    func moveRight(){

        
    }
    
    
    
}

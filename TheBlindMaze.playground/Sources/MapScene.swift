import Foundation
import SpriteKit
import UIKit

public class MapScene: SKScene{
    
    let mapImage = SKSpriteNode(imageNamed: "Mapa.png")
    let infImage = SKSpriteNode(imageNamed: "BarraInferior.png")
    let charImage = SKSpriteNode(imageNamed: "Robin1.png")
    let letsGoButton = UIButton()
    
    override public func didMove(to view: SKView) {
        self.mapImage.scale(to: CGSize(width: 700, height: 500))
        self.mapImage.position = CGPoint(x: 0, y: 200)
        self.mapImage.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(mapImage)
        
        self.charImage.scale(to: CGSize(width: 90, height: 90))
        self.charImage.position = CGPoint(x: 5, y: 605)
        self.charImage.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(charImage)
        
        self.infImage.scale(to: CGSize(width: 700, height: 200))
        self.infImage.position = CGPoint(x: 0, y: 000)
        self.infImage.anchorPoint = CGPoint(x: 0, y:0)
        self.addChild(infImage)
        
        self.createButtons()
        
    }
    
    func createButtons(){
        
        
        
    }
    
    
    
}

//: A UIKit based Playground for presenting user interface
  
import UIKit
import SpriteKit
import PlaygroundSupport

let cfURL = Bundle.main.url(forResource: "Pixeled", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

let frame = CGRect(x:0, y:0, width: 700, height: 625)

var gameScene = GameScene(size: frame.size)
let view = SKView(frame: frame)
view.presentScene(gameScene)

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = view

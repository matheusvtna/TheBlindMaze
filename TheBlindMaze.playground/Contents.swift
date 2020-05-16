import SpriteKit
import PlaygroundSupport

/*:
 
 # THE BLIND MAZE
 
Fulaninho is a resident of the city of Cuxixinga, in the interior of Pernambuco-BR, and like several cities near Cuxixinga and another 355 thousand households in Brazil, he does not have electricity at home. However, despite the difficulties, Fulaninho is still responsible for feeding his family.
The big problem with all this is that Fulaninho has a bad memory and always forgets the fruits of the fields on the way home from work. In this way, Fulaninho asks for your help to guide him in the darkness of the rural area to get the fruits before his children die of hunger.
Fast! You have little time until nighttfall to find out which path this is...
 
 */

let cfURL = Bundle.main.url(forResource: "Pixeled", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

let frame = CGRect(x:0, y:0, width: 700, height: 625)

let view = SKView(frame: frame)
var menu = MenuScene(size: frame.size)
view.presentScene(menu)

PlaygroundPage.current.liveView = view


/*:
 
 # WHO I AM?
 
 Hi! My name is Matheus Andrade and I am 20 years old. I am from Brazil, from the Academy of Recife-PE.

 
 ![Playground icon](MatheusVinicius.jpg)

 
 I am a computer engineering student at the Centro de Informática - Universidade Federal de Pernambuco (CIn - UFPE) and I am a member of Apple Developer Academy.
 Now, I have contact with robotic, software developement, design and iOS Development at the university. But before that I never had knowledge about programming or something more technical about techonology. Being more specific, before I joined at the Academy, I never had contact with Swift or Apple's technology. Because of this, The Blind Maze is only my second playground made since I joined the the Apple Developer Academy in 2020 and is the first using SpriteKit. My idea of using SpriteKit on this playground came from my love about games and a motivation to learn something new at the beginning of the Academy that I will carry to all program and probably to all my career. So, I CREATE MY FIRST GAME!

 */

/*:
 
 ### Credits
 
The game's background map was created from clippings of licensed open source images. All the clippings I used are in the "third party" folder in this repository and I am very grateful to [Pipoya](https://pipoya.itch.io/pipoya-rpg-tileset-32x32) for making them available.

 */

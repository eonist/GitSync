import Foundation

import Cocoa

class WinView4:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        radioBulletTest()
        //floatTest()
        //resizeTest()
    }
    /**
     * Testing radioBullet
     */
    func radioBulletTest(){
        let css:String = "Element{fill:blue;}"
        StyleManager.addStyle(css)
        let radioBullet1 = Element(14,14,nil)
        addSubview(radioBullet1)
        
    }
    /**
     * TODO: Remember to see the legacy code for more tests
     */
    func floatTest(){
        var css:String = ""
        css += "Element{float:none;clear:none;}"
        css += "Section{fill:grey;}"
        css += "Element#box1{fill:red;}"
        css += "Element#box2{fill:purple;}"
        css += "Element#box3{fill:blue;}"
        css += "Element#box4{fill:orange;}"
        css += "Element#box5{fill:green;}"
        
        StyleManager.addStyle(css)
        let section = Section(500,500)
        addSubview(section)
        let box1 = Element(100,100,section,"box1")
        section.addSubview(box1)
        let box2 = Element(100,100,section,"box2")
        section.addSubview(box2)
        let box3 = Element(100,100,section,"box3")
        section.addSubview(box3)
        let box4 = Element(100,100,section,"box4")
        section.addSubview(box4)
        let box5 = Element(100,100,section,"box5")
        section.addSubview(box5)
        
        
        let tempStyle = StyleResolver.style(section)
        StyleParser.describe(tempStyle)
        //Swift.print("-------")
        //Swift.print(ElementParser.children(section,IElement.self).count)
        //Swift.print("-------")
    }
    /**
     * Resize test for Element
     */
    func resizeTest(){
        StyleManager.addStyle("Element{fill:blue;}")
        let element:Element = Element(100,100,nil,"first")
        addSubview(element)
        element.setSize(200, 100)
    }
}
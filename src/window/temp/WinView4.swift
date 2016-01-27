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
        floatTest()
        //resizeTest()
    }
    /**
     * TODO: Remember to see the legacy code for more tests
     */
    func floatTest(){
        var css:String = ""
        css += "Element{fill:green;float:left;clear:left;}"
        css += "Container{fill:blue;}"
        css += "Element#box1{fill:red;}"
        css += "Element#box2{fill:purple;}"
        css += "Element#box3{fill:blue;}"
        css += "Element#box4{fill:orange;}"
        css += "Element#box5{fill:grey;}"
        StyleManager.addStyle(css)
        let container = Container(400,400)
        addSubview(container)
        let box1 = Element(100,100,container,"box1")
        container.addSubview(box1)
        let box2 = Element(100,100,container,"box2")
        container.addSubview(box2)
        let box3 = Element(100,100,container,"box3")
        container.addSubview(box3)
        let box4 = Element(100,100,container,"box4")
        container.addSubview(box4)
        let box5 = Element(100,100,container,"box5")
        container.addSubview(box5)
        
        
        let tempStyle = StyleResolver.style(container)
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
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
        css += "Element{fill:blue;float:right;clear:none;}"
        css += "Element#box2{fill:red;}"
        StyleManager.addStyle(css)
        let section = Section(400,400)
        addSubview(section)
        let box1 = Element(100,100,section,"box1")
        section.addSubview(box1)
        //let box2 = Element(100,100,section,"box2")
        //section.addSubview(box2)
        
        //Continue here: Try to align elements in a row, try to float things to the right, then clear to the right
        //look into how you center align things, see the css from the textReplacer demo app
        
        //let tempStyle = StyleResolver.style(box2)
        //StyleParser.describe(tempStyle)
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
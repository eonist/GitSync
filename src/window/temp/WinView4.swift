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
        StyleManager.addStyle("Element{fill:blue;}")
        let section = Section(400,400)
        addSubview(section)
        let box1 = Element(100,100,nil,"box1")
        addSubview(box1)
        let box2 = Element(100,100,nil,"box2")
        addSubview(box2)
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
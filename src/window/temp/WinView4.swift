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
        var css:String = ""
        css += "RadioBulletBase:selected{"
        css +=    "fill:linear-gradient(bottom, #87C2F3 1 0,#87C2F3 1 0.4214,#87C2F3 1 0.4908,#97CAF4 1 0.5147,#ADD5F6 1 0.5573,#BEDDF7 1 0.6077,#C9E3F8 1 0.67,#D0E6F9 1 0.7574,#D2E7F9 1 1);"
        css += "}"
        css += "RadioBulletTopShine{"
        css +=     "fill:radial-gradient(50% 20% 40% 120% 90 -1, white 1 0,white 0.33 0.4724,white 0 1);"
        css += "}"
        css += "RadioBulletBottomShine{"
        css +=     "fill:radial-gradient(50% 80% 90% 90% 0 0, white 0.70 0,white 0 1);"
        css += "}"
        css += "RadioBulletBulletShine{"
        css +=     "fill:radial-gradient(50% 50% 100% 100% 90 0.2, white 1 0,white 0 0.5);"
        css += "}"
        
        
        css += "Element{"
        css += "width:14px,14px,14px,14px,5px;"
        css += "height:14px,5px;"
        
        
        
        /*
        css += "line:grey7;"
        css += "line-offset-type:outside;"
        css += "line-alpha:1;"
        css += "line-thickness:1px;"
        */
        //css += "fill:blue;"
        //css += "fill:linear-gradient(bottom, #EDEDED 1 0,#EDEDED 1 0.4214,#EDEDED 1 0.4908,#F6F6F6 1 0.5605,#FDFDFD 1 0.6768,#FFFFFF 1 1);"
        
        
        
        
        css += "fill:<RadioBulletBase:selected>,#021931;"
        css += "margin-left:0px,4.5px;"
        css += "margin-top:0px,4.5px;"
        css += "corner-radius:7px,2.5px;"
        css += "}"
        StyleManager.addStyle(css)
        let radioBullet1 = Element(0,0,nil)
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
import Foundation
@testable import Element
@testable import Utils

class FlexBoxTestWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        self.contentView = FlexBoxViewView(frame.size.width,frame.size.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class FlexBoxViewView:WindowView{
    override func resolveSkin(){
        Swift.print("FlexBoxViewView")
        var css:String = ""
        css += "Window{fill-alpha:1;fill:white;corner-radius:4px;}"//
        css +=  "Button{fill:blue;fill-alpha:1;clear:left;float:left;}"
        StyleManager.addStyle(css)
        super.resolveSkin()
        self.window?.title = "FlexBox"
        //flexBoxTest()
        imageGrid()
    }
    /**
     *
     */
    func imageGrid(){
        //80 height
        
        //first row:
        //3 items 1/3 each
        let row1 = self.addSubView(CustomContainer(frame.size.w,frame.size.h,.flexStart,.flexStart))/*Create FlexBoxContainer*/
        row1.flexBoxItems = [1,1,1].enumerated().map{ (i,grow) in
            return row1.addSubView(CustomItem(80, 80, "item-" + i.string, grow, nil,i.string))
        }
        row1.flex()
        //3 items, 1/2 and 1/4 , 1/4
        let row2 = self.addSubView(CustomContainer(frame.size.w,frame.size.h,.flexStart,.flexStart))/*Create FlexBoxContainer*/
        row2.flexBoxItems = [2,1,1].enumerated().map{ (i,grow) in
            return row2.addSubView(CustomItem(80, 80, "item-" + i.string, grow, nil,i.string))
        }
        row2.flex()
        row2.y = 80
        //3 items 1/6 2/3 1/6
        let row3 = self.addSubView(CustomContainer(frame.size.w,frame.size.h,.flexStart,.flexStart))/*Create FlexBoxContainer*/
        row3.flexBoxItems = [1,4,1].enumerated().map{ (i,grow) in
            return row3.addSubView(CustomItem(80, 80, "item-" + i.string, grow, nil,i.string))
        }
        row3.flex()
        row3.y = 160
        //2 items half half
        let row4 = self.addSubView(CustomContainer(frame.size.w,frame.size.h,.flexStart,.flexStart))/*Create FlexBoxContainer*/
        row4.flexBoxItems = [1,1].enumerated().map{ (i,grow) in
            return row4.addSubView(CustomItem(80, 80, "item-" + i.string, grow, nil,i.string))
        }
        row4.flex()
        row4.y = 160 + 80
        //4 items, 1/4 each
        let row5 = self.addSubView(CustomContainer(frame.size.w,frame.size.h,.flexStart,.flexStart))/*Create FlexBoxContainer*/
        row5.flexBoxItems = [1,1,1,1].enumerated().map{ (i,grow) in
            return row5.addSubView(CustomItem(80, 80, "item-" + i.string, grow, nil,i.string))
        }
        row5.flex()
        row5.y = 160 + 160
    }
    /**
     *
     */
    func flexBoxTest(){
        let container = self.addSubView(CustomContainer(frame.size.w,frame.size.h,.flexStart,.flexStart))/*Create FlexBoxContainer*/
        container.flexBoxItems = [1,1,1,3].enumerated().map{ (i,grow) in
            return container.addSubView(CustomItem(80, 80, "item-" + i.string, grow, nil,i.string))
        }
        container.flex()/*init layout distribution*/
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        Swift.print("resize: w: \(width) h \(height)")
    }
}

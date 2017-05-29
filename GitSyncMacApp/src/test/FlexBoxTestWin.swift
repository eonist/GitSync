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
        flexBoxTest()
    }
    /**
     *
     */
    func flexBoxTest(){
        var css:String = ""//"#btn{fill:blue;width:100%;height:100%;float:left;clear:left;}"
        css += "Section{fill:white;float:left;clear:left;fill-alpha:0;}"
        StyleManager.addStyle(css)
        StyleManager.addStyle(Utils.labelStyles)
        
        let size:CGSize = self.frame.size//WinParser.size(self.window!)
        let frame:CGRect = CGRect(10,10,size.w-20,size.h-20)
        let section = self.addSubView(Section(size.w,size.h))
        _ = section
        
        //add 4 boxes, yellow,green,blue,red
        let numBoxes:Int = 4
        /*Rect*/
        let sizes:[CGSize] = (0..<numBoxes).indices.map{ _ in CGSize(80,80)}
        let grows:[CGFloat] = [1,1,1,3]//[0,0,0,0]//
        
        let graphicItems:[TextButton] = (0..<numBoxes).indices.map{ i in
            let size = sizes[i]
            let title = "item-" + i.string
            let item = TextButton.init(size.w, size.h, title, nil,i.string)//RoundRectGraphic(0,0,size.w,size.h,Fillet(10),FillStyle(color),nil)
            section.addSubview(item)
            //item.draw()
            return item
        }
        
        let flexBoxItems:[FlexBoxItem] = (0..<numBoxes).indices.map{ i in
            let flexible:Flexible = graphicItems[i]
            let grow:CGFloat = grows[i]
            let flexItem:FlexItem = FlexBoxItem(flexible,grow)
            return flexItem
        }
        
        let flexBoxContainer = FlexBoxContainer(frame,flexBoxItems,.flexStart,.flexStart)
        FlexBoxModifier.flex(flexBoxContainer)
        //graphicItems.forEach{$0.draw()}/*FlexBox only sets x,y,w,h it doesn't render, so render here*/
        
        //grey bg
        //FlexBoxModifier.justifyContent(container,.end)//.start,.center,.spaceBetween,.spaceAround
    }
    /**
     * NOTE: gets calls from Window.didResize
     */
    override func setSize(_ width:CGFloat,_ height:CGFloat){
        super.setSize(width, height)
        Swift.print("resize: w: \(width) h \(height)")
    }
}
private class Utils{
    /**
     *
     */
    static var labelStyles:String{
        /*Styles*/
        var css = ""
        css +=  "TextButton{fill:#30B07D;fill-alpha:1.0;corner-radius:10px;float:none;clear:none;}"
        css +=  "TextButton Text{"
        css +=  	"float:left;"
        css +=  	"clear:left;"
        css +=  	"width:100%;"
        css +=  	"margin-top:32px;"
        css +=  	"font:Helvetica Neue;"
        css +=  	"size:16px;"
        css +=  	"wordWrap:true;"
        css +=  	"align:center;"
        css +=  	"color:black;"
        css +=  	"selectable:false;"
        css +=  	"backgroundColor:orange;"
        css +=  	"background:false;"
        css +=  "}"
        css += "TextButton#0{fill:#22FFA0;}"
        css += "TextButton#1{fill:#1DE3E6;}"
        css += "TextButton#2{fill:#FB1B4D;}"
        css += "TextButton#3{fill:#FED845;}"
        return css
    }
}

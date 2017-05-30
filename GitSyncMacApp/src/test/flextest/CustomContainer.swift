@testable import Element
@testable import Utils
import Cocoa

class CustomContainer:Section,FlexBoxContainerKind{
    var flexBoxItems:[FlexBoxItemKind] = []
    var justifyContent:FlexBoxType.Justify = .flexStart
    var alignItems:FlexBoxType.AlignType = .flexStart
    init(_ width: CGFloat, _ height: CGFloat,_ justifyContent:FlexBoxType.Justify, _ alignItems:FlexBoxType.AlignType,  _ parent: IElement? = nil, _ id: String? = nil) {
        self.justifyContent = justifyContent
        super.init(width,height,parent,id)
    }
    override func resolveSkin() {
        let css:String = "Section{fill:white;float:left;clear:left;fill-alpha:0;}" + Utils.labelStyles
        StyleManager.addStyle(css)
        super.resolveSkin()
    }
    var rect:CGRect {
        return CGRect(x+5,y+5,w-10,h-10)/*Adds inset*/
        //return CGRect(self.x,self.y,self.w,self.h)
    }
    override func getClassType() -> String {
        return "\(Section.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

private class Utils{
    /**
     * Returns styles
     */
    static var labelStyles:String{
        /*Styles*/
        var css = ""
        css +=  "CustomItem{padding:5px;float:left;clear:left;fill:green;fill-alpha:0.0;}"
        css +=  "TextButton{fill:#30B07D;fill-alpha:1.0;corner-radius:10px;float:left;clear:left;width:100%;height:100%;}"
        css +=  "TextButton Text{"
        css +=  	"float:left;"
        css +=  	"clear:left;"
        css +=  	"width:100%;"
        css +=  	"margin-top:27px;"
        css +=  	"font:Helvetica Neue;"
        css +=  	"size:16px;"
        css +=  	"wordWrap:true;"
        css +=  	"align:center;"
        css +=  	"color:black;"
        css +=  	"selectable:false;"
        css +=  	"backgroundColor:orange;"
        css +=  	"background:false;"
        css +=  "}"
        css += "CustomItem#0 TextButton{fill:#22FFA0;}"
        css += "CustomItem#1 TextButton{fill:#1DE3E6;}"
        css += "CustomItem#2 TextButton{fill:#FB1B4D;}"
        css += "CustomItem#3 TextButton{fill:#FED845;}"
        return css
    }
}

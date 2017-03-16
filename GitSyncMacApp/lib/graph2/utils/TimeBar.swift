import Foundation
@testable import Element
@testable import Utils

class TimeBar:Element {
    override func resolveSkin() {
        addStyles()
        super.resolveSkin()
        let spaceX:CGFloat = 100
        for i in 0..<20{
            let x:CGFloat = (i*spaceX)
            let str:String = x.string
            //Swift.print("str: " + "\(str)")
            let textArea:TextArea = TextArea(NaN,NaN,str,self)
            _ = addSubView(textArea)
            //Swift.print("CGPoint(x,0): " + "\(CGPoint(x,0))")
            textArea.setPosition(CGPoint(x,0))
        }
    }
}

extension TimeBar{
    func addStyles(){
        var css:String = ""
        css += "TimeBar{"
        css += 	"float:none;"
        css += 	"clear:none;"
        css += 	"fill:orange;"
        css += 	"fill-alpha:0.5;"
        css += 	"height:32px;"
        css += "}"
        css += "TimeBar TextArea{"
        css += 	"float:none;"
        css += 	"clear:none;"
        css += 	"fill:red;"
        css += 	"fill-alpha:0.0;"
        css += 	"line:grey;"
        css += 	"line-alpha:0;"
        css += 	"line-thickness:0px;"
        css += 	"padding-right:0px;"
        css += 	"padding-top:0px;"
        css += 	"margin-top:0px;"
        css += 	"margin-bottom:0px;"
        css += 	"margin-left:-20px;"
        css += 	"margin-right:20px;"
        css += 	"height:20px;"
        css += 	"width:40px;"
        css += "}"
        css += "TimeBar TextArea Text{"
        css += 	"border:false;"
        css += 	"color:#C5C9CC;"
        css += 	"backgroundColor:orange;"
        css += 	"background:false;"
        css += 	"width:40px;"
        css += 	"size:10px;"
        css += 	"margin-top:0px;"
        css += 	"margin-left:0px;"
        css += 	"height:20px;"
        css += 	"align:center;"
        css += "}"
        StyleManager.addStyle(css)
    }
}

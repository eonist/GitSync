import Foundation
@testable import Element
@testable import Utils
class ValueBar:Element{
    override func resolveSkin() {
        addStyles()
        super.resolveSkin()
        //400
        //8
        let ySpace:CGFloat = height/8
        let textValues:[String] = (0...8).reversed().map { ($0 * 50).string }//"400","350","300"..."0"
        for i in (0...8){
            //let x:CGFloat = 0
            Swift.print("i: " + "\(i)")
            let textValue:CGFloat = textValues[i]
            let y:CGFloat = ySpace * i
            let textArea:TextArea = TextArea(NaN,NaN,textValue.int.string,self)
            _ = self.addSubView(textArea)
            textArea.setPosition(CGPoint(0,y))
        }
        /*strings.forEach{
         
        }*/

    }
}
extension ValueBar{
    /**
     *
     */
    func addStyles(){
        var css:String = ""
        css +=	"ValueBar{"
        css +=		"float:none;"
        css +=		"clear:none;"
        css +=		"fill:yellow;"
        css +=		"fill-alpha:0.2;"
        css +=		"width:32px;"
        css +=	"}"
        css +=	"ValueBar TextArea{"
        css +=		"float:none;"
        css +=		"clear:none;"
        css +=		"fill:green;"
        css +=		"fill-alpha:0;"
        css +=		"line:grey;"
        css +=		"line-alpha:0;"
        css +=		"line-thickness:0px;"
        css +=		"padding-right:0px;"
        css +=		"padding-top:0px;"
        css +=		"margin-top:-10px;"
        css +=		"margin-bottom:10px;"
        css +=		"margin-left:8px;"
        css +=		"height:20px;"
        css +=		"width:100%;"
        css +=	"}"
        css +=	"ValueBar TextArea Text{"
        css +=		"border:false;"
        css +=		"color:#C5C9CC;"
        css +=		"backgroundColor:orange;"
        css +=		"background:false;"
        css +=		"width:100%;"
        css +=		"size:10px;"
        css +=		"margin-top:0px;"
        css +=		"height:20px;"
        css +=		"margin-left:0px;"
        css +=	"}"
        StyleManager.addStyle(css)
    }
}

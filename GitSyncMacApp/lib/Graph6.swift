import Cocoa
@testable import Utils
@testable import Element
/**
 * Testing SideScrolling FastList
 */

//1. Create a vertical list first, then FastList

class Graph6:ContainerView2{
    var monthNames:[String] { return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]}
    override var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    var timeBar:TimeBar2?
    
    override func resolveSkin() {
        StyleManager.addStyle("Graph6{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        super.resolveSkin()
        
        /*config*/
        maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        /*add UI*/
        //createTimeBar()
        createList()
       
    }
}
extension Graph6{
    func createList(){
        //change the css to align sideways
        addVListStyles()
        
        let dp = DataProvider()
        
        dp.addItemAt(["title":"brown"], 0)/*adds a new item at index 0*/
        dp.addItem(["title":"pink"])/*adds a new item to the end of the list*/
        dp.addItems([["title":"purple"], ["title":"turquoise"]])/*adds 2 items to the end of the list*/
        
        let list = addSubView(VList(500,24,CGSize(100,24),dp,nil,"vertical"))
        _ = list
        
        //continue here:
        
    }
    /**
     * Creates the TimeBar
     */
    func createTimeBar(){
        //TODO: make line marks
        timeBar = addSubView(TimeBar2(contentSize.width,32,monthNames,self))
        let objSize = CGSize(timeBar!.w,32)
        Swift.print("objSize: " + "\(objSize)")
        let canvasSize = CGSize(w,h)
        Swift.print("canvasSize: " + "\(canvasSize)")
        let p = Align.alignmentPoint(objSize, canvasSize, Alignment.bottomLeft, Alignment.bottomLeft, CGPoint())
        Swift.print("p: " + "\(p)")
        //align timeBar to bottom with Align
        timeBar!.point = p
    }
}
extension Graph6{
    func addVListStyles(){
        var css:String = ""
        css += "VList{"
        css +=     "float:left;"
        css +=     "clear:left;"
        //css +=     "width:138px;/*<-this is a fix until padding works corectly*/"
        //css +=     "/*height:71px;*/"
        css +=     "fill:white;"
        css +=     "fill-alpha:1;"
        css +=     "line:#B8B8B8;"
        css +=     "line-alpha:1;"
        css +=     "line-offset-type:outside;"
        css +=     "line-thickness:1px;"
        css += "}"
        css += "VList Container#lable{"
        //css +=     "width:100%;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css += "}"
        /*Button*/
        css += "VList Container#lable SelectTextButton{"
        css +=     "float:left;"
        css +=     "clear:left;"
        //css +=     "width:100%;"
        //css +=     "height:24px;"
        css +=     "fill:red;"
        css +=     "fill-alpha:0;"
        css +=     "padding-right:0px;"
        css += "}"
        css += "VList Container#lable SelectTextButton:selected{"
        css += 	"fill:#D4D4D4;"
        css +=     "fill-alpha:1;"
        css += "}"
        /*Text*/
        css += "VList Container#lable SelectTextButton Text{"
        css +=     "float:none;"
        css +=     "clear:none;"
        css +=     "width:100%;"
        css +=     "height:24px;"
        css +=     "margin-left:10px;"
        css +=     "margin-top:3px;"
        css +=     "autoSize:left;"
        css +=     "font:Helvetica Neue;"
        css +=     "size:12;"
        css +=     "align:left;"
        css +=     "color:black;"
        css +=     "selectable:false;"
        css += "}"
        css += "VList Container#lable SelectTextButton:selected Text{"
        css += 	"font:Helvetica Neue Bold;"
        css += "}"
        
         StyleManager.addStyle(css)
    }
}

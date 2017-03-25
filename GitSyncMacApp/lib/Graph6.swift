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
        var css:String = "List#vertical{width:500px;}"
        css += "List#vertical Container#lable SelectTextButton{"
        css += "float:left;"
        css += "clear:none;"
        css += "fill-alpha:0;"
        css += "}"
        StyleManager.addStyle(css)
        
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

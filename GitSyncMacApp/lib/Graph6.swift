import Cocoa
@testable import Utils
@testable import Element
/**
 * Testing SideScrolling 🐎 FastList
 */
class Graph6:Element{
    var monthNames:[String] { return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]}
    //override var itemSize:CGSize {return CGSize(48,48)}//override this for custom value
    //override var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
    //override var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
    //var timeBar:TimeBar2?
    
    override func resolveSkin() {
        StyleManager.addStyle("Graph6{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        super.resolveSkin()
        
        /*config*/
        //maskSize = CGSize(width,height)/*represents the visible part of the content *///TODO: could be ranmed to maskRect
        //contentSize = CGSize(1600,height)/*represents the total size of the content *///TODO: could be ranmed to contentRect
        
        /*add UI*/
        //createTimeBar()
        createList()
    }
}

//continue here: 🏀
    //add Elasticity to the fold in this test class

extension Graph6{
    func createList(){
        //change the css to align sideways
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/vlist.css")
        
        let dict:[[String:String]] = monthNames.map{["title":$0]}
        let dp = DataProvider(dict)
        
        let dir:Dir = .hor
        let listSize:CGSize = dir == .ver ? CGSize(100,200) : CGSize(200,24)
        let itemSize:CGSize = CGSize(100,24)
        
        //TODO: 👉Use List1 instead just add the dir stuff as you ddid with fastlist👈
        let list = addSubView(ScrollFastList(listSize.w,listSize.h,itemSize.height,dp,nil,nil,dir,itemSize.width))
        _ = list
        
    }
    /**
     * Creates the TimeBar
     */
    /*func createTimeBar(){
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
    }*/
}


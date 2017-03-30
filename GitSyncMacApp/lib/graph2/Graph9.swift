import Foundation
@testable import Element
@testable import Utils
//Graph9
    //add fastList .hor 👈
    //try it with year,month,day
    //try to add pinch gestures to the fold
    //try to calc the pos of mouse in relation to the timeBar
    //try to zoom in and out with correct indecies
    //try generate fake graphdata on anim stop
    //draw the fake graph data as a graphline with points
    //try to update the valuebar
    //try to update the timeIndicator
    //add git to the fold
class Graph9:Element{
    override func resolveSkin() {
        StyleManager.addStyle("Graph9{float:left;clear:left;fill:green;fill-alpha:0.0;}")//Needed so that scrollWheel works
        super.resolveSkin()
    }
}
extension Graph9{
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
}

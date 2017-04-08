import Cocoa
@testable import Utils
@testable import Element

protocol Progressable3:Containable3{
    var progress:CGFloat {get}
    var interval:CGFloat {get}
    //setProgress
    func setProgress(_ progress:CGFloat,_ dir:Dir)
}
/*
 var interval:CGFloat{return floor(contentSize[dir] - maskSize[dir])/itemSize[dir]}// :TODO: use ScrollBarUtils.interval instead?// :TODO: explain what this is in a comment
 var progress:CGFloat{return SliderParser.progress(lableContainer!.point[dir], maskSize[dir], contentSize[dir])}
 */
/*
 var interval:CGFloat{return floor(contentSize.w - maskSize.w)/itemSize.width}
 var progress:CGFloat{return SliderParser.progress(contentContainer!.x, maskSize.w, contentSize.w)}
 */
extension Progressable3{
    /**
     * PARAM: progress: 0-1
     */
    func setProgress(_ progress:CGFloat,_ dir:Dir){
        let progressValue = self.contentSize[dir] < maskSize[dir] ? 0 : progress/*pins the lableContainer to the top if itemsHeight is less than height*/
        ScrollableUtils.scrollTo(self,progressValue,dir)
    }
    /*func setProgress(_ point:CGPoint){
        setProgress(point.x,.hor)
        setProgress(point.y,.ver)
    }*/
}
private extension ScrollableUtils{//temp migration fix
    static func scrollTo(_ container:Containable3, _ progress:CGFloat, _ dir:Dir = .ver){
        let val:CGFloat = ScrollableUtils.scrollTo(progress, container.height, container.contentSize.height)
        container.contentContainer!.point[dir] = val/*we offset the y position of the lableContainer*/
    }
}

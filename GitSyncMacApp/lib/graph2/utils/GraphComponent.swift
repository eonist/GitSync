import Foundation
@testable import Utils
@testable import Element

class GraphComponent:Element {//alternate name? GraphArea?
    var dots:[Element] = []//rename to graphDots for clearity?
    var graphLine:GraphLine?
    var contentContainer:Element?//contains dots and line
    var points:[CGPoint]?
    var prevPoints:[CGPoint]?/*interim var*/
    var animator:Animator?/*Anim*/
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync/stats/graphcomponent.css")
        super.resolveSkin()
        
        createUI()
    }
}

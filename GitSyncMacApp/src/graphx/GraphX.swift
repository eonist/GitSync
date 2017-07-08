import Foundation
@testable import Utils
@testable import Element

class GraphX:Element{
    override func resolveSkin() {
        super.resolveSkin()
        createUI()
    }
    /**
     *
     */
    func createUI(){
        
    }
}
class GraphArea:Element{
    //graphDots
    //graphLine
    //points
    //prevPoints
    //contentContainer
    override func resolveSkin() {
        super.resolveSkin()
        //createUI()
    }
    //createGraphLine
    //createGraphPoints
}
class TimeBar:Element{
    var lables:[TextArea] = []
    override func resolveSkin() {
        //createLables()
        //
    }
}
class ValueBar:Element{
    
}

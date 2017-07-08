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
    //
}
class ValueBar:Element{
    //var valueLables:[TextArea] = []
    override func resolveSkin() {
        super.resolveSkin()
        //valueLables()
    }
}

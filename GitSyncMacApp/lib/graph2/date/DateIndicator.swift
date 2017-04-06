import Foundation
@testable import Utils
@testable import Element

class DateIndicator:Element{
    override func resolveSkin() {
        super.resolveSkin()
        dateText = addSubView(TextArea(NaN,NaN,"00/00/00 - 00/00/00",self,"date"))/*A TextField that displays the time range of the graph*/
    }
}

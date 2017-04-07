import Foundation
@testable import Utils
@testable import Element

class DateIndicator:Element{
    var dateText:TextArea?
    override func resolveSkin() {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync/stats/dateindicator.css")
        super.resolveSkin()
        dateText = addSubView(TextArea(NaN,NaN,"00/00/00 - 00/00/00",self,"date"))/*A TextField that displays the time range of the graph*/
    }
}

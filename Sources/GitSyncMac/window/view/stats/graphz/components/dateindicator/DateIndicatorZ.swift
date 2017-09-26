import Foundation
@testable import Utils
@testable import Element

class DateIndicatorZ:Element{
    var dateText:TextArea?
    override func resolveSkin() {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync/stats/dateindicator.css")
        super.resolveSkin()
        dateText = addSubView(TextArea.init(text: "00/00/00 - 00/00/00", size: CGSize(0,0), id: "date"))/*A TextField that displays the time range of the graph*/
    }

    override func getClassType() -> String {
        return "DateIndicator"
    }
}


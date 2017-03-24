import Foundation
@testable import Utils
@testable import Element

class Graph5:ContainerView2{
    let dayNames:[String] = ["M","T","W","T","F","S","S"]
    let monthNames:[String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let yearNames:[String] = ["11","12","13","14","15","16","17"]
    //TimeBar with 7 items
    //gesture recognizer
    //change timeBar textFields on gesture event
    override func resolveSkin() {
        StyleManager.addStyle("Graph5{fill:green;fill-alpha:0.5;}")
        super.resolveSkin()
    }
}

import Foundation
protocol IElement:IView{
    mutating func resolveSkin()
    var style:IStyle{get}
    func setStyle(style:IStyle)
    func getClassType()->String
    var skinState:String{get}
}
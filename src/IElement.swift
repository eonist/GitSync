import Foundation
protocol IElement:IView{
    func resolveSkin()
    var style:IStyle{get set}
}
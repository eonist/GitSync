import Foundation

class Style:IStyle{
    static var clear:IStyle = Style("clear",[StyleProperty("idleColor",0xFF0000),StyleProperty("overColor",0x0000FF)])
    var name:String;
    var styleProperties:Array<IStyleProperty>
    init(_ name:String, _ styleProperties:Array<IStyleProperty>){
        self.name = name
        self.styleProperties = styleProperties
    }
}
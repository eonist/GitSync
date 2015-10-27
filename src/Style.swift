import Foundation

class Style:IStyle{
    static var clear:IStyle = Style("clear",[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])
    var name:String;
    var styleProperties:Array<IStyleProperty>
    init(_ name:String, _ styleProperties:Array<IStyleProperty>){
        self.name = name
        self.styleProperties = styleProperties
    }
}
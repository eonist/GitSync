import Foundation

class Style:IStyle{
    var name:String;
    var styleProperties:Array<IStyleProperty>
    init(_ name:String, _ styleProperties:Array<IStyleProperty>){
        self.name = name
        self.styleProperties = styleProperties
    }
}
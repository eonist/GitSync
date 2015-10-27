import Foundation

class Style:IStyle{
    static var clear:IStyle = Style("clear",[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])
    var name:String;
    var styleProperties:Array<IStyleProperty>
    init(_ name:String, _ styleProperties:Array<IStyleProperty>){
        self.name = name
        self.styleProperties = styleProperties
    }
    
    func getStyleProperty(name:String)->IStyleProperty{
        for styleProperty : IStyleProperty in _styleProperties) {
            if(styleProperty.name == name && styleProperty.depth == depth) return styleProperty;
        }
        return null;
    }
}
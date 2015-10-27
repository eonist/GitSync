import Foundation

class Style:IStyle{
    static var clear:IStyle = Style("clear",[StyleProperty("idleColor",0x000000),StyleProperty("idleOpacity",0)])
    var name:String;
    var styleProperties:Array<IStyleProperty>
    init(_ name:String, _ styleProperties:Array<IStyleProperty> = []){
        self.name = name
        self.styleProperties = styleProperties
    }
    /**
     * @return a style property by the name given
     * @Note returning null is fine, no need to make a EmptyStyleProperty class, or is there?
     */
    func getStyleProperty(name:String)->IStyleProperty?{
        for styleProperty : IStyleProperty in styleProperties {
            if(styleProperty.name == name){
                return styleProperty;
            }
        }
        return nil;
    }
}
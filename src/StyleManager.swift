import Foundation
class StyleManager{
    static var styles:Array<IStyle> = []
    
    func getStyle(name:String):IStyle{
        var numOfStyles:int = _styles.length;
        for(var i:int = 0;i < numOfStyles;i++) if(IStyle(_styles[i]).name == name) return  _styles[i];
        return null;
    }
}
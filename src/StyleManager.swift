import Foundation
class StyleManager{
    static var styles:Array<IStyle> = []
    
    class func getStyle(name:String)->IStyle?{
        let numOfStyles:Int = styles.count;
        for(var i:Int = 0;i < numOfStyles;i++) {
            if((styles[i] as IStyle).name == name) {
                return styles[i];
            }
        }
        return nil;
    }
}
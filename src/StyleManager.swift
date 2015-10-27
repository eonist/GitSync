import Foundation
class StyleManager{
    static var styles:Array<IStyle> = []
    /**
    * Adds a style to the styleManager class
    * @param style: IStyle
    */
    class func add(style:IStyle){
        styles.append(style);
    }
    class func add(styles:Array<IStyle>){
        styles.append(style);
    }
    
    /**
    * Locates and returns a Style by the @param name.
    * @return a Style
    */
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
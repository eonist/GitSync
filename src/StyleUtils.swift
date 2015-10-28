import Foundation
class StyleUtils {
    /**
     * Clones a style
     * CSSParser.as, StyleHeritageResolver.as uses this function
     * // :TODO: explain what newSelectors does
     */
    class func clone(style:IStyle, newName:String? = nil)->IStyle{
        let returnStyle:IStyle = Style(newName ?? style.name);
        for styleProperty : IStyleProperty in style.styleProperties{
            returnStyle.addStyleProperty(StyleProperty(styleProperty.name, styleProperty.value));
        }
        return returnStyle;
    }
    /**
    *
    */
    class func overrideStyleProperty(style:IStyle, styleProperty:IStyleProperty){
        var stylePropertiesLength:Int = style.styleProperties.count;
        for (var i:Int=0; i<stylePropertiesLength; i++) { // :TODO: use fore each
            if(IStyleProperty(style.styleProperties[i]).name == styleProperty.name){
                style.styleProperties[i] = styleProperty;
                return;
            }
        }
        Swift.print("\(String(style))"+" PROPERTY BY THE NAME OF "+styleProperty.name+" WAS NOT FOUND IN THE PROPERTIES ")//this should throw error
    }
}


/**
*
*/
public static function overrideStyleProperty(style:IStyle, styleProperty:IStyleProperty):void {// :TODO: argument should only be a styleProperty
    
}
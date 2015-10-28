import Foundation
class StyleUtils {
    /**
     * Clones a style
     * CSSParser.as, StyleHeritageResolver.as uses this function
     * // :TODO: explain what newSelectors does
     */
    class func clone(style:IStyle, newName:String = null, newSelectors:Array = null)->IStyle{
        var returnStyle:IStyle = new Style(newName || style.name, newSelectors || style.selectors, []);
        for each (var styleProperty : IStyleProperty in style.styleProperties) returnStyle.addStyleProperty(new StyleProperty(styleProperty.name, styleProperty.value, styleProperty.depth));
        return returnStyle;
    }
}
import Foundation
class StyleUtils {
    /**
     * Clones a style
     * CSSParser.as, StyleHeritageResolver.as uses this function
     * // :TODO: explain what newSelectors does
     */
    class func clone(style:IStyle, newName:String? = nil)->IStyle{
        var returnStyle:IStyle = Style(newName ?? style.name);
        for styleProperty : IStyleProperty in style.styleProperties{
            returnStyle.addStyleProperty(new StyleProperty(styleProperty.name, styleProperty.value, styleProperty.depth));
        }
        return returnStyle;
    }
}
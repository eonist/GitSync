import Cocoa

class WinView3:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        titlebarTest()
        //iconBarTest()
        //depthTest()
        //assetCSSTest()
        //svgTest()
        
        //let result = SVGPathParser.parameters("-75,53.571-147.029,36.822-185-89.748")//[-75.0, 53.571, -147.029, 36.822, -185.0, -89.748]
        //Swift.print("result: " + "\(result)")

        //debugRegExpDigitPattern()
        //regExpBackRefTest()
    }
    /**
     * TODO: targeting "Button" should work even if the button has an id
     */
    func titlebarTest(){
        var css:String = "Button#close{"
        css += "fill:~/Desktop/icons/titlebar/close.svg none;"
        css += "width:12px,12px;"
        css += "height:12px,12px;"
        css += "margin-left:8px,8px;"
        css += "margin-top:4px,4px;"
        css += "}"

        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        
        let styleProperty = styleCollection.getStyle("Button#close")?.getStyleProperty("fill")
        Swift.print("styleProperty.value: " + String(styleProperty!.value))
        
        StyleManager.addStyle(styleCollection.styles)
        let btn1 = Button(64,64,nil,"close")/*<--the w and h should be NaN, test if it supports this*/
        //btn1.setPosition(CGPoint(10,20))
        self.addSubview(btn1)
    }
    /**
     *
     */
    func iconBarTest(){
        
    }
    /**
     * Add depth to the framework (svgasset is useless without it, and floating wont be that hard anyways, its the last thing)
     */
    func depthTest(){
        let css:String = "Element{fill:blue,red;width:64px,32px;height:64px,32px;}"//,blue 0.33 0.4724 //,red;fill-alpha:1,0.5;
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        let style:IStyle = styleCollection.getStyle("Element")!
        let styleProperty:IStyleProperty = style.getStyleProperty("fill")!
        let value = styleProperty.value
        Swift.print("WinView3.depthTest() value: " + "\(value)")
        
        StyleManager.addStyle(styleCollection.styles)
        let element:Element = Element(200,200)
        addSubview(element)
    }
    func assetCSSTest(){
        var path = "~/Desktop/icons/"
        path += "search.svg"
        let css:String = "Element{fill:red," + path + " green;}"//,blue 0.33 0.4724,red,
        Swift.print("css: " + "\(css)")
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        let style:IStyle = styleCollection.getStyle("Element")!
        let styleProperty:IStyleProperty = style.getStyleProperty("fill")!
        Swift.print("styleProperty.value: " + "\(styleProperty.value)")
        //let assetURL:String = styleProperty.value as! String
        //Swift.print("assetURL: " + "\(assetURL)")
        
        //continue here, figure out how you dealt with svgasset and color, i think it has to do with assering class type is array etc
        
        StyleManager.addStyle(styleCollection.styles)
        let element:Element = Element(200,200)
        addSubview(element)
        /**/
    }
    /**
     *
     */
    func svgTest(){
        var path = "~/Desktop/icons/"//gradient_rect_2.svg,search.svg,rect.svg,cross.svg,rect.svg,circle.svg,cross_4.svg,line.svg,polyline.svg
        //path += "gradient_rect.svg"
        //path += "linear_gradient_polygon.svg"
        //path += "relative_linear_gradient_polygon.svg"
        //path += "relative_radial_gradient_polygon.svg"
        //path += "radial_gradient_polygon.svg"
        //path += "linear_gradient_stroke_polygon.svg"
        //path += "radial_gradient_stroke_polygon.svg"
        //path += "relative_linear_gradient_stroke_polygon.svg"
        //path += "radial_test.svg"
        //path += "ellipse_2.svg"
        //path += "maximize.svg"
        //path += "ellipse.svg"
        //path += "circle_top_shine.svg"
        //path += "close_btn.svg"
        //path += "close.svg"
        //path += "close_hover.svg"
        //path += "minimize.svg"
        //path += "radial_gradient_rect.svg"
        //path += "gradient_rect_2.svg"
        //path += "circle.svg"
        path += "rect.svg"
        //path += "cross.svg"
        //path += "cross_2.svg"
        //path += "search.svg"
        //path += "line.svg"
        //path += "ellipse_3.svg"
        //path += "roundrect.svg"
        //path += "titlebar_buttons.svg"
        
 
        let content = FileParser.content(path.tildePath)
        //Swift.print("content: " + "\(content)")
        
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        //Swift.print("rootElement.localName: " + "\(rootElement.localName)")
        //Swift.print("rootElement.childCount: " + "\(rootElement.childCount)")
        
        //let child:NSXMLElement = XMLParser.childAt(rootElement.children!, 0)!
        //Swift.print("child.stringValue: " + "\(child.stringValue)")
        //Swift.print("child.localName: " + "\(child.localName)")
        
        let svg:SVG = SVGParser.svg(rootElement);
        //Swift.print("svg.subviews.count: " + "\(svg.subviews.count)")
        //Swift.print("svg.subviews[0]: " + "\(svg.subviews[0])")
        
        //SVGParser.describeAll(svg)
        
        SVGModifier.style(svg, SVGStyle(Double(0xFF0000),1.0))
        SVGModifier.scale(svg, CGPoint(), CGPoint(4,4));
        //SVGUtils.dsc(svg, CGPoint(), CGPoint(2,2));
        
        //SVGModifier.offsetItems(svg, CGPoint(20,20))
        
        addSubview(svg);
        
    }
    
    
    
    func debugRegExpDigitPattern(){
        let testCases:Array<String> = ["2.3","2","44","22.11","-2.3","-2","-44","-22.11","20.",".10",".3","1.",".","-20.","-.10","-.3","-1.","-."]
        
        let g1:String = "(?=\\s|^)"/*must be preceeded by a space char or the begining*/
        let g6:String = "(?=$)"/*followed by an end or */
        
        let pattern:String = g1 + RegExpPattern.digitAssertPattern + g6
        for testCase in testCases{
            Swift.print(testCase.test(pattern))
        }
    }
    func regExpBackRefTest(){
        let str:String = "86,26.288 64,48.916 41.373,26.287 -26.288,41.372 48.916,6 26.289,86.628   41.373,101.713 64,79.085 86.627,101.712 101.713,86.627 79.086,64 101.713,41.372"
        let part1:String = "(?<=^|\\,|\\s|px|\\b)"/*group 1, preseeding match must aprear but is not included in the final result */
        //let part2:String = "\\-?\\d*?"/*optional minus sign followed by a digit zero or more times*/
        //let part3:String = "(\\.?)"/*group 2, optional dot char*/
        //let part4:String = "(($1)\\d+?)"/*group 3, if there is a match in group 1 and followed by a digit more than zero times*/
        let part5:String = "(?=px|\\s|\\,|\\-|$)"/*group 4,the subseeding pattern must apear, but is not included in the match, the pattern is: px*/
        let pattern:String = part1 + RegExpPattern.digitAssertPattern + part5
        let stringArray:Array<String> = str.match(pattern);
        Swift.print("stringArray: " + "\(stringArray)")
        //let array:Array<CGFloat> = stringArray.map {CGFloat(Double($0)!)}//<--temp fix
    }
}

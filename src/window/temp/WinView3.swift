import Cocoa

class WinView3:FlippedView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        /*
        let temp:Any = Double.NaN
        Swift.print("temp: " + "\(temp)")
        */
        
        svgTest()
        //let result = SVGPathParser.parameters("-75,53.571-147.029,36.822-185-89.748")//[-75.0, 53.571, -147.029, 36.822, -185.0, -89.748]
        //Swift.print("result: " + "\(result)")

        //debugRegExpDigitPattern()
        //regExpBackRefTest()
    }
    /**
     *
     */
    func svgTest(){
        var path = "~/Desktop/icons/"//gradient_rect_2.svg,search.svg,rect.svg,cross.svg,rect.svg,circle.svg,cross_4.svg,line.svg,polyline.svg
        //path += "gradient_rect.svg"
        //path += "linear_gradient_polygon.svg"
        path += "radial_gradient_polygon.svg"
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
        //SVGParser.describeAll(svg)
        //SVGModifier.scale(svg, CGPoint(), CGPoint(4,4));
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

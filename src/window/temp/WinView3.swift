import Cocoa

class WinView3:NSView {
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        createContent()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    func createContent(){
        
        
        //debugRegExpDigitPattern()
        //svgTest()
        regExpBackRefTest()
        
    }
    func debugRegExpDigitPattern(){
        let testCases:Array<String> = ["2.3","2","44","22.11","-2.3","-2","-44","-22.11","20.",".10",".3","1.",".","-20.","-.10","-.3","-1.","-."]
        
        let g1:String = "(?=\\s|^)"/*must be preceeded by a space char or the begining*/
        let g6:String = "(?=$)"/*followed by an end or */
        
        let pattern:String = g1 + digitAssertPattern + g6
        for testCase in testCases{
            Swift.print(testCase.test(pattern))
        }
    }
    var digitAssertPattern:String{
        //let g1:String = "(?=\\s|^)"/*must be preceeded by a space char or the begining*/
        let g2:String = "\\-*\\d+?"/*optional minus sign followed by one or more digits*/
        let g3:String = "(?=\\.\\d|\\s|,|$)"/*Must be followed by a dot with a digit or space, comma or end*/
        let g4:String = "((?<=\\d)\\.(?=\\d))*"/*zero or one dot char that must be preceeded with a digit and subseeded wutha digit*/
        let g5:String = "((?<=\\d\\.)\\d+?)*"/*zero or more digits that must be preceeded with a digit and a char*/
        //let g6:String = "(?=$)"/*followed by an end or */
        
        let pattern:String = /*g1 +*/ g2 + g3 + g4 + g5 /*+ g6*/
        return pattern
    }
    /**
     *
     */
    func svgTest(){
        let path = "~/Desktop/icons/cross.svg".tildePath
        let content = FileParser.content(path)
        //Swift.print("content: " + "\(content)")
        
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        //Swift.print("rootElement.localName: " + "\(rootElement.localName)")
        //Swift.print("rootElement.childCount: " + "\(rootElement.childCount)")
        
        
        //let child:NSXMLElement = XMLParser.childAt(rootElement.children!, 0)!
        //Swift.print("child.stringValue: " + "\(child.stringValue)")
        //Swift.print("child.localName: " + "\(child.localName)")
        
        let svg:SVG = SVGParser.svg(rootElement);
        SVGParser.describeAll(svg)
        //SVGModifier.scale(svg, CGPoint(), CGPoint(2,2));
        //addSubview(svg);
    }
    func regExpBackRefTest(){
        
        //continue here: it may be the \\s or it may be the backref. Take a look at the css regexp and also do isolated test with capturing a single number with space etc
        
        let str:String = "86.629,26.288 64,48.916 41.373,26.287 26.288,41.372 48.916,64 26.289,86.628   41.373,101.713 64,79.085 86.627,101.712 101.713,86.627 79.086,64 101.713,41.372"
        let part1:String = "(?<=^|\\,|\\s|px|\\b)"/*group 1, preseeding match must aprear but is not included in the final result */
        let part2:String = "\\-?\\d*?"/*optional minus sign followed by a digit zero or more times*/
        let part3:String = "(\\.?)"/*group 2, optional dot char*/
        let part4:String = "(($1)\\d+?)"/*group 3, if there is a match in group 1 and followed by a digit more than zero times*/
        let part5:String = "(?=px|\\s|\\,|\\-|$)"/*group 4,the subseeding pattern must apear, but is not included in the match, the pattern is: px*/
        let pattern:String = part1 + part2 + part3 + part4 + part5
        let stringArray:Array<String> = str.match(pattern);
        Swift.print("stringArray: " + "\(stringArray)")
        //let array:Array<CGFloat> = stringArray.map {CGFloat(Double($0)!)}//<--temp fix
    }
}

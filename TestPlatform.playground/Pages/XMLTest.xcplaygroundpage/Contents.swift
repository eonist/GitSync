import Foundation


let xmlStr:String = "<media>" +
                        "<book>The shining</book>" +
                        "<music type=\"digital\"></music>" +
                        "<movie title=\"Psycho\"/>" +
                    "</media>"
func testing(){
    let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: xmlStr, options: 0)
    let rootElement:NSXMLElement = xmlDoc.rootElement()!
    let children:NSArray = rootElement.children!
    let count = children.count//or use rootElement.childCount
    let a = XMLParser.childAt(children, 0)
    XMLParser.value(a!)
    for (var i = 0; i < count; i++) {
        let child:NSXMLElement = XMLParser.childAt(children, i)!
        if let type:String = XMLParser.attribute(child, "type") { print("type: " + type) }
        //print(XMLParser.attribute(child, "type"))
        let attributes:[Dictionary<String,String>] = XMLParser.attributes(child)
        if(attributes.count > 0) {  print(attributes[0]["value"]) }
           
        print(XMLParser.value(child))
        
        //
        print(XMLAsserter.hasAttribute(child,"type"))
        //XPath expressions
    }
}

testing()


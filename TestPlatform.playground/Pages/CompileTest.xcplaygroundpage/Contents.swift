import Foundation

/*


//then start stub coding
//then test one level at the time


*/

let xmlStr:String = "<repositories>" +
                        "<repository local-path=\"~/_projects/_code/_active/swift/swift-utils\" remote-path=\"https://github.com/eonist/swift-utils.git\" interval=\"1\" keychain-item-name=\"github\"/>" +
                        "<repository local-path=\"~/Library/Scripts\" remote-path=\"github.com/eonist/applescripts.git\" interval=\"1\" keychain-item-name=\"github\"/>" +
                    "</repositories>"


let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: xmlStr, options: 0)
let rootElement:NSXMLElement = xmlDoc.rootElement()!
let children:NSArray = rootElement.children!
let count = children.count//or use rootElement.childCount
let a = XML.childAt(children, 0)



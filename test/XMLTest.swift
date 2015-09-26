//xml parsing test
//https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/NSXMLParserDelegate_Protocol/index.html#//apple_ref/occ/intfm/NSXMLParserDelegate/parser:foundCharacters:
//https://github.com/tadija/AEXML
//xmlparser lib: https://github.com/Mozharovsky/XMLParser
//try this tut http://www.ihartdevelopers.com/xml-parsing-using-nsxmlparser-in-swift/

//ok so here is how the xml parser works. it runs through an xml displayObjectContainer and triggers the different elements in the doc. the element, the content.
//so to access the different parts you need to store the different parts in dictionaries and arrays. 















//other peoples work:
import Foundation
import Cocoa

let path = "//Users/<path>/someFile.xml"

var err: NSError?
let content = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: &err)


//get filepath
The NSXMLDocument usage would look like:

let fm = NSFileManager.defaultManager()
var err : NSError?
let userDirectory = fm.URLForDirectory(.UserDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false, error: &err)
if err != nil {
  // ...
}

if let path = userDirectory?.URLByAppendingPathComponent("someFile.xml") {
  NSXMLDocument(contentsOfURL: configURL, options: 0, error: &err)
  if err != nil {
    // ...
  }

  if let rootNode = config?.rootElement() {
    // ...
  }
}

//try the bellow:

class CategoryParser: NSObject, NSXMLParserDelegate {

    var subcategories = [[String : String]]()
    var currentSubcategory: [String : String]?
    var currentElementName: String?

    var completion: (([[String : String]]) -> ())?

    func parseXML( string: String, completion: (([[String : String]]) -> ())? ) {
        guard let data = string.dataUsingEncoding( NSUTF8StringEncoding ) else {
            fatalError( "Base XML data" )
        }
        self.completion = completion
        let parser = NSXMLParser(data: data )
        parser.delegate = self
        parser.parse()
    }

    func parserDidEndDocument(parser: NSXMLParser) {
        self.completion?( self.subcategories )
    }

    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print( "Parse error: \(parseError)" )
    }

    func parser(parser: NSXMLParser, foundCharacters string: String) {

        if let elementName = self.currentElementName {
            if [ "id", "name" ].contains( elementName ) {
                self.currentSubcategory?[ elementName ] = string
            }
        }
    }

    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "category", let subcategory = self.currentSubcategory {
            self.subcategories.append( subcategory )
            self.currentSubcategory = nil
        }
    }

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {

        if elementName == "category" {
            self.currentSubcategory = [String : String]()
        }
        else {
            self.currentElementName = elementName
        }
    }
}



let categoryParser = CategoryParser()
let xmlString = "<subCategories><category><id>someId</id><name>someName</name></category></subCategories>"
categoryParser.parseXML( xmlString ) { (categories) in
    print( categories )
}
//xml parsing test
//https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/NSXMLParserDelegate_Protocol/index.html#//apple_ref/occ/intfm/NSXMLParserDelegate/parser:foundCharacters:
//https://github.com/tadija/AEXML
//xmlparser lib: https://github.com/Mozharovsky/XMLParser. (doesnt support attributes)
//try this tut http://www.ihartdevelopers.com/xml-parsing-using-nsxmlparser-in-swift/
//great explination of how nsxml works https://medium.com/@lucascerro/understanding-nsxmlparser-in-swift-xcode-6-3-1-7c96ff6c65bc

//ok so here is how the xml parser works. it runs through an xml displayObjectContainer and triggers the different elements in the doc. the element, the content.
//so to access the different parts you need to store the different parts in dictionaries and arrays. 


//the concept: 
//TODO: what if you combine array and dictionary to: settingsXml["picture"][2]["file"][0]["content"]

<categories>
	<category>
		<item color:"blue" type:"car"></item>
		<item>text goes here</item>
		<item/>
		<container/>
	</category>
	<category/>
</categories>
//NOTE: if you have an attr named content and the child value needs to be inside content then to differentiate the two you need to rename the attr to somethin unique, this is out of the scope for this method though, so in that case just dont parse xmls with attr named content, if you do have to do it then just wrap this method into another with this extended functionality.
//this is how you should navigate the result:
root["categories"][0]["category"][0]["color"]//"green" that is an attribute value of color
root["categories"][0]["category"][0]//{color:green,name:"tinits",content:{item:[{auther:john,age:2,content:"well designed car"},{},{}]}
//i guess optional chaining would suite the bellow line well:
root["categories"][0]["category"][0]["content"]["item"][0]["content"]//"well designed car"

//here is how it works:
//1. dictionaries store arrays of xml nodes of the same name
//2. dictionaries inside an array item store attributes and content of the xml node
//3. xml node content is stored in the dictionary under the key "content"
//4. content is stored as a string if its just text or as a dictonary with arrays of xml children (begin again from 1)

//this is how you handle xml attr:
for each(var attribute:XML in attributes) item[attribute.localName()] = attribute.toString();
//this is how you add the content of the child:
if(child.hasComplexContent()) item["xml"] = child;

//in swift:
var root:Dictionary = [:]//create an empty dictionary
var depth:Int = 0;//current node depth
var currentNode:Dictionary = root
var stringContent:String = ""//init the string to be stored
var prevElementName:String = ""
var curOpenElementName:String = ""
var hasClosed = false//has child closed
var element:Dictionary?
func parser(didStartElement elementName: String,namespaceURI: String?,qualifiedName: String?,attributes attributeDict: [NSObject : AnyObject]){	
	if(currentNode[elementName] == nil){//if there is no array accociated with elementName, then add a new array to store children with the elementName
		var children:Array = []//create a new array to store all children with elementName
		currentNode[elementName] = children//create a new key/value pair to store all children with elementName
		currentNode[elementName].append(element)//add the element
	}else{//an array for elementName already exists, 
	
	}
	if(hasClosed == false){//means that your still inside a child
		
	}else{//means that you have moved to the next child
	
	}
	element = attributes//add attributes to the dictionary :TODO: make sure this value isnt nil
	currentNode[elementName].append(element)//add the element
	depth++;//incriment the depth
	curOpenElementName == elementName
}
func parser(foundCharacters: string: String?){
	//append string
	//if this is called then the element has a string in its body
	stringContent += foundCharacters
}
func parser(didEndElement elementName: String,namespaceURI: String?,qualifiedName qName: String){
	//append objects
	if (stringContent.isEmpty == false){
		currentNode[elementName][currentNode[elementName].count-1]["content"] = stringContent// :TODO: you should probably use a pointer ref here research further
		stringContent = ""//empty the string
	}
	if (elementName == curOpenElemntName){
		//close the child
		
		hasClosed = true//current node was closed
	}
	depth--;
}
	
//less important:
//parserDidStartDocument: 
	//init objects
//parserDidEndDocument:
	//return objects
//parser:didStartMappingPrefix:toURI:
//parser:didEndMappingPrefix:
//parser:resolveExternalEntityName:systemID:
//parser:parseErrorOccurred:
//parser:validationErrorOccurred:










//access an attribute:
//in didStartElement method;

if element.isEqualToString("enclosure") {
  var imgLink = attributeDict["url"] as String
}






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
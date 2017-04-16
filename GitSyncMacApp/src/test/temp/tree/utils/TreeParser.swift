import Foundation
@testable import Utils

class TreeParser {
    /**
     * Returns an an XML instance at PARAM: index (Array index)
     * NOTE: this function is recursive
     * NOTE: to find a child at an integer use the native code: xml.children[integer]
     * NOTE: to find the children of the root use an empty array as the index value
     */
    static func childAt(_ xml:XML?,_ index:[Int])->XML? {
        //Swift.print("index: " + "\(index)")
        if(index.count == 0 && xml != nil) {
            return xml
        }else if(index.count == 1 && xml != nil && xml!.child(at: index.first!) != nil) {//XMLParser.childAt(xml!.children!, index[0])
            return xml!.childByIndex(index[0])
        }// :TODO: if index.length is 1 you can just ref index
        else if(index.count > 1 && xml!.children!.count > 0) {
            return XMLParser.childAt(xml!.children![index.first!] as? XML,index.slice2(1,index.count))
        }
        return nil
    }
    func child(_ tree:Tree?,_ index:[Int])-> Tree?{
        if(index.count == 0 && tree != nil) {
            return tree
        }else if(index.count == 1 && tree != nil && tree!.child(index.first!) != nil) {//XMLParser.childAt(xml!.children!, index[0])
            return tree!.child(index[0])
        }// :TODO: if index.length is 1 you can just ref index
        else if(index.count > 1 && xml!.children!.count > 0) {
            return XMLParser.childAt(xml!.children![index.first!] as? XML,index.slice2(1,index.count))
        }
        return nil
    }
}

import Foundation

class Style {
    var name:String;
    var selectors:Array
    init(_ name:String, _ selectors:Array, _ styleProperties:Array){
        self.name = name
        self.selectors = selectors
    }
}
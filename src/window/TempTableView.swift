import Foundation
import Cocoa
/*
 * Note: Apparently an NSTableViewDataSource must be in the tableview it self
 */
class TempTableView:NSTableView,NSTableViewDataSource,NSTableViewDelegate{
    let monthNames:Array = ["March","April","May"]
    let data:[Dictionary<String,String>] = [["Name":"John","Age":"19"],["Name":"Judith","Age":"22"]]
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return monthNames.count;
    }
    func tableView(tableView: NSTableView,objectValueForTableColumn tableColumn: NSTableColumn?,row: Int) -> AnyObject?{
        return monthNames[row]
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        // get the item for the row
        let item:Dictionary<String,String> = data[row]
        
        // get the NSTableCellView for the column
        let result : NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        // set the string value of the text field in the NSTableCellView
        result.textField?.stringValue = item.valueForKey(tableColumn!.identifier) as! String
        
        // return the populated NSTableCellView
        return result
        
    }
}
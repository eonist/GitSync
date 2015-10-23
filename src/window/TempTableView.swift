import Foundation
import Cocoa
/*
 * Note: Apparently an NSTableViewDataSource must be in the tableview it self
 * TODO: add the repo xml to the table
 * create a table design: active toggle on the right, repo + branch name and the status indicator on the left.
 * NOTE: Great:  https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSTableView_Class/ Google: "NSTableView class reference" for good documentation
 * NOTE: Info about NSTableView: http://objc.toodarkpark.net/AppKit/Classes/NSTableView.html#//apple_ref/occ/instm/NSTableView/delegate
 */
class TempTableView:NSTableView,NSTableViewDataSource,NSTableViewDelegate{
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        //add eventlisteners
        self.target = self//event dispataches to this instance
        self.action = "myAction:"//event dispatches to this method
        allowsColumnResizing = false
        allowsMultipleSelection = true
        
        
        
        
        
        
        
    }
    /**
    *
    */
    func myAction(obj:AnyObject!){
        Swift.print("My class is \((obj as! NSObject).className)")
    }
    /*
    * Requeired when overiding init
    */
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //let monthNames:Array = ["March","April","May"]
    let data:[Dictionary<String,String>] = [["status":"Green","remote-repo":"Gitsync", "branch":"master","active":"true"],["status":"Yellow","remote-repo":"Element", "branch":"development","active":"false"]]
    /*
    * Required by NSTableView
    */
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return data.count;
    }
    /*
    * Populates the tableview cells
    */
    func tableView(tableView: NSTableView,objectValueForTableColumn tableColumn: NSTableColumn?,row: Int) -> AnyObject?{
        //Swift.print((tableColumn?.title)! + " " + (tableColumn?.identifier)!)
        //Swift.print("fire a")
        
        return data[row][(tableColumn?.identifier)!]
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        Swift.print("tableViewSelectionDidChange")
        //selectColumnIndexes(<#T##indexes: NSIndexSet##NSIndexSet#>, byExtendingSelection: <#T##Bool#>)
    }
    func tableView(tableView: NSTableView, didClickTableColumn tableColumn: NSTableColumn) {
        Swift.print("Selection didClickTableColumn")
    }
    func tableView(tableView: NSTableView, mouseDownInHeaderOfTableColumn tableColumn: NSTableColumn) {
        Swift.print("Selection mouseDownInHeaderOfTableColumn")
    }
    
    /*
    This is for custom design i guess
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        Swift.print("fire b")
        // get the item for the row
        let item:Dictionary<String,String> = data[row]
        
        // get the NSTableCellView for the column
        let result : NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        
        // set the string value of the text field in the NSTableCellView
        result.textField?.stringValue = item[tableColumn!.identifier]!//(tableColumn!.identifier) as! String
        
        // return the populated NSTableCellView
        return result
    }
    */
}


//AllowsColumnSelection:
//allowsEmptySelection
//AllowsColumnReordering:
/*
//display attributes
- setIntercellSpacing:
- intercellSpacing
- setRowHeight:
- rowHeight
- setBackgroundColor:
- backgroundColor

//manipulate
addTableColumn:
- removeTableColumn:
- moveColumn:toColumn:
- tableColumns
- columnWithIdentifier:
- tableColumnWithIdentifier:

Selecting columns and rows
- selectColumn:byExtendingSelection:
- selectRow:byExtendingSelection:
- deselectColumn:
- deselectRow:
- numberOfSelectedColumns
- numberOfSelectedRows
- selectedColumn
- selectedRow
- isColumnSelected:
- isRowSelected:
- selectedColumnEnumerator
- selectedRowEnumerator
- selectAll:
- deselectAll:


Getting the dimensions of the table
- numberOfColumns
- numberOfRows

Setting grid attributes
- setDrawsGrid:
- drawsGrid
- setGridColor:
- gridColor


Editing cells
- editColumn:row:withEvent:select:
- editedRow
- editedColumn


Layout support
- rectOfColumn:
- rectOfRow:
- columnsInRect:
- rowsInRect:
- columnAtPoint:
- rowAtPoint:
- frameOfCellAtColumn:row:
- setAutoresizesAllColumnsToFit:
- autoresizesAllColumnsToFit
- sizeLastColumnToFit
- sizeToFit
- noteNumberOfRowsChanged
- tile
*/





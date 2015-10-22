import Foundation
import Cocoa
/*
 * Note: Apparently an NSTableViewDataSource must be in the tableview it self
 */
class TempTableView:NSTableView,NSTableViewDataSource,NSTableViewDelegate{
    let monthNames:Array = ["March","April","May"]
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return monthNames.count;
    }
    func tableView(tableView: NSTableView,objectValueForTableColumn tableColumn: NSTableColumn?,row: Int) -> AnyObject?{
        return monthNames[row]
    }
}
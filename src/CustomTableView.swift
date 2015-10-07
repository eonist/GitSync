import Foundation
import Cocoa
class CustomTableView:NSTableView,NSTableViewDataSource,NSTableViewDelegate{
    let nameArray:Array = ["March","April","May"]
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return nameArray.count;
    }
    func tableView(tableView: NSTableView,objectValueForTableColumn tableColumn: NSTableColumn?,row: Int) -> AnyObject?{
        return nameArray[row]
    }

}
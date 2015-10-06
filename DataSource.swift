import Cocoa
import Foundation
class DataSource:NSObject, NSTableViewDataSource{
    let nameArray:Array = ["March","April","May"]
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return nameArray.count;
    }
    func tableView(tableColumn: NSTableColumn?, row: Int)->AnyObject?{
        return "test"//nameArray[row]
    }

    // (id)tableView:(NSTableView *)aTable objectValueForColumn:(NSTableColumn *)aCol row:(int)aRow;

    //tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
}
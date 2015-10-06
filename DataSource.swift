import Cocoa
import Foundation
class DataSource:NSTableView, NSTableViewDataSource{
    let nameArray:Array = ["March","April","May"]
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return nameArray.count;
    }
    func tableView(objectValueForTableColumn:NSTableColumn,row:Int)->Any{
        return nameArray[row]
    }
    
    // (id)tableView:(NSTableView *)aTable objectValueForColumn:(NSTableColumn *)aCol row:(int)aRow;

    //tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
}
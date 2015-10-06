import Cocoa
import Foundation
class DataSource:NSTableView, NSTableViewDataSource{
    let nameArray:Array = ["March","April","May"]
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return nameArray.count;
    }
    func objectValueForColumn(row:Int)->NSTableView{
        return nil
    }
    
    // (id)tableView:(NSTableView *)aTable objectValueForColumn:(NSTableColumn *)aCol row:(int)aRow;

    //tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
}
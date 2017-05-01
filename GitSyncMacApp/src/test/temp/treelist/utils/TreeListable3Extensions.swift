import Foundation

extension TreeListable3 {
    //add convenience methods here
    var selected:Tree? {return TreeList3Parser.selected(self)}
    func open(_ idx3d:[Int]){/*Convenience*/
        TreeList3Modifier.open(self, idx3d)
    }
    func close(_ idx3d:[Int]){/*Convenience*/
        TreeList3Modifier.close(self, idx3d)
    }
}

import Foundation
@testable import Element
@testable import Utils

class TimeBar2:TimeBar{
    init(_ width: CGFloat, _ height: CGFloat, _ items:[String], _ parent: IElement?, _ id: String?) {
        super.init(width, height, items.count, parent, id)
    }
    override func createItems() {
        //
    }
    override func getClassType() -> String {
        return "\(TimeBar.self)"
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
}

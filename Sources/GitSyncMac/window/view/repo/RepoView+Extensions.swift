import Foundation
@testable import Utils
@testable import Element

extension RepoView{
    func onTreeListSelect() {
        let selectedIndex: [Int] = treeList.selectedIdx3d!
        //Swift.print("selectedIndex: " + "\(selectedIndex)")
        Nav.setView(.detail(.repo(selectedIndex)))/*Updates the UI elements with the selected repo data*/
    }
    /**
     *
     */
    func createTreeList() -> TreeList5{
        let size = CGSize(self.getWidth(), self.getHeight())
//        Swift.print("size: " + "\(size)")
        let thumbSize = CGSize(self.getWidth(),24)
//        Swift.print("thumbSize: " + "\(thumbSize)")
        let treeList: TreeList5 = .init(config: .init(itemSize: thumbSize, dp: RepoView.treeDP, dir: .ver), size: size)
        return  self.addSubView(treeList)//TreeList3(size.w,size.h,thumbSize , RepoView.treeDP, self)
        //if(RepoView.selectedListItemIndex.count > 0){TreeListModifier.selectAt(treeList!, RepoView.selectedListItemIndex)}
    }
}

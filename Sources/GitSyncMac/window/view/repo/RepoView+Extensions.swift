import Foundation
@testable import Utils
@testable import Element

extension RepoView{
    func onTreeListSelect(){
        let selectedIndex:[Int] = treeList.selectedIdx3d!
        //Swift.print("selectedIndex: " + "\(selectedIndex)")
        Nav.setView(.detail(.repo(selectedIndex)))/*Updates the UI elements with the selected repo data*/
    }
    /**
     *
     */
    func createTreeList() -> TreeList3{
        let size = CGSize(self.getWidth(), self.getHeight())
//        Swift.print("size: " + "\(size)")
        let thumbSize = CGSize(self.getWidth(),24)
//        Swift.print("thumbSize: " + "\(thumbSize)")
        return  self.addSubView(TreeList3(size.w,size.h,thumbSize , RepoView.treeDP, self))
        //if(RepoView.selectedListItemIndex.count > 0){TreeListModifier.selectAt(treeList!, RepoView.selectedListItemIndex)}
    }
}


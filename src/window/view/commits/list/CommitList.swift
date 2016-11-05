import Foundation

class CommitList:RBSliderFastList{
    override func spawn(idx: Int) -> Element {
        let dpItem = dataProvider.items[idx]
        let item:CommitsListItem = CommitsListItem(width, itemHeight ,dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!, false, self.lableContainer)
        return item
    }
    override func spoof(listItem:FastListItem) {
        let item:CommitsListItem = listItem.item as! CommitsListItem
        let idx:Int = listItem.idx/*the index of the data in dataProvider*/
        let dpItem = dataProvider.items[idx]
        let title:String = dpItem["title"]!
        let selected:Bool = idx == selectedIdx//dpItem["selected"]!.bool
        if(item.selected != selected){item.setSelected(selected)}//only set this if the selected state is different from the current selected state in the ISelectable
        item.setData(<#T##repoName: String##String#>, <#T##contributor: String##String#>, <#T##title: String##String#>, <#T##desc: String##String#>, <#T##date: String##String#>)
    }
}

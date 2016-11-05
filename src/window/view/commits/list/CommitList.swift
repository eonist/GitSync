import Foundation

class CommitList:RBSliderFastList{
    override func spawn(idx: Int) -> Element {
        let dpItem = dataProvider.items[idx]
        let item:CommitsListItem = CommitsListItem(width, itemHeight ,dpItem["repo-name"]!, dpItem["contributor"]!,dpItem["title"]!,dpItem["description"]!,dpItem["date"]!, false, self.lableContainer)
        return item
    }
    override func spoof(listItem: FastListItem) {
    }
}

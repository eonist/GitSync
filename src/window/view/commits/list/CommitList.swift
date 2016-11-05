import Foundation

class CommitList:RBSliderFastList{
    override func spawn(idx: Int) -> Element {
        let item:CommitsListItem = CommitsListItem(width, itemHeight ,object["repo-name"]!, object["contributor"]!,object["title"]!,object["description"]!,object["date"]!, false, self.lableContainer)
        lableContainer!.addSubviewAt(item, i)/*the first index is reserved for the List skin, what?*/
        return item
    }
    override func spoof(listItem: FastListItem) {
    }
}

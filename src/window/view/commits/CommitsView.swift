import Foundation

class CommitsView:Element {
    static let w:CGFloat = MainView.w
    static let h:CGFloat = MainView.h-36-36
    var list:CommitsList?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        createList()
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        let xml = FileParser.xml("~/Desktop/repo.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        Swift.print("dp.count(): " + "\(dp.count())")
        list = addSubView(CommitsList(320, height, NaN, dp, self,"commitsList"))
        ListModifier.selectAt(list!, 2)
    }
}
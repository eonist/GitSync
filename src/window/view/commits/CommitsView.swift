import Foundation

class CommitsView:Element {
    var list:CommitsList?
    override func resolveSkin() {
        super.resolveSkin()
        createList()
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        let xml = FileParser.xml("~/Desktop/repo.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        Swift.print("dp.count(): " + "\(dp.count())")
        list = addSubView(CommitsList(320, height, NaN, dp, self,"commitsList"))
        //ListModifier.selectAt(list!, 2)
    }
}
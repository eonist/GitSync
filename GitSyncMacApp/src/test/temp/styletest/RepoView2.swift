import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac
/**
 * 
 */
class RepoView2:Element {
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        let list:List3 = self.addSubView(List3(getWidth(), getHeight(), CGSize(NaN,NaN), dp,.ver, self))
        list.selectAt(1)
    }
    override func getClassType() -> String {
        return "\(RepoView.self)"
    }
}

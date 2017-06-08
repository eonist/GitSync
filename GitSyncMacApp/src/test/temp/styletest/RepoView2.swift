import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac
/**
 * 
 */
class RepoView2:Element {
    lazy var buttonSection:Section = {
        return self.addSubView(Section(NaN,NaN,self,"buttonSection"))
    }()
    lazy var backBtn:TextButton = {
        return self.buttonSection.addSubView(TextButton(NaN,NaN,"back",self.buttonSection,"back"))
    }()
    lazy var forwardBtn:TextButton = {
        return self.buttonSection.addSubView(TextButton(NaN,NaN,"forward",self.buttonSection,"forward"))
    }()
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        let list:ElasticSlideScrollFastList3 = self.addSubView(ElasticSlideScrollFastList3.init(getWidth(), getHeight(), CGSize(24,32), dp, self, "", .ver))
        list.selectAt(1)
    }
    override func getClassType() -> String {
        return "\(RepoView.self)"
    }
}

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
        return self.buttonSection.addSubView(TextButton(NaN,NaN,"Back",self.buttonSection,"back"))
    }()
    lazy var forwardBtn:TextButton = {
        return self.buttonSection.addSubView(TextButton(NaN,NaN,"Forward",self.buttonSection,"forward"))
    }()
    override func resolveSkin() {
        super.resolveSkin()//self.skin = SkinResolver.skin(self)//
        _ = backBtn
        _ = forwardBtn
        
        _ = self.addSubView(Element(NaN, NaN, self, "ruler"))
        
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        let list:ElasticSlideScrollFastList3 = self.addSubView(ElasticSlideScrollFastList3.init(getWidth(), getHeight(), CGSize(24,32), dp, self, "", .ver))
        list.selectAt(1)
    }
    override func onEvent(_ event: Event) {
        if event.type == ButtonEvent.upInside && event.origin === backBtn {
            Swift.print("back")
        }else if event.type == ButtonEvent.upInside && event.origin === backBtn {
            Swift.print("forward")
        }
    }
    override func getClassType() -> String {
        return "\(RepoView.self)"
    }
}

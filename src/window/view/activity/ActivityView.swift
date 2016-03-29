import Foundation

class ActivityView:Element {
    var topBar:ActivityTopBar?
    var list:List?
    override func resolveSkin() {
        StyleManager.addStyle("ActivityView{fill:white;fill-alpha:1;float:left;clear:none;corner-radius:0px 6px 0px 6px;}")/**/
        StyleManager.addStyle("ActivityView{padding-top:8px;}")//padding-left:6px;padding-right:6px;
        super.resolveSkin()
        topBar = addSubView(ActivityTopBar(width-30,24,self))
        createList()
    }
    func createList(){
        let dp:DataProvider = DataProvider()
        dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        
        StyleManager.addStyle("ActivityView List Container SelectTextButton{height:32px;}")
        StyleManager.addStyle("ActivityView List Container SelectTextButton Text{margin-top:8px;}")
        StyleManager.addStyle("ActivityView List{drop-shadow:none;}")
        
        //let xml = FileParser.xml("~/Desktop/repo.xml")
        //let dp:DataProvider = DataProvider(xml)
        list = addSubView(List(width, height, NaN, dp, self))
        ListModifier.selectAt(list!, 0)
        /**/

    }
}
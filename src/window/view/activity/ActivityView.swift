import Foundation

class ActivityView:Element {
    var topBar:ActivityTopBar?
    var list:ActivityList?
    override func resolveSkin() {
        StyleManager.addStyle("ActivityView{fill:white;fill-alpha:0;float:left;clear:none;corner-radius:0px 8px 0px 8px;}")/**/
        //StyleManager.addStyle("ActivityView{padding-top:0px;}")//padding-left:6px;padding-right:6px;
        super.resolveSkin()
        topBar = addSubView(ActivityTopBar(width,32,self))
        createList()
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        /*
        StyleManager.addStyle("ActivityView List Container SelectTextButton{height:32px;}")
        StyleManager.addStyle("ActivityView List Container SelectTextButton Text{margin-top:8px;}")
        StyleManager.addStyle("ActivityView List{drop-shadow:none;}")
        */
        let xml = FileParser.xml("~/Desktop/repo.xml")
        let dp:DataProvider = DataProvider(xml)
        list = addSubView(ActivityList(width, height, NaN, dp, self,"activityList"))
        ListModifier.selectAt(list!, 0)
    }
}
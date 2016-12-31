import Foundation

class ListTransitionTestWin:Window {
    required init(_ docWidth:CGFloat,_ docHeight:CGFloat){
        super.init(docWidth, docHeight)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter,CGPoint(6,0))/*aligns the window to the screen*/
    }
    override func resolveSkin() {
        Swift.print("frame.width: " + "\(frame.width)")
        Swift.print("frame.height: " + "\(frame.height)")
        self.contentView = ListTransitionTestView(frame.width,frame.height)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
import Foundation

class ListTransitionTestView:TitleView{
       override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, "listTransitionTestView")
    }
    override func resolveSkin() {
        Swift.print("ListTransitionTestView.resolveSkin()")
        super.resolveSkin()
        Swift.print(ElementParser.stackString(self))
        createGUI()
    }
    func createGUI(){
        rbSliderFastList2()
        //sliderFastList2()
        //fastList2()
        //sliderFastList()
        //fastList()
        //list()
    }
    func rbSliderFastList2(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/longlist.xml".tildePath)
        let list = self.addSubView(RBSliderFastList(140, 145, 24, dp, self))
        list
    }
    
    func sliderFastList2(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = self.addSubView(SliderFastList2(140, 73, 24, dp, self))
        list
    }
    func fastList2(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = addSubView(FastList2(140,73,24,dp,self))
        list
    }
    func sliderFastList(){
        var dp:DataProvider
        dp = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        //dp = DataProvider()
        //dp.addItem(["title":"pink"])
        
        let list = self.addSubView(SliderFastList(140, 73, 24, dp, self))
        //ListModifier.select(list, "white")
        FastListModifier.select(list, 5)
    }
    func fastList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = addSubView(FastList(140,73,24,dp,self))
        list
    }
    func list(){
        let dp = DataProvider(FileParser.xml("~/Desktop/ElCapitan/assets/xml/list.xml".tildePath))/*Loads xml from a xml file on the desktop*/
        let list = self.addSubView(List(140, 144, NaN, dp,self))
        list
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
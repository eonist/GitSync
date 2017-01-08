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
        fastList3()
        //dpTests()
        //rbSliderFastList2()
        //sliderFastList2()
        //fastList2()
        //sliderFastList()
        //fastList()
        //sliderList()
        //list()
    }
    /**
     *
     */
    func sliderFastList3(){
        //add small list
        //big list
    }
    /**
     *
     */
    func fastList3(){
        //add small list
        //big list
        //then start adding removing items
        
        let dp:DataProvider = DataProvider()//DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        //dp.addItem(["title":"pink"])
        //dp.addItem(["title":"orange"])
        //dp.addItem(["title":"purple"])
        let list = addSubView(FastList3(140,73,24,dp,self))
        list
    }
    /**
     * Try to add and remove items. count the items after
     */
    func dpTests(){
        let dp:DataProvider = DataProvider()//DataProvider("~/Desktop/ElCapitan/assets/xml/list.xml".tildePath)//longlist.xml
        
        func onDpChange(event:Event){
            if(event.type == DataProviderEvent.add){
                Swift.print("dp.count: " + "\(dp.count)")
            }
            if(event.type == DataProviderEvent.remove){
                Swift.print("dp.count: " + "\(dp.count)")
            }
        }
        dp.event = onDpChange
        dp.addItem(["title":"pink"])
        dp.addItem(["title":"orange"])
        dp.addItem(["title":"purple"])
        dp.removeItemAt(0)
        dp.removeItemAt(0)
        dp.removeItemAt(0)
    }
    func rbSliderFastList2(){
        let dp:DataProvider = DataProvider()//DataProvider("~/Desktop/ElCapitan/assets/xml/list.xml".tildePath)//longlist.xml
        dp.addItem(["title":"pink"])
        dp.addItem(["title":"orange"])
        dp.addItem(["title":"purple"])
        
        let list = self.addSubView(RBSliderFastList2(140, 145, 24, dp, self))
        list
    }
    func sliderFastList2(){
        let dp:DataProvider = DataProvider()//DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        dp.addItem(["title":"pink"])
        dp.addItem(["title":"orange"])
        dp.addItem(["title":"purple"])
        let list = self.addSubView(SliderFastList2(140, 73, 24, dp, self))
        list
        /*add*/
        let addBtn = addSubView(TextButton(100,24,"add",self))
        func onAdd(event:Event){
            if(event.type == ButtonEvent.upInside){
                Swift.print("added item to list")
                list.dataProvider.addItemAt(["title":"fuchsia"], 0)//add item at index 2
            }
        }
        addBtn.event = onAdd
        /*remove*/
        let removeBtn = addSubView(TextButton(100,24,"remove",self))
        func onRemove(event:Event){
            if(event.type == ButtonEvent.upInside){
                Swift.print("remove item at index: 0")
                list.dataProvider.removeItemAt(0)
            }
        }
        removeBtn.event = onRemove
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
    func sliderList(){
        let dp:DataProvider = DataProvider()
        dp.addItem(["title":"pink"])
        dp.addItem(["title":"orange"])
        dp.addItem(["title":"purple"])

        let list = addSubView(SliderList(140,145,24,dp,self))
        list
    }
    func list(){
        let dp = DataProvider(FileParser.xml("~/Desktop/ElCapitan/assets/xml/list.xml".tildePath))/*Loads xml from a xml file on the desktop*/
        let list = self.addSubView(List(140, 144, NaN, dp,self))
        list
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
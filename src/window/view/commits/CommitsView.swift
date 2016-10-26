import Cocoa

class CommitsView:Element {
    static let w:CGFloat = MainView.w
    static let h:CGFloat = MainView.h-48
    //var topBar:CommitsTopBar?
    var list:CommitsList?
    var progressIndicator:ProgressIndicator?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        //topBar = addSubView(CommitsTopBar(width-12,36,self))
        
        //add a container
        let container = addSubView(Container(CommitsView.w, CommitsView.h,self,"progressIndicatorContainer"))
        //add an element that is 30x30 and center it hor and vertically it should be under the top menu 15px
        //let progressIndicator = container.addSubView(Element(30,30,container,"progressIndicator"))
        //progressIndicator
        //add the progressIndicator and hock up the progress functionality
        progressIndicator = container.addSubView(ProgressIndicator(30,30,container))
        createList()
    }
    func createList(){
        //let dp:DataProvider = DataProvider()
        //dp.addItems([["title":"brown"],["title":"pink"],["title":"purple"]])
        let xml = FileParser.xml("~/Desktop/repo.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        Swift.print("dp.count(): " + "\(dp.count)")
        //Swift.print("CommitsView.width: " + "\(width)")
        list = addSubView(CommitsList(CommitsView.w, CommitsView.h, 102, dp, self,"commitsList"))
        ListModifier.selectAt(list!, 1)
    }
    /**
     * Happens when you use the scrollwheel or use the slider
     * TODO: Spring back motion shouldn't produce ProgressIndicator, only pull should
     */
    var isPulledBeyondRefreshSpace:Bool = false
    func onScroll(){
        let progressValue = list!.progressValue!
        Swift.print("onScroll() progressValue: " + "\(progressValue)")
        if(progressValue < -0.1){
            Swift.print("go into refresh mode")
            isPulledBeyondRefreshSpace = true
        }else{
            if(!isPulledBeyondRefreshSpace && progressValue <  0 && progressValue > -0.1){//between 0 and -1
                Swift.print("start progressing the ProgressIndicator")
                let scalarVal:CGFloat = progressValue / -0.1//0 to 1
                progressIndicator!.progress(scalarVal)
            }
            isPulledBeyondRefreshSpace = false//reset
        }
    }
    
    // on release of scrollGesture/sliderButton &&
        //start spinning the progressIndicator
    
    override func scrollWheel(theEvent: NSEvent) {
        onScroll()
        super.scrollWheel(theEvent)
    }
    override func onEvent(event: Event) {
        if(event.assert(SliderEvent.change, self)){
            onScroll()
        }
        super.onEvent(event)
    }
}
/*
class CommitsTopBar:Element{
    var reposButton:Button?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)//super.resolveSkin()
        reposButton = addSubView(Button(16,16,self,"repos"))
    }
    func onReposButtonClick(){
        Swift.print("onReposButtonClick()")
        Navigation.setView(MenuView.repos)
    }
    override func onEvent(event:Event) {
        if(event.assert(ButtonEvent.upInside, reposButton)){onReposButtonClick()}
    }
}
*/
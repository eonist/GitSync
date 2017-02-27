import Cocoa
@testable import Utils
@testable import Element

class CommitGraph:Graph{
    var dateText:TextArea?
    var currentDate:Date = Date()
    var dayOffset:Int = 0
    var graphData:(vValues:[CGFloat],hValNames:[String])
    /*we override this var so that the super class can derive data from graphData*/
    override var vValues:[CGFloat] {return graphData.vValues}//,20,33,19//[14,8,13,17,25,9,14]
    override var hValNames:[String] {return graphData.hValNames}//["T","W","T","F","S","S","M"]//"10/12","13","14",
    /*Gesture related*/
    var twoFingersTouches:[String:NSTouch]?/*temp storage for the twoFingerTouches data*/
    /*Animation related*/
    var animator:Animator?
    //var graphPts:[CGPoint] = []/*Animates to these points*/
    var initGraphPts:[CGPoint] = []/*Animates from these points*/
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        graphData =  Utils.defaultGraphData(dayOffset, currentDate)//set init data, at dayoffset: 0
        super.init(width, height, parent, id)
        self.acceptsTouchEvents = true/*Enables gestures*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        dateText = addSubView(TextArea(180,24,"-",self,"date"))/*A TextField that displays the time range of the graph*/
        updateDateText()
    }
    /**
     * Detects when touches are made
     */
    override func touchesBegan(with event:NSEvent) {
        //Swift.print("touchesBeganWithEvent: " + "\(touchesBeganWithEvent)")
        twoFingersTouches = GestureUtils.twoFingersTouches(self, event)
    }
    /**
     * Detects if a two finger left or right swipe has occured
     */
    override func touchesMoved(with event:NSEvent) {
        //Swift.print("touchesMovedWithEvent: " + "\(touchesMovedWithEvent)")
        let swipeType:SwipeType = GestureUtils.swipe(self, event, twoFingersTouches)
        if (swipeType == .right){
            Swift.print("swipe right")
            //Do something here
            iterate(-1)
        }else if(swipeType == .left){
            Swift.print("swipe left")
            iterate(1)
            //Do something else here
        }else{
            Swift.print("swipe none")
        }
    }
    override func touchesEnded(with event: NSEvent) {/*Swift.print("touchesEndedWithEvent: " + "\(touchesEndedWithEvent)")*/}//for debugging
    override func touchesCancelled(with event: NSEvent) {/* //Swift.print("touchesCancelledWithEvent: " + "\(touchesCancelledWithEvent)")*/}//for debugging
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
extension CommitGraph{
    /**
     * Offsets the currentDate by +-7 days
     */
    func iterate(_ iteration:Int){
        Swift.print("iterate" + "\(iteration)")
        dayOffset += (7*iteration)
        graphData = Utils.graphData(dayOffset, currentDate)
        let rateOfCommits = RateOfCommits()
        func onComplete(_ results:[Int]){
            Swift.print("Appdelegate.onComplete()")
            Swift.print("results.count: " + "\(results.count)")
        }
        rateOfCommits.onComplete = onComplete
        rateOfCommits.initRateOfCommitsProcess(0)
        updateGraph()
        updateDateText()
    }
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(){
        let maxValue:CGFloat = NumberParser.max(vValues)//Finds the largest number in among vValues
        
        graphPts = GraphUtils.points(newSize!, newPosition!, spacing!, vValues, maxValue)
        initGraphPts = graphPoints.map{$0.frame.origin}//grabs the location of where the pts are now
        /*GraphPoints*/
        
        if(animator != nil){animator!.stop()}/*stop any previous running animation*/
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Quad.easeIn)
        animator!.start()
        
        updateVTags(maxValue)
    }
    /**
     * VerticalBar (y-axis tags)
     */
    func updateVTags(_ maxValue:CGFloat){
        let strings:[String] = GraphUtils.verticalIndicators(vCount, maxValue)
        for i in 0..<strings.count{
            leftBarItems[i].setTextValue(strings[i])
        }
    }
    /**
     * Updates the DateText UI Element
     */
    func updateDateText(){
        let curDate = self.currentDate.offsetByDays(self.dayOffset)
        Swift.print("curDate.shortDate: " + "\(curDate.shortDate)")
        let lastWeekDate = self.currentDate.offsetByDays(self.dayOffset-7)
        //curDate
        dateText!.setTextValue(lastWeekDate.shortDate + " - " + curDate.shortDate)
    }
    /**
     * Interpolates between 0 and 1 while the duration of the animation
     * NOTE: ReCalc the hValue indicators (each week has a different max hValue etc)
     */
    func interpolateValue(_ val:CGFloat){
        Swift.print("interpolateValue() val: " + "\(val)")
        var positions:[CGPoint] = []
        /*GraphPoints*/
        for i in 0..<graphPts.count{
            let pos:CGPoint = initGraphPts[i].interpolate(graphPts[i], val)/*interpolates from one point to another*/
            positions.append(pos)
            graphPoints[i].setPosition(pos)//moves the points
        }
        /*GraphLine*/
        let path:IPath = PolyLineGraphicUtils.path(positions)/*convert points to a Path*/
        //TODO: Ideally we should create the CGPath from the points use CGPathParser.polyline
        let cgPath = CGPathUtils.compile(CGMutablePath(), path)//convert path to cgPath
        graphLine!.line!.cgPath = cgPath.clone()//applies the new path
        graphLine!.line!.draw()//draws the path
    }
}
private class Utils{
    /**
     * Returns Arrays of values for x and y axis. (In this case days and values)
     * Return: hValNames: horisontal Day names M,T,W,T,F,S,S aka mon,tue,wed...
     * Return: vValues: commmits that day
     */
    static func graphData(_ dayOffset:Int,_ currentDate:Date) -> (vValues:[CGFloat],hValNames:[String]){
        var dayNames:[String] = []
        var values:[CGFloat] = []/*commits in a single day*/
        for i in (0..<7).reversed() {
            let date = currentDate.offsetByDays(dayOffset-i)
            //Swift.print("date: " + "\(date)")
            let shortNameDayOfWeek:String = date.shortDayName
            //Swift.print("shortNameDayOfWeek: " + "\(shortNameDayOfWeek)")
            dayNames.append(shortNameDayOfWeek)
            let val:CGFloat = IntParser.random(4, 24).cgFloat/*generate vValues via random, as we use faux data for now*/
            values.append(val)
        }
        return (values,dayNames)
    }
    /**
     *
     */
    static func hValNames(_ dayOffset:Int,_ currentDate:Date) -> [String]{
        var dayNames:[String] = []
        var values:[CGFloat] = []/*commits in a single day*/
        for i in (0..<7).reversed() {
            let date = currentDate.offsetByDays(dayOffset-i)
            //Swift.print("date: " + "\(date)")
            let shortNameDayOfWeek:String = date.shortDayName
            //Swift.print("shortNameDayOfWeek: " + "\(shortNameDayOfWeek)")
            dayNames.append(shortNameDayOfWeek)
            let val:CGFloat = IntParser.random(4, 24).cgFloat/*generate vValues via random, as we use faux data for now*/
            values.append(val)
        }
        return dayNames
    }
    /**
     * Default values for graph (init)
     */
    static func defaultGraphData(_ dayOffset:Int,_ currentDate:Date) -> (vValues:[CGFloat],hValNames:[String]){
        var dayNames:[String] = []
        var values:[CGFloat] = []
        for i in (0..<7).reversed() {
            dayNames.append(currentDate.offsetByDays(dayOffset-i).shortDayName)
            values.append(0.0)
        }
        return (values,dayNames)
    }
}

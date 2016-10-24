import Cocoa
/**
 * TODO: Consider making the graph component bouncy and zoomable (with time elements that tesselate)
 */
class StatsView:Element {
    var graph:CommitGraph?
    override func resolveSkin() {
        self.skin = SkinResolver.skin(self)
        Swift.print("StatsView.width: " + "\(width)")
        Swift.print("StatsView.height: " + "\(height)")
        createGraph()
    }
    func createGraph(){
        let graphContainer = addSubView(Container(width,height,self,"graph"))
        graphContainer
        graph = graphContainer.addSubView(CommitGraph(width,height-48/*,4*/,graphContainer))
        
        //Time Iterator Left and right stepper use the left and right arrows similar to the up and down arrows in stepper (right aligned) (use the stepper just horizontally aligned)
        let stepper:LeverStepper = addSubView(LeverStepper(NaN,NaN,0,1,Int.min.cgFloat,Int.max.cgFloat,0,100,200,self))
        stepper
        
        func onEvent(event:Event){
            Swift.print("stepper.onEvent()")
            if(event.assert(StepperEvent.change, stepper)){
                let val = (event as! StepperEvent).value
                Swift.print("Stepper.value: " + "\(val)")
                graph!.dayOffset += val.int
                graph!.graphData = CommitGraph.graphData(graph!.dayOffset, graph!.currentDate)
                graph!.updateGraph()
            }
        }
        stepper.event = onEvent
        //for all repos:
            //get the commits from today where the user is Eonist
                //store the time in an [[Int]] (basically a arr with an arr of times)
                //if time is between 20:00 and 00:00, add to timeArr[0]
        
    }
}
/**
 * NOTE: You need to think week 1 - 52, and teselate months into 4 and then based on the mid day in this teselation derive the week-nr. NSDate probably has support for this
 */

class MonthGraph:Graph{
    override var hValues:[CGFloat] {
        var arr:[CGFloat] = []
        for _ in 0..<numOfDaysInMonth{
            let val:CGFloat = NumberParser.random(4, 24).cgFloat//generate hValues via random
            arr.append(val)
        }
        return arr
    }
    override var hValNames:[String] {
        var arr:[String] = []
        for i in 1...numOfDaysInMonth{//you need 1 until numOfDaysInMonth as hvalnames
            arr.append(i.string)
        }
        return arr
    }
    var numOfDaysInMonth:Int
    var curMonth:Int
    init(_ width: CGFloat, _ height: CGFloat,_ curMonth:Int, _ parent: IElement?, _ id: String? = nil) {
        self.curMonth = curMonth
        let date:NSDate = NSDate.createDate(nil,4)!
        numOfDaysInMonth = date.numOfDaysInMonth
        
        super.init(width, height, parent, id)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
//Simple is the best:
    //show 10 last days (5 on iphone)
    //gestures can iterate time periods back and forth -10 + 10 etc
    //morphs the graph
    //uni dir bounce for show
    //shows stats for all repos where the user is you
    //average commit max for 10 day period
    //days show as: 10/12, 10/13, 10/14 etc etc
    //start at the current date - 10 everytime you enter graph
    //GraphPoints should animate if you set the position differently on iteration
class CommitGraph:Graph{
    
    var currentDate:NSDate = NSDate()
    var dayOffset:Int = 0
    var graphData:(hValues:[CGFloat],hValNames:[String])
    override var hValues:[CGFloat] {return graphData.hValues}//,20,33,19//[14,8,13,17,25,9,14]
    override var hValNames:[String] {return graphData.hValNames}//["T","W","T","F","S","S","M"]//"10/12","13","14",
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        graphData =  CommitGraph.graphData(dayOffset, currentDate)
        super.init(width, height, parent, id)
        self.acceptsTouchEvents = true
    }
    
    override func touchesEndedWithEvent(event: NSEvent) {
        Swift.print("touchesEndedWithEvent: " + "\(touchesEndedWithEvent)")
    }
    override func touchesCancelledWithEvent(event: NSEvent) {
        Swift.print("touchesCancelledWithEvent: " + "\(touchesCancelledWithEvent)")
    }
    var twoFingersTouches:NSMutableDictionary?
    override func touchesBeganWithEvent(event: NSEvent) {
        Swift.print("touchesBeganWithEvent: " + "\(touchesBeganWithEvent)")
        if(event.type == NSEventType.EventTypeGesture){//was NSEventTypeGesture, could maybe be: EventTypeBeginGesture
            let touches:NSSet = event.touchesMatchingPhase(NSTouchPhase.Any, inView: self) //touchesMatchingPhase:NSTouchPhaseAny inView:self
            if(touches.count == 2){
                self.twoFingersTouches = NSMutableDictionary()
                
                for touch in touches {//NSTouch
                    self.twoFingersTouches![touch.identity] = touch//was [ setObject: forKey:];
                }
            }
        }
    }
    override func touchesMovedWithEvent(event: NSEvent) {
        Swift.print("touchesMovedWithEvent: " + "\(touchesMovedWithEvent)")
    }
    
    override func swipeWithEvent(event:NSEvent) {//doesnt work
        Swift.print("Swipe event.deltaY: " + "\(event.deltaY)" + " event.deltaX: " + "\(event.deltaX)")
        super.swipeWithEvent(event)
    }
    override func magnifyWithEvent(event: NSEvent) {
        Swift.print("Magnification value is" + "\(event.magnification)" + " event.momentumPhase: " + "\(event.momentumPhase)")
        var newSize:NSSize = NSSize()
        newSize.height = self.frame.size.height * event.magnification + 1.0
        newSize.width = self.frame.size.width * event.magnification + 1.0
        //[self setFrameSize:newSize];
        
        if(event.momentumPhase == NSEventPhase.Ended){
            Swift.print("the zoom ended")
           
        }else if(event.momentumPhase == NSEventPhase.Began){//include maybegin here
            Swift.print("the zoom began")
            
        }else if(event.momentumPhase == NSEventPhase.Changed){
            Swift.print("the zoom changed")
            
        }
        
        super.magnifyWithEvent(event)
    }
    //Continue here Try to bring the steppers into play
        //adjust the dayoffset and refresh the graph
        //try to animate the graphpoints rather than recreating it
        //you also need a time indicator so from Time-period:10/7 to 10/14 etc
    
    static func graphData(dayOffset:Int,_ currentDate:NSDate) -> (hValues:[CGFloat],hValNames:[String]){
        let calendar = NSCalendar.currentCalendar()
        var dayNames:[String] = []
        var values:[CGFloat] = []//commits in a single day
        for i in (0..<7).reverse() {
            let date = calendar.dateByAddingUnit(.Day, value: dayOffset-i, toDate: currentDate, options: [])
            Swift.print("date: " + "\(date)")
            let shortNameDayOfWeek:String = date!.shortDayName
            Swift.print("shortNameDayOfWeek: " + "\(shortNameDayOfWeek)")
            dayNames.append(shortNameDayOfWeek)
            let val:CGFloat = NumberParser.random(4, 24).cgFloat//generate hValues via random
            values.append(val)
        }
        return (values,dayNames)
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

extension CommitGraph{
    
    //Continue here: you also need to recalc the hValue indicators (each week has a different max hValue etc)
    //and figure out if animating position is easy or hard etc
    
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(){
        let maxValue:CGFloat = NumberParser.max(hValues)
        let graphPts:[CGPoint] = GraphUtils.points(newSize!, newPostition!, spacing!, hValues, maxValue)
        /*GraphPoints*/
        for i in 0..<graphPts.count{
            graphPoints[i].setPosition(graphPts[i])
        }
        /*GraphLine*/
        let path:IPath = PolyLineGraphicUtils.path(graphPts)/*convert points to a Path*/
        let cgPath = CGPathUtils.compile(CGPathCreateMutable(), path)
        graphLine!.line!.cgPath = cgPath.copy()
        graphLine!.line!.draw()
        /*VerticalBar*/
        
        let strings:[String] = GraphUtils.verticalIndicators(vCount, maxValue)
        for i in 0..<strings.count{
            leftBarItems[i].setTextValue(strings[i])
        }
    }
}

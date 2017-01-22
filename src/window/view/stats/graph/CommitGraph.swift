import Cocoa
class CommitGraph:Graph{
    var dateText:TextArea?
    var currentDate:Date = Date()
    var dayOffset:Int = 0
    var graphData:(vValues:[CGFloat],hValNames:[String])
    override var vValues:[CGFloat] {return graphData.vValues}//,20,33,19//[14,8,13,17,25,9,14]
    override var hValNames:[String] {return graphData.hValNames}//["T","W","T","F","S","S","M"]//"10/12","13","14",
    /*Gesture related*/
    var twoFingersTouches:NSMutableDictionary?/*temp storage for the twoFingerTouches data*/
    /*Animation related*/
    var animator:Animator?
    //var graphPts:[CGPoint] = []/*Animates to these points*/
    var initGraphPts:[CGPoint] = []/*Animates from these points*/
    
    override init(_ width: CGFloat, _ height: CGFloat, _ parent: IElement?, _ id: String? = nil) {
        graphData =  Utils.graphData(dayOffset, currentDate)
        super.init(width, height, parent, id)
        self.acceptsTouchEvents = true/*Enables gestures*/
    }
    override func resolveSkin() {
        super.resolveSkin()
        //Continue here: add the current date: 16/10/11 - 16/10/18  center aligned text on top (The CommitGraph doesnt need anything more features, as its just about showing your commit count the last 7 days and so)
        dateText = addSubView(TextArea(180,24,"-",self,"date"))
        updateDateText()
    }
    /**
     * Offsets the currentDate by +-7 days
     */
    func iterate(_ iteration:Int){
        Swift.print("iterate" + "\(iteration)")
        dayOffset += (7*iteration)
        graphData = Utils.graphData(dayOffset, currentDate)
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
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Easing.easeInQuad)
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
        let curDate = Utils.date(self.currentDate, self.dayOffset)
        Swift.print("curDate.shortDate: " + "\(curDate.shortDate)")
        let lastWeekDate = Utils.date(self.currentDate, self.dayOffset-7)
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
        let swipeType:SwipeType = GestureUtils.swipe(self, event, &twoFingersTouches)
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
    override func touchesEnded(with event: NSEvent) {//for debugging
        //Swift.print("touchesEndedWithEvent: " + "\(touchesEndedWithEvent)")
    }
    override func touchesCancelled(with event: NSEvent) {//for debugging
        //Swift.print("touchesCancelledWithEvent: " + "\(touchesCancelledWithEvent)")
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
private class Utils{
    /**
     * Returns a Date instance for a currentDate and dayOffset
     */
    static func date(_ currentDate:Date,_ dayOffset:Int) -> Date{
        let calendar = Calendar.current
        let date:Date = calendar.date(byAdding: .day, value: dayOffset, to: currentDate)!
        return date
    }
    /**
     * Returns Arrays of values for x and y axis. (In this case days and values)
     */
    static func graphData(_ dayOffset:Int,_ currentDate:Date) -> (vValues:[CGFloat],hValNames:[String]){
        var dayNames:[String] = []
        var values:[CGFloat] = []/*commits in a single day*/
        for i in (0..<7).reversed() {
            let date = Utils.date(currentDate, dayOffset-i)
            Swift.print("date: " + "\(date)")
            let shortNameDayOfWeek:String = date.shortDayName
            Swift.print("shortNameDayOfWeek: " + "\(shortNameDayOfWeek)")
            dayNames.append(shortNameDayOfWeek)
            let val:CGFloat = IntParser.random(4, 24).cgFloat/*generate vValues via random, as we use faux data for now*/
            values.append(val)
        }
        return (values,dayNames)
    }
}
enum SwipeType{
    case left,right,none
}
class GestureUtils{
    /**
     * To avoid duplicate code we could extract the content of this method into an GestureUtils method. Return nil if there isnt 2 touches and set the array only if != nil
     */
    static func twoFingersTouches(_ view:NSView, _ event:NSEvent)->NSMutableDictionary?{
        var twoFingersTouches:NSMutableDictionary? = nil
        if(event.type == NSEventType.gesture){//was NSEventTypeGesture, could maybe be: EventTypeBeginGesture
            let touches:NSSet = event.touches(matching: NSTouchPhase.any, in: view) as NSSet //touchesMatchingPhase:NSTouchPhaseAny inView:self
            if(touches.count == 2){
                twoFingersTouches = NSMutableDictionary()
                for touch in touches {//
                    twoFingersTouches![(touch as! NSTouch).identity] = touch//was [ setObject: forKey:];
                }
            }
        }
        return twoFingersTouches
    }
    
    /**
     * Detects 2 finger (left/right) swipe gesture
     * NOTE: To avoid duplicate code we could extract the content of this class to a Utility method, GestureUtils? and either of 3 enums could be returened. .leftSwipe, .rightSwipe .none
     * TODO: also make up and down swipe detectors, and do more research into how this could be done easier. Maybe you even have some clues in the notes about gestures etc.
     */
    static func swipe(_ view:NSView, _ event:NSEvent, _ twoFingersTouches:inout NSMutableDictionary?) -> SwipeType{
        let touches:Set<NSTouch> = event.touches(matching: NSTouchPhase.ended, in: view)
        if(touches.count > 0 && twoFingersTouches != nil){
            let beginTouches:NSMutableDictionary = twoFingersTouches!/*copy the twoFingerTouches data*/
            twoFingersTouches = nil/*reset the twoFingerTouches data*/
            let magnitudes:NSMutableArray = NSMutableArray()
            for touch in touches {
                let beginTouch:NSTouch? = beginTouches.object(forKey: touch.identity) as? NSTouch
                if (beginTouch == nil) {continue}
                let magnitude:Float = Float(touch.normalizedPosition.x) - Float(beginTouch!.normalizedPosition.x)
                magnitudes.add(NSNumber(value: magnitude))
            }
            var sum:Float = 0
            for magnitude in magnitudes{
                sum += (magnitude as AnyObject).floatValue
            }
            // See if absolute sum is long enough to be considered a complete gesture
            let absoluteSum:Float = fabsf(sum)
            let kSwipeMinimumLength:Float = 0.1
            if (absoluteSum < kSwipeMinimumLength) {return .none}
            
            // Handle the actual swipe
            // This might need to be > (i am using flipped coordinates)
            if (sum > 0){
                //Swift.print("go back")
                return .right
            }else /*if(sum < 0)*/{
                //Swift.print("go forward")
                return .left
            }
        }
        //Swift.print("no swipe direction detected")
        return .none
    }
}

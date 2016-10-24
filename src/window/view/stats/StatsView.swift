import Cocoa
/**
 * TODO: When entering the Graph component, you should animate the graph component from the old data to the new data, if there is new data. Very satesfiyng seeing your day commit graph go up after a long day of work
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
        
        //Continue here: add the current date: 16/10/22  (16 Jan 22) center aligned text on top
        
        
        //for all repos:
            //get the commits from today where the user is Eonist
                //store the time in an [[Int]] (basically a arr with an arr of times)
                //if time is between 20:00 and 00:00, add to timeArr[0]
        
    }
}

class CommitGraph:Graph{
    var animator:Animator?
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
    
    var twoFingersTouches:NSMutableDictionary?//temp storage
    
    override func touchesBeganWithEvent(event: NSEvent) {
        //Swift.print("touchesBeganWithEvent: " + "\(touchesBeganWithEvent)")
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
        //Swift.print("touchesMovedWithEvent: " + "\(touchesMovedWithEvent)")
        
        let touches:Set<NSTouch> = event.touchesMatchingPhase(NSTouchPhase.Ended, inView: self)
        if(touches.count > 0){
            let beginTouches:NSMutableDictionary = self.twoFingersTouches!
            self.twoFingersTouches = nil
            
            let magnitudes:NSMutableArray = NSMutableArray()
            
            for touch in touches {
                let beginTouch:NSTouch? = beginTouches.objectForKey(touch.identity) as? NSTouch
                
                if (beginTouch == nil) {continue}
                
                let magnitude:Float = Float(touch.normalizedPosition.x) - Float(beginTouch!.normalizedPosition.x)
                magnitudes.addObject(NSNumber(float: magnitude))


            }
            var sum:Float = 0
            
            for magnitude in magnitudes{
                sum += magnitude.floatValue
            }
            // See if absolute sum is long enough to be considered a complete gesture
            let absoluteSum:Float = fabsf(sum)
            let kSwipeMinimumLength:Float = 0.1
            if (absoluteSum < kSwipeMinimumLength) {return}
            
            // Handle the actual swipe
            // This might need to be > (i am using flipped coordinates)
            if (sum > 0){
                Swift.print("go back")
                //Do something here
                iterate(-1)
            }else{
                Swift.print("go forward")
                iterate(1)
                //Do something else here
            }
        }
        
    }
    
    /**
     *
     */
    func iterate(iteration:Int){
        Swift.print("iterate" + "\(iteration)")
        dayOffset += (7*iteration)
        graphData = CommitGraph.graphData(dayOffset, currentDate)
        updateGraph()
    }
    
    //recalc the hValue indicators (each week has a different max hValue etc)
    func interpolateValue(val:CGFloat){
        Swift.print("interpolateValue() val: " + "\(val)")
        var positions:[CGPoint] = []
        for i in 0..<graphPts.count{
            let pos:CGPoint = initGraphPts[i].interpolate(graphPts[i], val)
            positions.append(pos)
            graphPoints[i].setPosition(pos)
            
        }
        /*GraphLine*/
        let path:IPath = PolyLineGraphicUtils.path(positions)/*convert points to a Path*/
        let cgPath = CGPathUtils.compile(CGPathCreateMutable(), path)
        graphLine!.line!.cgPath = cgPath.copy()
        graphLine!.line!.draw()

    }
    var graphPts:[CGPoint] = []
    var initGraphPts:[CGPoint] = []
    /**
     * Re-calc and set the graphPoint positions (for instance if the hValues has changed etc)
     */
    func updateGraph(){
        let maxValue:CGFloat = NumberParser.max(hValues)
        
        graphPts = GraphUtils.points(newSize!, newPostition!, spacing!, hValues, maxValue)
        initGraphPts = graphPoints.map{$0.frame.origin}//<--should work
        /*GraphPoints*/
        
        if(animator != nil){animator!.stop()}//stop any previous running animation
        
        animator = Animator(Animation.sharedInstance,0.5,0,1,interpolateValue,Easing.easeInQuad)
        animator!.start()
        
        /*VerticalBar*/

        let strings:[String] = GraphUtils.verticalIndicators(vCount, maxValue)
        for i in 0..<strings.count{
            leftBarItems[i].setTextValue(strings[i])
        }

    }
    
    
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


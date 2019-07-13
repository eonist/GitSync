import Cocoa
@testable import Element
@testable import Utils

/*Zoom Controller*/

extension GraphZ{
    /**
     * Detects if a zoom gesture has occured +-100 deltaZ
     */
    override func magnify(with event: NSEvent) {
//        Swift.print("magnify()")
        super.magnify(with: event)
        //let prevZoom:Int = curZoom
        if event.phase == .changed {
            zoom += event.deltaZ
        }else if event.phase == .began {
            zoom = 0//reset
        }else if event.phase == .ended {
            var dir:Int
            if zoom < -100 {dir = 1}
            else if zoom > 100 {dir = -1}
            else{dir = 0}
            let newZoom = curZoom + dir
            if newZoom >= 0 && newZoom < maxZoom {
                prevZoom = curZoom//tempish bug fix
                curZoom = newZoom
            }
            onZoomLevelChange()
        }
    }
    var hasZoomChanged:Bool{
        let hasZoomChanged:Bool = prevZoom == nil || prevZoom != curZoom
        prevZoom = curZoom
        return hasZoomChanged
    }
    func onZoomLevelChange() {
        Swift.print("onZoomLevelChange")
        if hasZoomChanged {
//            updateDateIndicator()
            
            self.timeBar.removeFromSuperview()
            self.graphArea.removeFromSuperview()
            updateGraphArea()
            updateTimeBar()
            updateValueBar()
        }
    }
    /**
     * New
     */
    func updateTimeBar(){
        Swift.print("updateTimeBar")
//        let range:(start:Int,end:Int) = (start:0, end:dp.count)
//        Swift.print("range: " + "\(range)")
//        timeBar.contentContainer.layer?.position.x = 0
//        let event = DataProviderEvent.init(DataProviderEvent.dataChange, range.start,range.end,timeBar)
//        timeBar.onEvent(event)//Post an event to TimeBar, this should update timebar to new TimeType, seems like the prev text isn't completely removed. 🤔
//
//        timeBar.moverGroup =  timeBar.createMoverGroup()//not ideal to update this, it should update it self
        
        let timeBar = TimeBarZ(graphZ:self,size:CGSize(getWidth(),0)) /*Creates the TimeBar*///move to extension ⚠️️
        self.timeBar = addSubView(timeBar)
//        let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
//        timeBar = addSubView(TimeBar(w,24,24,dp,self,nil,.hor,100))
        
    }
    /**
     * New
     */
    func updateGraphArea(){
        Swift.print("updateGraphArea")
        
        let graphArea = GraphAreaZ(graphZ: self,size: CGSize(0,0))
        self.graphArea = addSubView(graphArea)
//        graphArea.contentContainer.layer?.position.x = 0
//        graphArea.scrollView.moverGroup = graphArea.scrollView.createMoverGroup()//not ideal to update this, it should update it self
//        graphArea.graphDots.forEach{$0.removeFromSuperview()}
//        graphArea.points = graphArea.createCGPoints()
//        graphArea.graphDots = graphArea.createGraphPoints()
//        graphArea.updateGraph(pts: graphArea.points)
    }
    /**
     *
     */
    func updateValueBar(){
        let maxValue:Int = graphArea.vValues!.max()!
        update(maxValue: maxValue)//updates valueBar and dateIndicator
    }
}

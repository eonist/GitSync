import Cocoa
@testable import Element
@testable import Utils
import GitSyncMac

/*Zoom Controller*/
extension Graph9{
    /**
     * Detects if a zoom gesture has occured +-100 deltaZ
     */
    override func magnify(with event: NSEvent) {
        //Swift.print("Graph9.magnify()")
        super.magnify(with: event)
        //let prevZoom:Int = curZoom
        if(event.phase == .changed){
            zoom += event.deltaZ
        }else if(event.phase == .began){
            zoom = 0//reset
        }else if(event.phase == .ended){
            var dir:Int
            if(zoom < -100){dir = 1}
            else if(zoom > 100){dir = -1}
            else{dir = 0}
            let newZoom = curZoom + dir
            if(newZoom >= 0 && newZoom < maxZoom){
                prevZoom = curZoom//tempish bug fix
                curZoom = newZoom
            }
            onZoomLevelChange()
        }
    }
    func onZoomLevelChange() {
        //Swift.print("🍐 onZoomLevelChange: prev: " + "\(self.prevTimeType) cur: \(self.curTimeType)")
        //Swift.print("curRange: " + "\(curRange)")
        prevRange = nil//why is this here?
        
        let prevTimeType = self.prevTimeType//temp store this,why?
        if(hasZoomChanged){//only toggle if zoom is not prevZoom
            //Swift.print("Graph9.onZoomLevelChange()")
            //let prevTimeType:TimeType = curTimeType
            //curTimeType = TimeType.types[curZoom]
            let tempCurRange = curRange//⚠️️ quickfix
            timeBar!.removeFromSuperview()
            timeBar = nil
            let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
            timeBar = addSubView(TimeBar3(w,24,24,dp,self,nil,.hor,100))
            alignTimeBar()
            
            let mouseLocIdx:Int = StatUtils.mouseLocIdx(mouseX, w, 100)
            //Swift.print("mouseLocIdx: " + "\(mouseLocIdx)")
            var progress:CGFloat = StatUtils.progress(timeBar!, (prevTimeType,curTimeType), mouseLocIdx, tempCurRange)/*0-1*/
            progress = progress.clip(0, 1)
            //Swift.print("progress: " + "\(progress)")
            /*let dp:TimeDP = TimeDPUtils.timeDP(curTimeType,range)
             ViewModifier.removeAll(timeBar!.lableContainer!)
             timeBar!.pool = []
             timeBar!.inActive = []
             timeBar!.dataProvider = dp*/
            let progressVal:CGFloat = SliderParser.y(progress, timeBar!.maskSize[timeBar!.dir], timeBar!.contentSize[timeBar!.dir])
            //Swift.print("progressVal: " + "\(progressVal)")
            timeBar!.mover!.value = progressVal//temp fix
            timeBar!.mover!.result = progressVal
            timeBar!.setProgress(progressVal)
            
            //let visRange:Range<Int> = timeBar!.visibleItemRange.start..<(timeBar!.visibleItemRange.end > timeBar!.dp.count ? timeBar!.visibleItemRange.end - 1 : timeBar!.visibleItemRange.end)
            //timeBar!.renderItems(visRange)
            /**/
            //prevVisibleRange = nil
            //visibleRange = nil/*rest so we force update dateText*/
            /**/
            //updateDateText()
            //updateGraph()
            //update()
        }
    }
}

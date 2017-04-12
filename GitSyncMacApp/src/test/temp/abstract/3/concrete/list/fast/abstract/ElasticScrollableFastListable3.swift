import Cocoa
@testable import Element
@testable import Utils

protocol ElasticScrollableFastListable3:FastListable3,ElasticScrollable3 {
    var rbContainer:Container?{get set}
}
extension ElasticScrollableFastListable3{
    func setProgress(_ point:CGPoint) {
        Swift.print("ElasticScrollableFastListable3.setProgress()")
        (self as FastListable3).setProgress(point[dir], dir)
        //(self as ElasticScrollable3).setProgress(point[.hor], .hor)
        //Continue here: 🏀
            //move the Progressable.setProgress into a static utils method
            //use this uitls method here
            //use secondary dir to get correct variables
        
        //you need to hock in to onChange while direct scroll
    }
    /**
     * PARAM value: is the final y value for the lableContainer
     * ⚠️️ Do not use scalar value here (0-1) well you know...
     */
    func setProgress(_ value:CGFloat,_ dir:Dir){
        Swift.print("👻🏂📜🐎 ElasticScrollableFast.setProgress(\(value))")
        //Swift.print("value: " + "\(value)")
        var progressValue:CGFloat?//new
        let contentSide:CGFloat = contentSize[dir]//TODO: Use a precalculated itemsHeight instead of recalculating it on every setProgress call, what if dp.count changes though?
        if(contentSide < maskSize[dir]){//when there is few items in view, different overshoot rules apply, this should be written more elegant
            progressValue = value / maskSize[dir]
            //Swift.print("progressValue: " + "\(progressValue)")
            let val = progressValue! * maskSize[dir]
            //Swift.print("y: " + "\(y)")
            rbContainer!.point[dir] = val
        }else{
            progressValue = value / -(contentSide - maskSize[dir])/*calc scalar from value, if itemsHeight is to small then use height instead*/
            let progress = progressValue!.clip(0, 1)
            
            //⚠️️🔨the bellow needs refactoring
            //(self as Scrollable).setProgress(progress)/*moves the lableContainer up and down*/
            contentContainer!.point[dir] = value
            (self as FastListable3).setProgress(progress)
            //
            let sliderProgress = ElasticUtils.progress(value,contentSide,maskSize[dir])//doing some double calculations here
            /*finds the values that is outside 0 and 1*/
            if(sliderProgress < 0){//⚠️️ You could also just do if value is bellow 0 -> y = value, and if y  < itemsheight - height -> y = the sapce above itemsheight - leftover
                let v1 = maskSize[dir] * -sliderProgress
                rbContainer!.point[dir] = v1/*the half height is to limit the rubber effect, should probably be done else where*/
            }else if(sliderProgress > 1){
                let v2 = maskSize[dir] * -(sliderProgress-1)
                rbContainer!.point[dir] = v2
            }else{
                rbContainer!.point[dir] = 0/*default position*/
            }
        }
        //Swift.print("rbContainer!.point[dir]: " + "\(rbContainer!.point[dir])")
        //Swift.print("contentContainer.point[dir]: " + "\(contentContainer!.point[dir])")
    }
}

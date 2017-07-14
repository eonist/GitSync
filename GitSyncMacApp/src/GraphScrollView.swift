import Cocoa
@testable import Utils
@testable import Element

class GraphScrollView:ContainerView3,GraphScrollable{
    lazy var moverGroup:MoverGroup? = MoverGroup(self.setProgressValue,self.maskSize,self.contentSize)
    override var maskSize:CGSize {return CGSize(super.getWidth(),super.getHeight())}/*Represents the visible part of the content *///TODO: could be ranmed to maskRect, say if you need x and y aswell
    override var contentSize:CGSize {return CGSize(100*19,super.getHeight())}
    var itemSize:CGSize {return CGSize(24,24)}
    var prevX:CGFloat = -100
    /**
     * When the the user scrolls
     * NOTE: this method overides the Native NSView scrollWheel method
     * //TODO: ⚠️️ You need to make an scroolWheel method that you can override down hierarcy.
     */
    override func scrollWheel(with event:NSEvent) {//you can probably remove this method and do it in base?"!?
        //Swift.print("GraphAreaX.scrollWheel()")
        //(self as ICommitList).scroll(event)
        if(event.phase == NSEventPhase.changed){/*this is only direct manipulation, not momentum*/
            //Swift.print("moverGroup!.result.x: " + "\(moverGroup!.result.x)")
            frameTick()
        }
        super.scrollWheel(with:event)/*⚠️️, 👈 not good, forward the event other delegates higher up in the stack*/
    }
}
protocol GraphScrollable:ElasticScrollable3 {
    var prevX:CGFloat {get set}
}
extension GraphScrollable {
    /**
     * This method is fired on each scrollWheel change event and MoverGroup setProgressValue call-back
     */
    func frameTick(){
        //Swift.print("frameTick \(moverGroup!.result.x)")
        //find cur 0 to 1 progress
        /*let totWidth = contentSize.width
         let maskWidth = maskSize.width
         let availableSpace = totWidth - maskWidth*/
        let x = moverGroup!.result.x
        /*let progress = abs(x) / availableSpace
         Swift.print("progress: " + "\(progress)")*/
        /*print(ceil(334/100))
         print(ceil(300/100))*/
        let min:Int = ceil(abs(x)/100).int
        let right:CGFloat = abs(x)+(100*GraphX.config.vCount)
        let max:Int = floor(right/100).int
        
        let range:[CGFloat] = GraphAreaX.vValues!.slice2(min, max)
        
        let maxValue:CGFloat = range.max()!
        _ = maxValue
        //Swift.print("maxValue: " + "\(maxValue)")
        
        //Continue here: 🏀
            //you can probably use the GraphUtils.points to get the points
        
        /*
        let size:CGSize = maskSize
        let points = GraphUtils.points(size, CGPoint(0,0), CGSize(100,100), range, maxValue,0,0)
        _ = points
        */
        
        let absX = abs(x)
        if absX >= prevX + 100 {/*only redraw at every 100px threshold*/
            Swift.print("if x:\(x)")
            tick(x)
            prevX = absX
        }else if absX < prevX{
            Swift.print("else if x: \(x)")
            tick(x)
            prevX = absX - 100
        }
    }
    func tick(_ xVal:CGFloat){
        Swift.print("Tick: \(xVal)")
    }
    /**
     * TODO: Comment this method
     */
    func setProgressValue(_ value:CGFloat, _ dir:Dir){/*gets called from MoverGroup*/
        if dir == .hor {
            //Swift.print("🍏 GraphScrollable.setProgressValue .hor: \(value)")
            frameTick()
            (self as ElasticScrollable3).setProgress(value, dir)
        }
    }
    /**
     * NOTE: Basically when you perform a scroll-gesture on the touch-pad
     */
    func onScrollWheelChange(_ event:NSEvent){/*Direct scroll*/
        //Swift.print("👻📜 (ElasticScrollable3).onScrollWheelChange : \(event.type) ")
        moverGroup!.value += event.scrollingDelta/*directly manipulate the value 1 to 1 control*/
        moverGroup!.updatePosition(true)/*the mover still governs the resulting value, in order to get the displacement friction working*/
        let p:CGPoint = moverGroup!.result
        setProgress(p)
    }
    func setProgress(_ point:CGPoint){
        Swift.print("override setProgress")
        disableAnim {contentContainer.layer?.position = point}
    }
}

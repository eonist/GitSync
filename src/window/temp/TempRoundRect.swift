import Cocoa

class TempRoundRect:Graphic {
    init(){
        let offsetType:OffsetType = OffsetType(OffsetType.outside)
        
        /*
        offsetType.top = OffsetType.outside
        offsetType.bottom = OffsetType.inside
        offsetType.left = OffsetType.outside
        offsetType.right = OffsetType.inside
        */
        let fillStyle = FillStyle(NSColor.yellowColor().alpha(0.5))
        let lineStyle = LineStyle(20,NSColor.blueColor().alpha(0.5))
        super.init(fillStyle,lineStyle,offsetType)
    }

    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
        
    
}

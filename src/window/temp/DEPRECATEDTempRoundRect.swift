/*import Cocoa
//delete this as you now have the graphics framework
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
let x:CGFloat = 0
let y:CGFloat = 0
let width:CGFloat = 200
let height:CGFloat = 200
let fillet = Fillet(CGFloat(20))
let rect:CGRect = CGRect(x: 0,y: 0,width: width,height: height)//these values will be derived from somewhere else in the future

let fillOffsetRect = RectGraphicUtils.fillFrame(rect, self.lineStyle!.thickness, lineOffsetType)
let lineOffsetRect = RectGraphicUtils.lineOffsetRect(rect, self.lineStyle!.thickness, lineOffsetType)

fillShape.frame = fillOffsetRect/*,position and set the size of the frame*/
let path = CGPathParser.roundRect(x,y,width,height,fillet.topLeft, fillet.topRight, fillet.bottomLeft, fillet.bottomRight)//Shapes
fillShape.path = path/*Draws in the local coordinate space of the shape*/
fillShape.setNeedsDisplay()/*draw the fileShape*/
//alignStroke(self)

/*
Swift.print("offsetRect.fillFrameRect: " + "\(offsetRect.fillFrameRect)")
Swift.print("offsetRect.lineFrameRect: " + "\(offsetRect.lineFrameRect)")
Swift.print("offsetRect.lineRect: " + "\(offsetRect.lineRect)")
*/
let lineFillet:Fillet = FilletParser.config(fillet, lineOffsetType, lineStyle);
let linePath = CGPathParser.roundRect(lineOffsetRect.lineRect.x,lineOffsetRect.lineRect.y,lineOffsetRect.lineRect.width,lineOffsetRect.lineRect.height,lineFillet.topLeft, lineFillet.topRight, lineFillet.bottomLeft, lineFillet.bottomRight)

lineShape.frame = lineOffsetRect.lineFrameRect
lineShape.path = linePath//lineOffsetRect.lineRect.path
lineShape.setNeedsDisplay()/*draw the lineShape*/

//layer!.display()

//Swift.print("fillStyle.color: " + "\(fillStyle.color)")
lineShape.delegate = self
fillShape.delegate = self
}

/**
* This is a delegate handler method
*/
override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
//Swift.print("Graphic.drawLayer(layer,inContext)")
if(layer === fillShape){
//Swift.print("fillShape")
fillShape.graphics.context = ctx

//TODO:you only need to call the draw method from here, the fill setting etc can be done in the decoratable classes

fillShape.graphics.fill(fillStyle!.color)//Stylize the fill
//Swift.print("inside drawInContext")
fillShape.graphics.draw(fillShape.path)//draw everything

}else if(layer === lineShape){
//Swift.print("lineShape")
lineShape.graphics.context = ctx

//TODO:you only need to call the draw method from here, the line setting etc can be done in the decoratable classes

lineShape.graphics.line(lineStyle!.thickness,lineStyle!.color/*,lineStyle!.lineCap, lineStyle!.lineJoin, lineStyle!.miterLimit*/)//Stylize the line
lineShape.graphics.draw(lineShape.path)//draw everything

}
}

required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}


}
*/
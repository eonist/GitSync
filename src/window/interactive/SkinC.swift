import Foundation

class SkinC:InteractiveView2{
    init(_ width: CGFloat, _ height: CGFloat){
        super.init(frame: NSRect(0,0,width,height))//<--This can be a zero rect since the children contains the actual graphics. And when you use Layer-hosted views the subchildren doesnt clip
    }
    //extend interactiveView
    //implement immediate
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}

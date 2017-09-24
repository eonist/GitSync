import Foundation
@testable import Utils
@testable import Element

class ValueBarZ:Element{
    static let vCount:Int = 5
    var items:[TextArea] = []
    //var valueLables:[TextArea] = []
    override func resolveSkin() {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/gitsync/stats/valuebar.css")
        super.resolveSkin()
        createItems()
    }
    /**
     * Creates the Text items that represents data in the y-axis
     */
    func createItems(){
        let strings:[String] = GraphUtils.verticalIndicators(ValueBarZ.vCount, 1.0)
        let margin:CGFloat = 24//Graph9.config.margin.height
        Swift.print("getHeight(): " + "\(getHeight())")
        let itemYSpace:CGFloat = (getHeight() - (margin * 2))/(ValueBarZ.vCount-1).cgFloat
        Swift.print("itemYSpace: " + "\(itemYSpace)")
        var y:CGFloat = margin
        strings.forEach{ str in
            let textArea:TextArea = TextArea(text: str)
            items.append(self.addSubView(textArea))
            textArea.setPosition(CGPoint(0,y))
            y += itemYSpace
        }
    }
    /**
     * VerticalBar (y-axis tags)
     */
    func updateValueBar(_ maxValue:CGFloat){
        var strings:[String] = GraphUtils.verticalIndicators(ValueBarZ.vCount, maxValue)
        strings = strings.map{ $0.cgFloat > 1000 ? ($0.cgFloat/1000).toFixed(1).string + "K" : $0}//Formats values like: 1500 -> 1.5K etc
        for i in 0..<strings.count{
            self.items[i].setTextValue(strings[i])
        }
    }
    override func getClassType() -> String {
        return "ValueBar"
    }
}




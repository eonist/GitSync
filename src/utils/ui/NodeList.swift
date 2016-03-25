import Foundation
/**
 * TODO: this class should not hold the back button
 * TODO: back and forth gestures should probably be implemented in this class, but it won't be easy. Unless apple has made it easy to combine with scroll action etc
 * TODO: extend List, its way easier to extend this class with likes of: SliderNodeList and RBNodeList in the future. The more involved CarouselList wont be easy to implement anyway, and will require many listviews to create a seamless experince
 * TODO: Actually dont extend better to work like a wrapper, since List components can be really complex
 */
class NodeList:Element{
    var index:Array<Int> = []//node index
    var node:Node
    var itemHeight:CGFloat
    var list:List?
    init(_ width: CGFloat, _ height: CGFloat, _ itemHeight:CGFloat = CGFloat.NaN, _ node:Node? = nil, _ parent: IElement?, _ id: String? = "") {
        self.node = node!
        self.itemHeight = itemHeight
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        
        let xml = node.xml.childAt(index)
        
        let dp = DataProvider(xml)
        list = addSubView(List(width,height,itemHeight,dp,self))
    }
    /**
     *
     */
    func setIndexValue(index:Array<Int>){
        
    }
    //add listeners for list click
    
    //when you click a list item 
        //you should append the selected item index to the var index:Array<Int> 
        //then you should create a new dataprovider based on the xml at the current index:Array<Int>
        //then you remove the current items in the list and add the new dataprovider items
    
    
    //when you click the backButton 
        //you should remove the last item in the index:Array
        //empty the list
        //set the xml to the current index
        //add the new dataprovider to the list
    
    
    
    //add listeners for node events
    
    //continue here: write how node events should work, and how the backButton event should work
    
    
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
}
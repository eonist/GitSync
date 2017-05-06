import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac


class TestView:TitleView{
    override init(_ width:CGFloat, _ height:CGFloat, _ parent:IElement? = nil, _ id:String? = "") {
        //self.title = "Resolve merge conflict:"//Title: Resolve sync conflict:
        super.init(width, height, parent, id)
    }
    override func resolveSkin(){
        Swift.print("TestView.resolveSkin()")
        super.resolveSkin()
        //Swift.print(ElementParser.stackString(self))
        createGUI()
    }
    func createGUI(){
        //transformTest()
        //treeDPUITest()
        //alterTreeDP2Test()
        //hashList2Test()
        //alterTreeTest()
        //filterTreeTest()
        //treeDPTest()
        //treeHashTest()
        //hashListTest()
        //hashArrayTest()
        //pathIndeciesTest()
        //childAtTest()
        //tree2XML()
        //xml2tree()
        //treeTesting()
        //infiniteTreeList()
        elasticSlideScrollFastList3()//👈
        //elasticScrollFastList()
        //slideScrollFastList()
        //scrollFastList()
        //fastList()
        
        //createElasticScrollSlideList()
        //createElasticScrollList()
        //createSlideScrollList()
        //createScrollList()
        //createList()
        
        //_ = self.addSubView(ElasticSlideScrollView3Test(width,height,nil))
        //_ = self.addSubView(ElasticScrollView3Test(width,height,nil))
        //_ = self.addSubView(SlideScrollView3Test(width,height,nil))
        
        //createGraph7Test()
        //createGraph2()
        //createVerSlider()
        //createHorSlider()
        
        //createVSlider()
        
        /*let intervalA:CGFloat = floor(200 - 100)/24
         Swift.print("intervalA: " + "\(intervalA)")
         let intervalB = SliderParser.interval(200, 100, 20)
         Swift.print("intervalB: " + "\(intervalB)")*/
    }
    
    //Continue here: 🏀
        //you want to add transform css syntax
            //do research into css rotation
            //transform: rotate(20deg);
    
            //
        //if Asset URL hasn't changed between state change, then don't reload asset.
            //
    
    /*
     CheckBox{
        fill:blue;
        transform:rotation(90deg);/*Rotates the skin 90deg*/
     }
    */

    func transformTest(){
        var css:String = "CheckBox{"
        css += "fill:blue;"
        css += "transform:rotation(90deg);"
        css += "}"
        let property = CSSPropertyParser.property("transform:rotation(90deg);")
        Swift.print("property: " + "\(property)")
    }
    func treeDPUITest(){
        //let xml:XML = FileParser.xml()
        //~/Desktop/assets/xml/treelist.xml
        let dp: TreeDP = TreeDP.init("~/Desktop/repo2.xml".tildePath)
        Swift.print("dp.count: " + "\(dp.count)")
        TreeDPParser.values(dp, [], "title").forEach{
            Swift.print("title: " + "\($0)")
        }
        _ = self.addSubView(TreeList3(140, 145, CGSize(24,24), dp, self))
    }
    func alterTreeDP2Test(){
        //✅ click arrow to open -> tree[idx].setProps["isOpen"] = true, insert trees from self.idx w/ filter open
        //✅ click arrow to close -> tree[idx].setProps["isOpen"] = false, remove every item after curIdx, that has curIdx, then stop if idx is not curIdx
        
        let dp: TreeDP = TreeDP("~/Desktop/assets/xml/treelist.xml".tildePath)
        
        TreeDPModifier.open(dp, 2)
        TreeDPModifier.close(dp, 2)
        
        TreeDPParser.values(dp, [], "title").forEach{
            Swift.print("title: " + "\($0)")
        }
        
    }
    /**
     *
     */
    func hashList2Test(){
        Swift.print("🚧 hashList2Test 🚧")
        let children = [Tree("A",[Tree("X"),Tree("Y")]),Tree("B")]
        let tree = Tree("Root",children)
        Swift.print("tree.count: " + "\(tree.count)")
        
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree)
        pathIndecies.forEach{
            Swift.print("$0.idx: " + "\($0)")
        }
        
        pathIndecies.forEach{
            let treeIdx:[Int] = $0
            let tree:Tree? = tree[treeIdx]
            Swift.print("tree.name: " + "\(tree?.name)")
        }
    }
    
    /**
     *
     */
    func filterTreeTest(){
        let xml:XML = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
        var tree:Tree = TreeConverter.tree(xml)
        //close idx:2
        
        //tree.children[2].props?["title"] = "Veggis"
        tree.setProp([2], ("title","Veggis"))//👈 nice!
        
        
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree,[],TreeUtils.isOpen)/*flattens 3d to 2d*/
        Swift.print("⚠️️")
        
        pathIndecies.forEach{
            //Swift.print("$0: " + "\($0)")
            let treeIdx:[Int] = $0
            if let tree = tree[treeIdx],let props:[String:String] = tree.props,let title = props["title"]{
                Swift.print("title: " + "\(title)")
            }
        }
    }
        
    /**
     *
     */
    func pathIndeciesTest(){
        Swift.print("🚧 pathIndeciesTest 🚧")
        let children = [Tree("A",[Tree("X"),Tree("Y")]),Tree("B")]
        let tree = Tree("Root",children)
        
        Swift.print("tree.children.count: " + "\(tree.children.count)")//2
        Swift.print("item: " + "\(tree[1]?.name)")//B
        //tree.children.count
        Swift.print("tree.count: " + "\(tree.count)")
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree)
        pathIndecies.forEach{
            //Swift.print("$0.idx: \($0) name: \(tree.child($0)?.name)")//
            Swift.print("$0: " + "\($0)")
        }
        
        /*
        Swift.print("item: " + "\(tree.child([0])?.name)")//A
        Swift.print("item: " + "\(tree.child([0,0])?.name)")//x
        Swift.print("item: " + "\(tree.child([0,1])?.name)")//y
        Swift.print("item: " + "\(tree.child([1])?.name)")//B
        */
    }
    /**
     *
     */
    func childAtTest(){
        let xmlStr:String = "<items title=\"main\"><item title=\"A\"/><item title=\"B\"/><item title=\"C\"/></items>"
        let xml:XML = xmlStr.xml
        let tree:Tree = TreeConverter.tree(xml)
        let child:Tree? = tree[2]
        Swift.print("child.name: " + "\(child?.props?["title"])")
        
    }
    /**
     *
     */
    func tree2XML(){
        let children = [Tree("A",[Tree("X"),Tree("Y")]),Tree("B")]
        let tree = Tree("Root",children)
        _ = tree
        Swift.print("tree.count: " + "\(tree.count)")
        
        let xml:XML = TreeConverter.xml(tree)
        Swift.print("xml.stringValue: " + "\(xml.xmlString)")
        let newTree:Tree = TreeConverter.tree(xml)
        Swift.print("newTree.name: " + "\(newTree.name)")
        let flattened:[Tree] = TreeUtils.flattened(newTree)
        flattened.forEach{Swift.print("\($0.name)")}
        
        //Continue here: 
            //test child at method 👈
        
        let child:Tree? = tree[0]
        Swift.print("child.name: " + "\(child?.name)")
    }
    /**
     *
     */
    func xml2tree(){
        var xmlStr:String = "<items>"
        xmlStr += "<subItems title=\"X\"><item title=\"Z\"/><item title=\"Y\"/></subItems>"
        xmlStr += "<item title=\"A\"/>"
        xmlStr += "<item title=\"B\"/>"
        xmlStr += "<item title=\"C\"/>"
        xmlStr += "</items>"
        let xml:XML = xmlStr.xml
        let tree:Tree = TreeConverter.tree(xml)
        /*Swift.print("tree.children.count: " + "\(tree.children.count)")
         Swift.print("tree.count: " + "\(tree.count)")
         Swift.print("tree[0]: " + "\(tree[0]?.props?["title"])")//a
         Swift.print("tree[1]: " + "\(tree[1]?.props?["title"])")//b
         Swift.print("tree[2]: " + "\(tree[2]?.props?["title"])")//c*/
        
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree)
        
        pathIndecies.forEach{
            //Swift.print("$0.idx: \($0) title: \(tree.child($0)?.props?["title"])")//a,b,c
            Swift.print("$0: " + "\($0)")
        }
    }
    func treeTesting(){
        
        //Try to build a tree structure from xml
        //Try tree -> xml (dont use reflection as it will store Tree etc as the item etc)
        //Try to flatten this treeStructure into array with pathIdx to original item?!?
        
        
        var tree = Tree("Root")
        var subTreeA = Tree("A")
        let subSubTreeX = Tree("X")
        var subSubTreeY = Tree("Y")
        subSubTreeY.add(Tree("Z"))
        subTreeA.add(subSubTreeX)
        subTreeA.add(subSubTreeY)
        let subTreeB = Tree("B")
        tree.add(subTreeA)
        tree.add(subTreeB)
        Swift.print("\(tree.descendants(3)?.name)")
        Swift.print("tree.count: " + "\(tree.count)")
        
        let pathIndecies:[[Int]] = TreeUtils.pathIndecies(tree)
        
        pathIndecies.forEach{
            //Swift.print("$0.idx: \($0) title: \(tree.child($0)?.props?["title"])")//a,b,c
            Swift.print("$0: " + "\($0)")
        }
    }
    func infiniteTreeList(){
        let xml:XML = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
        let arr:[Any] = XMLParser.arr(xml)
        Swift.print(arr)
        _ = addSubView(SliderTreeList(140, 192, 24, Node(xml),self))
    }
    func elasticSlideScrollFastList3(){
        var dp:DataProvider
        dp = DataProvider("~/Desktop/assets/xml/longlist.xml".tildePath)
        _ = self.addSubView(ElasticSlideScrollFastList3(width, height, CGSize(24,24), dp, self))
    }
    func elasticScrollFastList(){
        var dp:DataProvider
        dp = DataProvider("~/Desktop/assets/xml/longlist.xml".tildePath)
        _ = self.addSubView(ElasticScrollFastList3(140, 145, CGSize(24,24), dp, self))
    }
    func slideScrollFastList(){
        var dp:DataProvider
        dp = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        _ = self.addSubView(SlideScrollFastList3(140, 73, CGSize(24,24), dp, self))
    }
    func scrollFastList(){
        var dp:DataProvider
        dp = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        _ = self.addSubView(ScrollFastList3(140, 73, CGSize(24,24), dp, self))
    }
    func fastList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = addSubView(FastList3(140,73,CGSize(24,24),dp,self))
        _ = list
    }
    /**
     *
     */
    func createElasticScrollSlideList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)//longlist.xml
        dp.addItem(["title":"pink"])
        dp.addItem(["title":"orange"])
        dp.addItem(["title":"purple"])
        let list = addSubView(ElasticSlideScrollList3(140,145,CGSize(24,24),dp,.ver,self))
        _ = list
    }
    /**
     *
     */
    func createElasticScrollList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = addSubView(ElasticScrollList3(140,145,CGSize(24,24),dp,.ver,self))
        _ = list
    }
    func createSlideScrollList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = addSubView(SlideScrollList3(140,145,CGSize(24,24),dp,.ver,self))
        _ = list
    }
    func createScrollList(){
        let dp:DataProvider = DataProvider("~/Desktop/assets/xml/scrollist.xml".tildePath)
        let list = addSubView(ScrollList3(140,145,CGSize(NaN,24),dp,.ver,self))
        _ = list
    }
    func createList(){/*list.xml*/
        let dp = DataProvider(FileParser.xml("~/Desktop/ElCapitan/assets/xml/scrollist.xml".tildePath))/*Loads xml from a xml file on the desktop*/
        let list = self.addSubView(List3(140, 144, CGSize(NaN,NaN), dp,.ver,self))
        _ = list
    }
    
    func createVerSlider(){
        let horSlider:Slider = self.addSubView(Slider(6,60,.ver,CGSize(6,30),0,self))
        _ = horSlider
    }
    func createHorSlider(){
        let horSlider:Slider = self.addSubView(Slider(60,6,.hor,CGSize(30,6),0,self))
        _ = horSlider
    }
    /**
     * NOTE: see VolumSlider for eventListener
     */
    func createVSlider(){
        let vSlider:VSlider = self.addSubView(VSlider(6,60,30,0,self))
        _ = vSlider
    }
    /*func createGraph7Test(){
     let test = self.addSubView(Graph7(width,height-48,self))
     _ = test
     }
     func createGraph2(){
     let graph = self.addSubView(Graph2(width,height,nil))
     _ = graph
     }*/
    
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
class SlideScrollView3Test:SlideScrollView3 /*ElasticSlideScrollView3 ,ElasticView3*/{
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    override func resolveSkin() {
        StyleManager.addStyle("SlideScrollView3Test{fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        //createEllipse()
    }
}
class ElasticScrollView3Test:ElasticScrollView3{
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    override func resolveSkin() {
        StyleManager.addStyle("ElasticScrollView3Test{fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        //createEllipse()
    }
}
class ElasticSlideScrollView3Test:ElasticSlideScrollView3{
    override var contentSize: CGSize {return CGSize(super.width*2,super.height*2)}
    override func resolveSkin() {
        StyleManager.addStyle("ElasticSlideScrollView3Test{fill:green;fill-alpha:0.0;}")
        super.resolveSkin()
        //createEllipse()
    }
}

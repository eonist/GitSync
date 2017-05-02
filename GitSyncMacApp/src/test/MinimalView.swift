import Foundation
@testable import Element
@testable import Utils

class MinimalView:WindowView{
    override func resolveSkin(){
        //let css:String = "Window{fill-alpha:1;fill:white;corner-radius:4px;}"//
        //StyleManager.addStyle(css)
        super.resolveSkin()
        treeList()
        //rotationUITest()
        //checkBoxTest()
        
    }
    func treeList(){
        let url = "~/Desktop/repo2.xml"
        //let url = "~/Desktop/assets/xml/treelist.xml"
        let dp:TreeDP2 = TreeDP2(url.tildePath)
        let treeList = self.addSubView(TreeList3(140, 145, CGSize(24,24), dp, self))
        TreeList3Modifier.select(treeList, [2])
        
        
        treeList.open([0])
        treeList.select([0,2])//<- make sure that exists, and is open
        
        Swift.print("Selected title: \(treeList.selected?.props?["title"])")
        Swift.print("treeList.selected idx3d: " + "\(treeList.selectedIdx)")
        treeList.unSelectAll(treeList)
        treeList.collapse([])//closes the treeList
        treeList.explode([])//opens the treeList
        
        treeList.insert([1],Tree("Indigo"))
        treeList.remove([1])
        
        let xml:XML = TreeConverter.xml(treeList.treeDP.tree)
        _ = xml
        
        
        func onTreeListEvent(event:Event) {//adds local event handler
            if(event.type == SelectEvent.select && event.immediate === treeList){
                Swift.print("event.origin: " + "\(event.origin)")
                Swift.print("stackString: " + "💚\(ElementParser.stackString(event.origin as! IElement))💚")
                //Swift.print("onTreeListSelect()")
                let selectedIndex:[Int]? = TreeList3Parser.selectedIndex(treeList)
                Swift.print("selectedIndex: " + "\(selectedIndex)")
                //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
                let selectedXML:XML = XMLParser.childAt(treeList.node.xml, selectedIndex)!
                //print("selectedXML: " + selectedXML);
                Swift.print("selectedXML.toXMLString():")
                Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
            }
        }
        treeList.event = onTreeListEvent//add local event listener*/
        
        /*Swift.print("selected: " + "\(TreeListParser.selected(treeList))")
         Swift.print("selectedIndex: " + "\(TreeListParser.selectedIndex(treeList))")//Output:  [2,2,0]
         Swift.print("selected Title: " + "\(XMLParser.attributesAt(treeList.node.xml, TreeListParser.selectedIndex(treeList))!["title"])")//Output: Oregano
         TreeListModifier.unSelectAll(treeList)
         
         TreeListModifier.selectAt(treeList, [2])
         
         TreeListModifier.collapseAt(treeList, [])//closes the treeList
         TreeListModifier.explodeAt(treeList,[])//opens the treeList
         
         _ = treeList.node.removeAt([1])
         treeList.node.addAt([1], "<item title=\"Fish\"/>".xml)/*new*/
         
         //Swift.print("\(treeList.node.xml)")
         
         */
    }
    func rotationUITest(){
        var css = "Button{"
        css += "fill:blue,~/Desktop/ElCapitan/svg/arrow_right.svg grey6;"
        css += "transform:rotate(0deg),rotate(0deg);"
        css += "}"
        css += "Button:over{"
        css += "transform:rotate(0deg),rotate(90deg);"
        css += "}"
        StyleManager.addStyle(css)
        let btn = addSubView(Button(100,100,self))
        _ = btn
    }
    
    
    /**
     *
     */
    func checkBoxTest(){
        var css = "CheckBox{"
        css += "float:left;clear:none;"
        css += "fill:blue,~/Desktop/ElCapitan/svg/arrow_right.svg grey6;"
        css += "transform:rotate(0deg),rotate(0deg);"
        css += "margin-left:0px,0px;"
        css += "}"
        css += "CheckBox:checked{"
        css += "transform:rotate(0deg),rotate(90deg);"
        css += "}"
        css += "Button{"
        css += "float:left;clear:none;"
        css += "fill:red;"
        css += "}"
        StyleManager.addStyle(css)
        let checkBox1 = addSubView(CheckBox(100,100,false,self))
        _ = checkBox1
        /**/
        let btn = addSubView(Button(100,100,self))
        btn.event = { event in
            if(event.type == ButtonEvent.upInside){
                Swift.print("click")
                var style:IStyle = StyleModifier.clone(checkBox1.skin!.style!)//We need to clone the style so not to change the style on other UI elements
                
                var marginLeft0:IStyleProperty = style.getStyleProperty("margin-left",0)!
                marginLeft0.value = 20
                StyleModifier.overrideStyleProperty(&style, marginLeft0)
                var marginLeft1:IStyleProperty = style.getStyleProperty("margin-left",1)!
                marginLeft1.value = 20
                StyleModifier.overrideStyleProperty(&style, marginLeft1)
                style.describe()
                
                checkBox1.skin?.setStyle(style)
            }
        }
    }
}

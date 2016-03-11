import Cocoa

class StashView:CustomView {
    var leftSideBar:LeftSideBar?
    override func resolveSkin() {
        
        
        //continue here: try to capture the bellow with .+?
        
        
        testing()
        
        
        
        
        //continue here: write the test.css file
        
        
        //var cssString = "@import url(\"mainContent.css\");"
        //Swift.print("cssString: " + "\(cssString)")
        //cssString += ""
        /*
        let cssString:String = FileParser.content("~/Desktop/css/test.css".tildePath)!
        
        let result = CSSFileParser.separateImportsAndStyles(cssString)
        
        Swift.print("result.imports: " + "\(result.imports)")
        Swift.print("result.style: " + "\(result.style)")
        */
        
        return
        
        /*var css = ""//E8E8E8
        css += "Window Element#background{fill:#EFEFF4;fill-alpha:0;}"//<--you should target a bg element not the window it self, since now everything inherits these values
        StyleManager.addStyle(css)
        super.resolveSkin()
        leftSideBar = addSubView(LeftSideBar(LeftSideBar.w,height,self)) as? LeftSideBar
        createCustomTitleBar()
        leftSideBar!.createButtons()
        addSubView(MainContent(frame.width-LeftSideBar.w,frame.height,self))
        */
    }
    
    /**
     *
     */
    func testing(){
        var str = "@import url(\"mainContent.css\");\n"
        str += "Button{\n"
        str +=    " fill:blue;\n"
        str += "}"
        
        //let importPattern = "([@\\(\\)\\w\\s\\.\\/\";\\n]*?)"
        //let forwardLookingPattern = "(?:\\n[\\w\\s\\[\\]\\,\\#\\:\\.]+?\\{)|$"
        //let pattern = "^(?:" + importPattern + ")(?=" + forwardLookingPattern + ")([\\s\\w\\W\\{\\}\\:\\;\\n]+?$)"
        
        Swift.print(str.match("(^.+$)"))
        
        /* let matches = RegExp.matches(str, "(.*?(?=$))")
        for match:NSTextCheckingResult in matches {
        Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
        for var i = 0; i < match.numberOfRanges; ++i{
        Swift.print("loc: " + "\(match.rangeAtIndex(i).location)" + " length: " + "\(match.rangeAtIndex(i).length)")
        }
        //let content = (str as NSString).substringWithRange(match.rangeAtIndex(0))//the entire match
        //Swift.print("content: " + "\(content)")
        let group1 = (str as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
        Swift.print("group1: " + "\(group1)")
        /*let group2 = (str as NSString).substringWithRange(match.rangeAtIndex(2))//capturing group 2
        Swift.print("group2: " + "\(group2)")*/
        }*/
    }
    
    func createCustomTitleBar() {
        StyleManager.addStylesByURL("~/Desktop/css/titleBar.css")
        StyleManager.addStyle("Section#titleBar{padding-top:16px;padding-left:12px;}")
        
        section = leftSideBar!.addSubView(Section(75,16,leftSideBar,"titleBar")) as? Section
        closeButton = section!.addSubView(Button(0,0,section!,"close")) as? Button/*<--TODO: the w and h should be NaN, test if it supports this*/
        minimizeButton = section!.addSubView(Button(0,0,section!,"minimize")) as? Button
        maximizeButton = section!.addSubView(Button(0,0,section!,"maximize")) as? Button
    }
    override func createTitleBar() {
    }
}


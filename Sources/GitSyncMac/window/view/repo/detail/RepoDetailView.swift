import Cocoa
@testable import Utils
@testable import Element

class RepoDetailView:ElasticSlideScrollView3 {
    override var height:CGFloat {get{return super.height-48}set{super.height = newValue}}//lazy fix, you can use negative height padding to acchive the same thing
    //override var itemsHeight:CGFloat {}
    override var contentSize: CGSize {return CGSize(NaN,(12 * 24)+64) }
    override var itemSize: CGSize {return CGSize(NaN,24)}
    //override var itemHeight:CGFloat {return 24}
    /*TextInput*/
    var nameTextInput:TextInput?
    var localPathTextInput:TextInput?
    var remotePathTextInput:TextInput?
    var branchTextInput:TextInput?
    /*CheckButtons*/
    var uploadCheckBoxButton:CheckBoxButton?
    var downloadCheckBoxButton:CheckBoxButton?
    var activeCheckBoxButton:CheckBoxButton?
    var messageCheckBoxButton:CheckBoxButton?
    var intervalCheckBoxButton:CheckBoxButton?
    var fileChangeCheckBoxButton:CheckBoxButton?
    var pullCheckBoxButton:CheckBoxButton?
    /*LeverSpinner*/
    var autoSyncIntervalLeverSpinner:LeverSpinner?
    
    override func resolveSkin() {
        super.resolveSkin()/*self.skin = SkinResolver.skin(self)*/
        //Swift.print("RepoDetailView.width: " + "\(width)")
        nameTextInput = contentContainer!.addSubView(TextInput(width, 32, "Name: ", "", contentContainer))
        localPathTextInput = contentContainer!.addSubView(TextInput(width, 32, "Local-path: ", "", contentContainer))
        remotePathTextInput = contentContainer!.addSubView(TextInput(width, 32, "Remote-path: ", "", contentContainer))
        branchTextInput = contentContainer!.addSubView(TextInput(width, 32, "Branch: ", "", contentContainer))//branch-text-input: master is default, set to dev for instance
        autoSyncIntervalLeverSpinner = contentContainer!.addSubView(LeverSpinner(width, 32, "Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, contentContainer))
        downloadCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "Upload:", false, contentContainer))
        uploadCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "Download:", false, contentContainer))//to disable an item uncheck broadcast and subscribe
        activeCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "Active:", false, contentContainer))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        pullCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "Pull to refresh:", false, contentContainer))
        fileChangeCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "File change:", false, contentContainer))
        messageCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "Auto message:", false, contentContainer))
        intervalCheckBoxButton = contentContainer!.addSubView(CheckBoxButton(width, 32, "Interval:", false, contentContainer))
    }
    /**
     * Modifies the dataProvider item on UI change
     * TODO: Collectivly test for event type, then anrrow down on origin
     * TODO: Might need to change to origin testing since these items now are in the container. So event.orgin === downloadButoon.checkBox
     * TODO: ⚠️️ enumify this method?
     */
    override func onEvent(_ event:Event) {
        Swift.print("onEvent: " + "\(event.type)")
        let i:[Int] = RepoView.selectedListItemIndex
        
        var attrib:[String:String] = RepoView.treeDP.tree[i]!.props!//XMLParser.attributesAt(RepoView.node.xml, i)!
        
        /*LeverSpinner*/
        if(event == (SpinnerEvent.change, autoSyncIntervalLeverSpinner!)){
            attrib[RepoItemType.interval] = (event as! SpinnerEvent).value.string
        }
        /*TextInput*/
        else if(event == (Event.update,nameTextInput!)){
            attrib[RepoItemType.title] = (event as! TextFieldEvent).stringValue
        }else if(event == (Event.update,localPathTextInput!)){
            attrib[RepoItemType.localPath] = (event as! TextFieldEvent).stringValue
        }else if(event == (Event.update,remotePathTextInput!)){
            attrib[RepoItemType.remotePath] = (event as! TextFieldEvent).stringValue
        }else if(event == (Event.update,remotePathTextInput!)){
            attrib[RepoItemType.branch] = (event as! TextFieldEvent).stringValue
        }
        /*CheckButtons*/
        else if(event == (CheckEvent.check,uploadCheckBoxButton!)){
            attrib[RepoItemType.upload] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,downloadCheckBoxButton!)){
            attrib[RepoItemType.download] = String((event as! CheckEvent).isChecked)
        }else if(event === (CheckEvent.check,activeCheckBoxButton!.checkBox!)){
            attrib[RepoItemType.active] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,messageCheckBoxButton!)){
            attrib[RepoItemType.autoCommitMessage] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,pullCheckBoxButton!)){
            attrib[RepoItemType.pullToAutoSync] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,fileChangeCheckBoxButton!)){
            attrib[RepoItemType.fileChange] = String((event as! CheckEvent).isChecked)
        }else if(event == (CheckEvent.check,intervalCheckBoxButton!)){
            attrib[RepoItemType.autoSyncInterval] = String((event as! CheckEvent).isChecked)
        }else{//forward other events
            super.onEvent(event)
        }
        if(event.type == CheckEvent.check || event.type == Event.update || event.type == SpinnerEvent.change){
            Swift.print("attrib: " + "\(attrib)")
            RepoView.treeDP.tree[i]!.props = attrib//RepoView.node.setAttributeAt(i, attrib)
            
            if let tree:Tree = RepoView.treeDP.tree[i]{
                Swift.print("node.xml.xmlString: " + "\(tree.xml.xmlString)")
            }
        }
        
    }
}
extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(_ repoItem:RepoItem){
        nameTextInput!.inputTextArea!.setTextValue(repoItem.title)
        localPathTextInput!.inputTextArea!.setTextValue(repoItem.localPath)
        remotePathTextInput!.inputTextArea!.setTextValue(repoItem.remotePath)
        branchTextInput!.inputTextArea!.setTextValue(repoItem.branch)
        /*CheckButtons*/
        uploadCheckBoxButton!.setChecked(repoItem.upload)
        downloadCheckBoxButton!.setChecked(repoItem.download)
        messageCheckBoxButton!.setChecked(repoItem.autoCommitMessage)
        intervalCheckBoxButton!.setChecked(repoItem.autoSyncInterval)
        autoSyncIntervalLeverSpinner!.setValue(repoItem.interval.cgFloat)
        activeCheckBoxButton!.setChecked(repoItem.active)
        pullCheckBoxButton!.setChecked(repoItem.pullToAutoSync)
        fileChangeCheckBoxButton!.setChecked(repoItem.fileChange)
    }
}

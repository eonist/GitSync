import Cocoa
@testable import Utils
@testable import Element

class RepoDetailView:ElasticSlideScrollView3 {
    override var maskSize:CGSize {return CGSize(super.width,super.height-48)}
    override var contentSize:CGSize {return CGSize(NaN,(12 * 24)+64) }
    override var itemSize:CGSize {return CGSize(NaN,24)}
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
        nameTextInput = contentContainer.addSubView(TextInput(width, 32, "Name: ", "", contentContainer))
        localPathTextInput = contentContainer.addSubView(TextInput(width, 32, "Local-path: ", "", contentContainer))
        remotePathTextInput = contentContainer.addSubView(TextInput(width, 32, "Remote-path: ", "", contentContainer))
        branchTextInput = contentContainer.addSubView(TextInput(width, 32, "Branch: ", "", contentContainer))//branch-text-input: master is default, set to dev for instance
        autoSyncIntervalLeverSpinner = contentContainer.addSubView(LeverSpinner(width, 32, "Interval: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, contentContainer))
        downloadCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Upload:", false, contentContainer))
        uploadCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Download:", false, contentContainer))//to disable an item uncheck broadcast and subscribe
        activeCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Active:", false, contentContainer))//if auto sync is off then a manual commit popup dialog will appear (with pre-populated text)
        pullCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Pull to refresh:", false, contentContainer))
        fileChangeCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "File change:", false, contentContainer))
        messageCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Auto message:", false, contentContainer))
        intervalCheckBoxButton = contentContainer.addSubView(CheckBoxButton(width, 32, "Interval:", false, contentContainer))
    }
    /**
     * Modifies the dataProvider item on UI change
     * TODO: Collectivly test for event type, then anrrow down on origin
     * TODO: Might need to change to origin testing since these items now are in the container. So event.orgin === downloadButoon.checkBox
     * TODO: ⚠️️ enumify this method? at least usw switch
     */
    override func onEvent(_ event:Event) {
        Swift.print("onEvent: type: " + "\(event.type) immediate: \(event.immediate) origin: \(event.origin)")
        let idx3d:[Int] = RepoView.selectedListItemIndex
        guard var attrib:[String:String] = RepoView.treeDP.tree[idx3d]?.props else{
            fatalError("no attribs at: \(idx3d)")
        }
        /*LeverSpinner*/
        if event == (SpinnerEvent.change, autoSyncIntervalLeverSpinner!) {
            attrib[RepoItemType.interval] = (event as! SpinnerEvent).value.string
        }else if event.type == Event.update {
            switch true{
                /*TextInput*/
                case event.isChildOf(nameTextInput):
                    attrib[RepoItemType.title] = nameTextInput!.inputString
                case event.isChildOf(localPathTextInput):
                    attrib[RepoItemType.localPath] = localPathTextInput!.inputString
                case event.isChildOf(remotePathTextInput):
                    attrib[RepoItemType.remotePath] = remotePathTextInput!.inputString
                case event.isChildOf(branchTextInput):
                    attrib[RepoItemType.branch] = branchTextInput!.inputString
                default:
                    break;
                }
        }else if event.type == CheckEvent.check{
            switch true{
                /*CheckButtons*/
                case event.isChildOf(uploadCheckBoxButton!):
                    attrib[RepoItemType.upload] = String((event as! CheckEvent).isChecked)
                case event.isChildOf(downloadCheckBoxButton!):
                    attrib[RepoItemType.download] = String((event as! CheckEvent).isChecked)
                case event === (CheckEvent.check,activeCheckBoxButton!.checkBox)://TODO: <---use getChecked here
                    attrib[RepoItemType.active] = String((event as! CheckEvent).isChecked)
                case event == (CheckEvent.check,messageCheckBoxButton!):
                    attrib[RepoItemType.autoCommitMessage] = String((event as! CheckEvent).isChecked)
                case event == (CheckEvent.check,pullCheckBoxButton!):
                    attrib[RepoItemType.pullToAutoSync] = String((event as! CheckEvent).isChecked)
                case event == (CheckEvent.check,fileChangeCheckBoxButton!):
                    attrib[RepoItemType.fileChange] = String((event as! CheckEvent).isChecked)
                case event == (CheckEvent.check,intervalCheckBoxButton!):
                    attrib[RepoItemType.autoSyncInterval] = String((event as! CheckEvent).isChecked)
                default:
                    break;
            }
        }
        switch true{
            
            
            
            default://forward other events
                super.onEvent(event)
                break;
        }
  
        if(event.type == CheckEvent.check || event.type == Event.update || event.type == SpinnerEvent.change){
            //Swift.print("✨ Update dp with: attrib: " + "\(attrib)")
            RepoView.treeDP.tree[idx3d]!.props = attrib//RepoView.node.setAttributeAt(i, attrib)
            if let tree:Tree = RepoView.treeDP.tree[idx3d]{
                Swift.print("title: " + "\(tree.props?["title"])")
                //Swift.print("node.xml.xmlString: " + "\(tree.xml.xmlString)")
            }
        }
    }
}
extension RepoDetailView{
    /**
     * Populates the UI elements with data from the dp item
     */
    func setRepoData(_ repoItem:RepoItem){
        nameTextInput!.inputTextArea.setTextValue(repoItem.title)
        localPathTextInput!.inputTextArea.setTextValue(repoItem.localPath)
        remotePathTextInput!.inputTextArea.setTextValue(repoItem.remotePath)
        branchTextInput!.inputTextArea.setTextValue(repoItem.branch)
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

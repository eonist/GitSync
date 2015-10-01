/*
 * Utils for paraing the git status list
 */
class StatusUtils{
	/*
	 * Returns a descriptive status list of the current git changes
	 * NOTE: you may use short staus, but you must interpret the message if the state has an empty space infront of it
	 */
	func generateStatusList(localRepoPath){
		set theStatus = GitParser's status(localRepoPath, "-s") //-- the -s stands for short message, and returns a short version of the status message, the short stauslist is used because it is easier to parse than the long status list
		//--log tab & "theStatus: " & theStatus
		set theStatus_list = TextParsers.paragraph(theStatus) //--store each line as items in a list
		set transformedList = []
		if (theStatusList.count > 0) {
			set transformedList to my transformStatusList(theStatusList)
		}else{
			//--log "nothing to commit, working directory clean"// --this is the status msg if there has happened nothing new since last, but also if you have commits that are ready for push to origin
		}
		//--log "len of theStatus_list: " & (length of theStatusList)
		//--log transformedList
		return transformed_list
	}
	/*
 	 * Transforms the "compact git status list" by adding more context to each item (a list with acociative lists, aka records)
 	 * Returns a list with records that contain staus type, file name and state
 	 * NOTE: the short status msg format is like: "M" " M", "A", " A", "R", " R" etc
 	 * NOTE: the space infront of the capetalized char indicates Changes not staged for commit:
 	 * NOTE: Returns = renamed, M = modified, A = addedto index, D = deleted, ?? = untracked file
	 * NOTE: the state can be:  "Changes not staged for commit" , "Untracked files" , "Changes to be committed"
	 * @Param: theStatusList is a list with status messages like: {"?? test.txt"," M index.html","A home.html"}
	 * NOTE: can also be "UU" unmerged paths
 	 */
	func transform_status_list(theStatusList){
		set transformedList = []
		for (theStatusItem in theStatusList){ 
			//--log "the_status_item: " & the_status_item
			set theStatusParts to RegExpUtil's match(theStatusItem, "^( )*([MARDU?]{1,2}) (.+)$") --returns 3 capturing groups, 
			//--log "length of theStatusParts: " & (length of theStatusParts)
			//--log theStatusParts
			let statusItem = ["state":"", "cmd":"", "fileName":""] //--store the individual parts in an accociative
			if (theStatusParts.second == " ") { //--aka " M", remember that the second item is the first capturing group
				statusItem["cmd"] = theStatusParts.third //--Changes not staged for commit:
				statusItem["state"] = "Changes not staged for commit" //-- you need to add them
			}else{ //-- Changes to be committed--aka "M " or  "??" or "UU"
				statusItem["cmd"] = theStatusParts.third //--rename cmd to type
				//--log "cmd: " & cmd
				if (statusItem["cmd"] == "??"){
					statusItem["state"] = "Untracked files"
				}else if (statusItem["cmd"] == "UU") { //--Unmerged path
					//--log "Unmerged path"
					statusItem["state"] = "Unmerged path"
				}else{
					statusItem["state"] = "Changes to be committed" //--this is when the file is ready to be commited
				}
			}
			let fileName = theStatusParts.fourth
			//--log "state: " & state & ", cmd: " & cmd & ", file_name: " & file_name --logs the file named added changed etc

			transformedList += statusItem //--add a record to a list
		}
		return transformed_list
	}
	/*
	 * Iterates over the status items and "git add" the item unless it's already added (aka "staged for commit")
	 * NOTE: if the status list is empty then there is nothing to process
	 * NOTE: even if a file is removed, its status needs to be added to the next commit
	 * TODO: Squash some of the states together with if or or or etc
	 */
	func process_status_list(localRepoPath, status_list){
		--log "process_status_list()"
		repeat with status_item in status_list
			--log "len of status_item: " & (length of status_item)
			set state to state of status_item
			--set cmd to cmd of status_item
			set file_name to file_name of status_item
			if state = "Untracked files" then --this is when there exists a new file
				log tab & "1. " & "Untracked files"
				GitModifier's add(localRepoPath, file_name) --add the file to the next commit
			else if state = "Changes not staged for commit" then --this is when you have not added a file that has changed to the next commit
				log tab & "2. " & "Changes not staged for commit"
				GitModifier's add(localRepoPath, file_name) --add the file to the next commit
			else if state = "Changes to be committed" then --this is when you have added a file to the next commit, but not commited it
				log tab & "3. " & "Changes to be committed" --do nothing here
			else if state = "Unmerged path" then --This is when you have files that have to be resolved first, but eventually added aswell
				log tab & "4. " & "Unmerged path"
				GitModifier's add(localRepoPath, file_name) --add the file to the next commit
			end if
		end repeat
	}
}
/*
 * single choice list window, similar to applescript's "choose from list" Dialog Window
 * Todo: rename to ChooseFromListWinow?
 */
class ListWindow : Window{
	var list:Array
	var headerTitle:String
	var title:String
	var lastSelected:String
	var cancelButtonName:String
	/**
	 * 
	 */
	override func init(list:Array,headerTitle:String,title:String ,selected:String,cancelButtonName:String){
		init(width:300,height:800,headerTitle:headerTitle)
		self.list = list
		self.headerTitle = headerTitle
		self.title = title
		self.selected = selected
		self.cancelButtonName = cancelButtonName
		createContent()
		addTargets()
	}
	func createContent(){
		
		//list here	
		let list = List(list:self.list,selected:selected,multiSelect:false)
		self.view.addSubview(list)
		
		//container for the buttons
		let buttonContainer:Container = Container(240,60)
		self.view.addSubview(buttonContainer)
		
		let okButton = UIButton()
		okButton.setTitle("OK", forState: .Normal)
		okButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		okButton.frame = CGRectMake(0, 0, 120, 40)
		buttonContainer.addChild(okButton)
		
		//exit button here
		let exitButton = UIButton()
		exitButton.setTitle(cancelButtonName, forState: .Normal)
		exitButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
		exitButton.frame = CGRectMake(0, 0, 120, 40)
		buttonContainer.addChild(exitButton)
		 
		//align the ui items
		list.align = .CENTER
		buttonContainer.align = .CENTER
		okButton.align = .CENTER_LEFT
		exitButton.align = .CENTER_RIGHT
	}
	// 
	func addTargets(){
		okButton.addTarget(self, action: "pressedAction:", forControlEvents: .TouchUpInside)
	}
	//delegate handlers
	func pressedAction(sender: UIButton!) {
	   // do your stuff here 
	  print("you clicked on button %@" + sender.tag)
	  if(sender.tag == "ok"){
	  	//dispatch complete event with ok, and selected choice
	  }else{//exit
	  	//dispatch complete event with exit 
	  }
	}
}
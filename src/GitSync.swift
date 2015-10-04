//import utils/xml/XMLParser.swift
//import utils/misc/shell/ShellUtils.swift
//import utils/string/regexp/RegExpParser.swift
//import utils/string/regexp/RegExpModifier.swift

//continue here
//read swift conventions
//read import conventions


class GitSync{
	//Properties:
	let currentTime:Int = 0 //keeps track of the time passed, remember to reset this value pn every init
	let theInterval:Int = 60 //static value, increases the time by this value on every interval--TODO: rename to "frequncy"
	var repoList:Array = null //Stores all values the in repositories.xml, remember to reset this value pn every init
	let repoFilePath:String = ""
	let options = ["keep local version", "keep remote version", "keep mix of both versions", "open local version", "open remote version", "open mix of both versions", "keep all local versions", "keep all remote versions", "keep all local and remote versions", "open all local versions", "open all remote versions", "open all mixed versions"]
	var currentTime:Int = 0 //always reset this value on init, applescript has persistent values
	/*
	 * Initialize the app, toggles between debug and deploy mode depending fromwhich file type it is run from
	 */
	func init(){
		repoFilePath = FileParser.resourcePath() + "repo.xml"
		var timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "handleInterval", userInfo: nil, repeats: true)
	}
	/* Handles the process of comitting, pushing for multiple repositories
	 * This is called on every interval
	 * NOTE: this will only be called from an .app mode aka "deploy mode" / "production mode"
	 * NOTE: while testing you can call this manually, since idle will only work when you run it from an .app
	 */
	func handleInterval(){
		if (!NetworkAsserter.isConnectedToInternet()) { return }//no internet? then return
		//print( "handle_interval()")
		repoList = RepoUtil.compileRepoList(repoFilePath) //try to avoid calling this on every intervall, its nice to be able to update on the fly, be carefull though
		let currentTimeInMin to (currentTime / 60) //divide the seconds by 60 seconds to get minutes
		//print ("currentTimeInMin: " + currentTimeInMin)
		for (repoItem in repoList as! [Dictionary]){//iterate over every repo item
			if (currentTimeInMin % (repoItem["interval"]) = 0) { handleCommitInterval(repoItem, "master") } //is true every time spesified by the user
			if (currentTimeInMin % (repoItem["interval"]) = 0) { handlePushInterval(repoItem, "master") }//is true every time spesified by the user
		}
		currentTime += theInterval //increment the interval (in seconds)
	}
	/*
	 * Handles the process of making a commit for a single repository
	 */
	func handleCommitInterval(repoItem:Dictionary, branch:String){
		//log "GitSync's handle_commit_interval() a repo with remote path: " & (remote_path of repo_item) & " local path: " & (local_path of repo_item)
		if (GitAsserter.hasUnmMergedPaths(repoItem["localPath"])) { //Asserts if there are unmerged paths that needs resolvment
			//log tab & "has unmerged paths to resolve"
			MergeUtil.resolveMergeConflicts(repoItem["localPath"], branch, GitParser.unMergedFiles(repoItem["localPath"])) //Asserts if there are unmerged paths that needs resolvment
		}
		doCommit(repoItem["localPath"]) //if there were no commits false will be returned
		//log "has_commited: " & has_commited
	}
	/*
	 * Handles the process of making a push for a single repository
	 * NOTE: We must always merge the remote branch into the local branch before we push our changes. 
	 * NOTE: this method performs a "manual pull" on every interval
	 * TODO: contemplate implimenting a fetch call after the pull call, to update the status, whats the diff between git fetch and git remote update again?
	 */
	func handlePushInterval(repoItem:Dictionary, branch:String){
		//log ("GitSync's handle_push_interval()")
		MergeUtils.manualMerge(repoItem["localPath"], repoItem["remotePath"], branch) //--commits, merges with promts, (this method also test if a merge is needed or not, and skips it if needed)
		let hasLocalCommits:Bool = GitAsserter.hasLocalCommits(repoItem["localPath"], branch) //--TODO: maybe use GitAsserter's is_local_branch_ahead instead of this line
		if (hasLocalCommits) { //--only push if there are commits to be pushed, hence the has_commited flag, we check if there are commits to be pushed, so we dont uneccacerly push if there are no local commits to be pushed, we may set the commit interval and push interval differently so commits may stack up until its ready to be pushed, read more about this in the projects own FAQ
			let keychainData:Dictionary = KeychainParser.keychainData(repoItem["keychainItemName"])
			let pushCallBack:String = GitModifier.push(repoItem["localPath"], repoItem["remotePath"], keychainData["accountName"], keychainData["the_password"], branch)
			//log "push_call_back: " & push_call_back
		}
	}
	/*
	 * This method generates a git status list,and asserts if a commit is due, and if so, compiles a commit message and then tries to commit
	 * Returns true if a commit was made, false if no commit was made or an error occured
	 * NOTE: checks git staus, then adds changes to the index, then compiles a commit message, then commits the changes, and is now ready for a push
	 * NOTE: only commits if there is something to commit
	 * TODO: add branch parameter to this call
	 * NOTE: this a purly local method, does not need to communicate with remote servers etc..
	 */
	func doCommit(localRepoPath:String)->Bool{
		//log ("GitSync's do_commit()")
		//--log "do_commit"
		let statusList:Array = StatusUtils.generateStatusList(localRepoPath) //--get current status
		if (statusList.count > 0) {
			//log tab & "there is something to add or commit"
			//--log tab & "length of status_list: " & (length of statusList)
			StatusUtils.processStatusList(localRepoPath, statusList) //--process current status by adding files, now the status has changed, some files may have disapared, some files now have status as renamed that prev was set for adding and del
			let commitMsgTitle:String = CommitUtils.sequenceCommitMsgTitle(statusList) //--sequence commit msg title for the commit
			//log tab & "commit_msg_title: " & commit_msg_title
			let commitMsgDesc:String = DescUtil.sequenceDescription(statusList) //--sequence commit msg description for the commit
			//log tab & "commit_msg_desc: " & commit_msg_desc
			do{//--try to make a git commit
				try let commitResult:String = GitModifiers.commit(localRepoPath, commitMsgTitle, commitMsgDesc) //--commit
			   //log tab & "commit_result: " & commit_result
			}catch let error as NSError{
			    print ("Error: \(error.type)")
				 //log tab & "----------------ERROR:-----------------" & errMsg
			}
			return true //--return true to indicate that the commit completed
		}else{
			//log tab & "nothing to add or commit"
			return false //--break the flow since there is nothing to commit or process
		}
	}
}
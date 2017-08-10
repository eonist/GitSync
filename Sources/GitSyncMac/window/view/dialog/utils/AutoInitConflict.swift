import Foundation
@testable import Utils

struct AutoInitConflict{
    let repoItem:RepoItem
    let pathExists:Bool
    let isGitRepo:Bool
    let hasPathContent:Bool
    
    init(_ repoItem:RepoItem){
        self.repoItem = repoItem
        self.pathExists = Utils.pathExists(repoItem)
        let isGitRepo = pathExists && Utils.isGitRepo(repoItem)
        self.isGitRepo = isGitRepo
        self.hasPathContent = self.pathExists && !isGitRepo && Utils.hasPathContent(repoItem)
    }
}
extension AutoInitConflict{
    enum Strategy{
        enum PathExists{
            enum HasPathContent{
                enum IsGitRepo{
                    case yes
                    case no
                }
                case yes(isGitRepo:IsGitRepo)
                case no(isGitRepo:IsGitRepo)
            }
            case yes(hasContent:HasPathContent)
            case no(hasContent:HasPathContent)
        }
        case configure(pathExists:PathExists)
        /**
         * Creates a strategy
         */
        static func create(pathExists:Bool,isGitRepo:Bool,hasPathContent:Bool) -> Strategy{
            let _isGitRepo:Strategy.PathExists.HasPathContent.IsGitRepo = isGitRepo ? .yes : .no
            let _hasPathContent:Strategy.PathExists.HasPathContent = hasPathContent ? .yes(isGitRepo:_isGitRepo) : .no(isGitRepo:_isGitRepo)
            let _pathExists:Strategy.PathExists = pathExists ? .yes(hasContent:_hasPathContent) : .no(hasContent:_hasPathContent)
            return .configure(pathExists:_pathExists)
        }
        
        /**
         * Creates the text for the AutoInitPrompt
         */
        func text(_ repoItem:RepoItem) -> (issue:String,proposal:String){
            var issue:String = ""
            var proposal:String = ""
            /**/
            switch self{
            case .configure(let pathExists):
                switch pathExists {
                case .yes(let hasContent):
                    switch hasContent {
                    case .yes(let isGitRepo):
                        switch isGitRepo {
                        case .yes:
                            let curRemotePath:String = GitParser.originUrl(repoItem.localPath)
                            if curRemotePath != repoItem.remotePath {
                                issue = "There is already a git project in the folder: \(repoItem.local) with a different remote URL"
                                proposal = "Do you want to assign a new remote URL and start a merge wizard?"
                            }
                        case .no:
                            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
                            proposal = "Do you want to download from remote and start a merge wizard?"
                        }
                    case .no(let isGitRepo):
                        _ = isGitRepo
                        issue = "There is no content in the file path: " + "\(repoItem.localPath)"
                        proposal = "Do you want to download from remote?"
                    }
                case .no(let hasContent):
                    _ = hasContent
                    issue = "There is nothing in the path \(repoItem.localPath)"
                    proposal = "Do you want to create it and download files from: \(repoItem.remotePath)"
                }
            }
            return (issue,proposal)
        }
        /**
         *
         */
        func process(_ repoItem:RepoItem){
            let localPath:String = repoItem.localPath
            let remotePath:String = repoItem.remotePath
            let branch:String = repoItem.branch
            
            switch self{
            case .configure(let pathExists):
                switch pathExists {
                case .yes(let hasContent):
                    switch hasContent {
                    case .yes(let isGitRepo):
                        switch isGitRepo {
                        case .yes:
                            let curRemotePath:String = GitParser.originUrl(repoItem.localPath)
                            if curRemotePath != repoItem.remotePath {
                               
                            }else{
                                let has_remote_repo_attached = GitAsserter.hasRemoteRepoAttached(localPath, branch)
                                if has_remote_repo_attached  {//--the .git folder already has a remote repo attached
                                    _ = GitModifier.detachRemoteRepo(localPath/*branch*/)//--promt the user if he wants to use the existing remote origin, this will skip the user needing to input a remote url
                                    _ = GitModifier.attachRemoteRepo(localPath,branch)
                                }else{//--does not have remote repo attached
                                    _ = GitModifier.attachRemoteRepo(localPath,branch)//--attach remote repo
                                }

                            }
                        case .no:
                            _ = GitModifier.initialize(localPath)
                            _ = GitModifier.attachRemoteRepo(localPath,branch)//--add new remote origin
                        }
                    case .no(let isGitRepo):
                        _ = isGitRepo
                        _ = GitModifier.clone(remotePath,localPath)
                    }
                case .no(let hasContent):
                    _ = hasContent
                   _ = GitModifier.clone(remotePath,localPath)//--this will also create the folders if they dont exist, even nested
                }
            }
        }
        static func autoInit(_ repoItem:RepoItem,doesPathExist:Bool,isGitFolder:Bool,isFolderEmpty:Bool){
            let localPath:String = repoItem.localPath
            let remotePath:String = repoItem.remotePath
            let branch:String = repoItem.branch
            Swift.print("AutoInit.autoInit()")
            //        let doesPathExist = FileAsserter.exists(localPath)
            Swift.print("doesPathExist: " + "\(doesPathExist)")
            if doesPathExist {
                //            let isFolderEmpty:Bool = FileParser.contentOfDir(localPath)?.isEmpty ?? false
                //            Swift.print("isFolderEmpty: " + "\(isFolderEmpty)")
                if isFolderEmpty {//--folder is empty
                    //GitUtils.manualClone(localPath, remotePath)
                    
                    //let cloneRetVal = GitModifier.clone(remotePath, localPath)
                    //Swift.print("cloneRetVal: " + "\(cloneRetVal)")
                    //GitUtil's clone(remote_url, local_dir)--git clone with custom file path
                }else{//--folder is not empty, files already exist
                    //                let isGitFolder:Bool = GitAsserter.isGitRepo(localPath)
                    if isGitFolder {//--folder already contains a .git folder (aka git repo data)
                        
                    }else{//--has no .git folder, but there are some files like text.txt
                        
                    }
                    //                let gitRepo = GitRepo(localPath,  remotePath,  branch)
                    //                let repoItem = RepoItem.repoItem(gitRepo)
                    MergeUtils.manualMerge(repoItem){
                        Swift.print("Manual merge completed")
                    }
                }
            }else {//--path does not exist
                //GitUtils.manualClone(localPath, remotePath)
                
                //_ = GitModifier.clone(remotePath, localPath)
                //GitUtil's clone(remote_url, local_dir)
            }
        }
    }
    
}
private class Utils{
    static func pathExists(_ repoItem:RepoItem)->Bool {
        return FileAsserter.exists(repoItem.localPath)
    }
    static func isGitRepo(_ repoItem:RepoItem)->Bool {
        return GitAsserter.isGitRepo(repoItem.localPath)
    }
    static func hasPathContent(_ repoItem:RepoItem)->Bool {
        return FileAsserter.hasContent(repoItem.localPath)
    }
}
extension AutoInitConflict{
    //TODO: ⚠️️ make priv get pub set
    static let dummyData:AutoInitConflict = {
        //        let issue:String = "There is no folder in the file path: ~/dev/demo3"
        //        let proposal:String = "Do you want to create it and download from remote?"
        return AutoInitConflict(RepoItem(local: "~/dev/demo",branch: "master",title: "demo")/*pathExists:false,isGitRepo:false,hasPathContent:false*/)
    }()
    /**
     * New
     */
    var conflict:(issue:String,proposal:String){
        var issue:String = ""
        var proposal:String = ""
        if pathExists == false {
            issue = "There is no folder in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to create it and download from remote?"
        }else if pathExists && hasPathContent == false{
            issue = "There is no content in the file path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote?"
        }else if pathExists && hasPathContent{
            issue = "There is preExisiting files in path: " + "\(repoItem.localPath)"
            proposal = "Do you want to download from remote and initiate a merge wizard?"
        }
        return (issue,proposal)
    }
}

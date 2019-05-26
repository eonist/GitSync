import Foundation
/**
 * DataBase for git commit count (so that graphs can be drawn from the data, querrying git is to cpu intensive for visualization)
 * TODO: ⚠️️ Figure out a sceheme to store the repo commit stats in database where it's also removable if repos are removed etc. Also filtering repos 👈👈👈
 * TODO: ⚠️️ No cached data at first 👌
 * TODO: ⚠️️ Use Dictionaries as they avoid having to loop over lists all the time 👌
 */
class CommitCountDB {
    var repos:[String:YearDict]
    init(repos:[String:YearDict] = [:]){
        self.repos = repos
    }
}

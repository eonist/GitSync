/**
 * Accessors
 */
extension RepoItem {
    var localPath: String { get { return local } set { local = newValue } }
    var remotePath: String { get { return remote } set { remote = newValue } }
}
/**
 * Subscript
 */
extension RepoItem{
    subscript<T>(key: String) -> T? {
        get {
            switch key {
            case "local": return local as? T
            case "branch": return branch as? T
            case "title": return title as? T
            case "active": return active as? T
            case "remote": return remote as? T
            case "message": return message as? T
            case "auto": return auto as? T
            case "template": return template as? T
            case "notification": return notification as? T
            default: return nil
            }
        }
        set {
            switch key {
            case "local": local = newValue as! String //⚠️️ use if assert first
            case "branch": branch = newValue as! String
            case "title": title = newValue as! String
            case "active": active = newValue as! Bool
            case "remote": remote = newValue as! String
            case "message": message = newValue as! Bool
            case "auto": auto = newValue as! Bool
            case "template": template = newValue as! String
            case "notification": notification = newValue as! Bool
            default: break;
            }
        }
    }
}

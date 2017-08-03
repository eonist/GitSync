import Foundation
@testable import Utils
/**
 * Config for gitsync 📝
 */
enum Config {
    enum Bundle{
        /*The root of the asset bundle*/
        static let assets:String = FilePathParser.resourcePath + "/assets.bundle/user/"
        /*Stores the repo details*/
        static let repo:String = {
            return assets + (Config.release == .dev ? "dev/repos.xml" : "pub/repos.xml")
        }()
        /*UI structure of the app*/
        static let app:String = assets + "gitsync.json"
        /*The app prefs*/
        static let prefs:String = {
            return assets + (Config.release == .dev ? "dev/prefs.xml" : "pub/prefs.xml")
        }()
        /*Cache.swift uses this url*/
        static let commitCacheURL:String = {
            return assets + (Config.release == .dev ? "dev/sortedcommits.xml" : "pub/sortedcommits.xml")
        }()
    }
    enum ReleaseType {case dev,pub}
    static let release:ReleaseType = .dev
}

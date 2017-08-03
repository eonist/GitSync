import Foundation
@testable import Utils
/**
 * Config for gitsync 📝
 */
enum Config {
    enum Bundle{
        /*The root of the asset bundle*/
        static let assets:String = FilePathParser.resourcePath + "/assets.bundle/"
        /*Stores the repo details*/
        static let repo:String = assets + "repo2.xml"
        /*UI structure of the app*/
        static let app:String = assets + "gitsync.json"
        /*The app prefs*/
        static let prefs:String = {
            return assets + (Config.release == .dev ? "prefs_dev.xml" : "prefs_pub.xml")
        }()
        /*Cache.swift uses this url*/
        static let commitCacheURL:String = assets + "sortedcommits.xml"
    }
    enum ReleaseType {case dev,pub}
    static let release:ReleaseType = .pub
}

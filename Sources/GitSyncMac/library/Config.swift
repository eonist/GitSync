import Foundation
@testable import Utils
/**
 * Config for gitsync 📝
 */
enum Config {
    enum Bundle{
        /*The root of the asset bundle*/
        static let assets:String = FilePathParser.resourcePath + "/assets.bundle/"//rename to user maybe?
        static let styles:String = FilePathParser.resourcePath + "/styles.bundle/"
        /*Stores the repo details*/
        static let repo:String = {
            return assets + (Config.release == .dev ? "user/dev/repos.xml" : "user/pub/repos.xml")
        }()
        /*UI structure of the app*/
        static let app:String = assets + "structure.json"
        /*The app prefs*/
        static let prefs:String = {
            return assets + (Config.release == .dev ? "user/dev/prefs.xml" : "user/pub/prefs.xml")
        }()
        /*Cache.swift uses this url*/
        static let commitCacheURL:String = {
            return assets + (Config.release == .dev ? "user/dev/sortedcommits.xml" : "user/pub/sortedcommits.xml")
        }()
    }
    enum ReleaseType {case dev,pub}
    static let release:ReleaseType = .dev/*Toggle between development and public release*/
}

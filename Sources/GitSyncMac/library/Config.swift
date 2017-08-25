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
        static let repo:String = {/*Stores the repo details*/
            return assets + (Config.release == .dev ? "user/dev/repos.xml" : "user/pub/repos.xml")
        }()
        static let structure:String = assets + "structure.json"/*UI structure of the app*/
        static let prefsURL:String = {/*The app prefs*/
            return assets + (Config.release == .dev ? "user/dev/prefs.xml" : "user/pub/prefs.xml")
        }()
        static let commitCacheURL:String = {/*Cache.swift uses this url*/
            return assets + (Config.release == .dev ? "user/dev/sortedcommits.xml" : "user/pub/sortedcommits.xml")
        }()
    }
    enum ReleaseType {case dev,pub}
    static let release:ReleaseType = .dev/*Toggle between development and public release*/
}

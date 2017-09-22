import Cocoa
@testable import Utils
@testable import Element
@testable import GitSyncMac

class TimeBarZ:ElasticScrollerFastList5{
//    override var dp:GraphZDP
    let graphZ:GraphZ
    override var dp: DataProvider {get{return graphZ.dp}set{_ = newValue}}
    
    init(graphZ:GraphZ, config:List5.Config = List5.Config.defaultConfig, size: CGSize = CGSize(), id: String? = nil) {
        self.graphZ = graphZ
        super.init(config: config, size: size, id: id)
    }
    override func scrollWheel(with event: NSEvent) {
        //override to block
    }
    required init(coder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //timeLabels
    override func resolveSkin() {
        super.resolveSkin()
        //createTimeLables()
    }
    override func getClassType() -> String {
        return "TimeBar"
    }
}


//Continue here: 🏀
    //Fix the size, also more debug colors, and add itemAt print

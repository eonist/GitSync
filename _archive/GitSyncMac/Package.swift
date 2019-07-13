import PackageDescription

let package = Package(
    name: "GitSyncMac",
    dependencies: [.Package(url: "https://github.com/eonist/Element.git", Version(0, 0, 0, prereleaseIdentifiers: ["alpha", "10"]))]
)

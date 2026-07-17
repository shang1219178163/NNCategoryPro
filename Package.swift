// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "NNCategoryPro",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "NNCategoryPro",
            targets: ["NNCategoryPro"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/shang1219178163/NNGloble.git", from: "2.2.1"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.15.0")
    ],
    targets: [
        .target(
            name: "NNCategoryPro",
            dependencies: [
                "NNGloble",
                "SDWebImage"
            ],
            path: "NNCategoryPro",
            publicHeadersPath: ".",
            cSettings: [
                .headerSearchPath(".")
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreImage"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("WebKit"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("Photos"),
                .linkedFramework("UserNotifications")
            ]
        )
    ]
)

// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Anime",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        Product.library(
            name: "AnimeCore",
            targets: ["AnimeCore"]
        ),
        Product.executable(
            name: "Anime",
            targets: ["Anime"]
        )

    ],
    dependencies: [
        .package(url: "https://github.com/AlTavares/Nappa.git", from: "3.0.0"),
        .package(url: "https://github.com/formbound/Futures.git", from: "1.1.0"),
        .package(url: "https://github.com/tid-kijyun/Kanna.git", from: "4.0.0"),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.0.0"),
        .package(url: "https://github.com/crossroadlabs/Regex.git", from: "1.0.0"),

        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Anime",
            dependencies: ["Nappa", "Futures", "Kanna", "AnimeCore"]
        ),
        .target(
            name: "AnimeCore",
            dependencies: ["Nappa", "Futures", "Kanna", "SwiftyBeaver", "Regex"]
        ),
        .testTarget(
            name: "AnimeCoreTests",
            dependencies: ["AnimeCore"]
        ),
    ]
)

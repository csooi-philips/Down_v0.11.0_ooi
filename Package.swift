// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Down",
    platforms: [
        .iOS("15.0") // bump to match MarkdownUI’s mins
    ],
    products: [
        .library(name: "Down", targets: ["Down"])
    ],
    dependencies: [
        // Use the same cmark as MarkdownUI
        .package(url: "https://github.com/swiftlang/swift-cmark", from: "0.4.0"),
    ],
    targets: [
        // Swift shim named *libcmark* that re-exports cmark-gfm
        .target(
            name: "libcmark",
            dependencies: [
                .product(name: "cmark-gfm", package: "swift-cmark"),
                .product(name: "cmark-gfm-extensions", package: "swift-cmark"),
            ],
            path: "Sources/libcmark"
        ),

        .target(
            name: "Down",
            dependencies: ["libcmark"],
            path: "Sources/Down",
            exclude: ["Down.h"],
            resources: [
                .copy("Resources/DownView.bundle"),
                .copy("Resources/DownView (macOS).bundle"),
            ]
        ),

        .testTarget(
            name: "DownTests",
            dependencies: ["Down"],
            path: "Tests/DownTests",
            exclude: [
                "AST/VisitorTests.swift",
                "AST/__Snapshots__",
                "DownViewTests.swift",
                "Fixtures",
                "Styler/__Snapshots__",
                "Styler/BlockQuoteStyleTests.swift",
                "Styler/CodeBlockStyleTests.swift",
                "Styler/DownDebugLayoutManagerTests.swift",
                "Styler/HeadingStyleTests.swift",
                "Styler/LinkStyleTests.swift",
                "Styler/InlineStyleTests.swift",
                "Styler/ListItemStyleTests.swift",
                "Styler/StylerTestSuite.swift",
                "Styler/ThematicBreakSyleTests.swift"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)

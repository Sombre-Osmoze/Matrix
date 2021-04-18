// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Matrix",
	platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6), .tvOS(.v13)],
	// MARK: Matrix SDK
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
		// MARK: - Matrix

		.library(
			name: "Matrix",
			targets: ["Matrix"]),

		// MARK: - Matrix Client

        .library(
            name: "MatrixClient",
            targets: ["MatrixClient"]),


		// MARK: - Matrix Package

		.library(name: "MatrixSDK", targets: ["MatrixSDK"])

    ],


    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),

		// 📄 Log
		.package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.

		// MARK: - Matrix Targets

		// MARK: Matrix Target
		.target(
			name: "Matrix",
			dependencies: []),


		// MARK: Matrix Client Target
		.testTarget(
			name: "MatrixTests",
			dependencies: [
				"Matrix",
				.product(name: "Logging", package: "swift-log"),
			]),



		// MARK: - Matrix Client Targets

		// MARK: Matrix Client Target
		.target(
            name: "MatrixClient",
            dependencies: ["Matrix"]),


		// MARK: Matrix Client Tests Target
        .testTarget(
            name: "MatrixClientTests",
			dependencies: [
				"MatrixClient",
				.product(name: "Logging", package: "swift-log")
			]),


		// MARK: Matrix SDK
		.target(
			name: "MatrixSDK",
			dependencies : ["Matrix", "MatrixClient"]),
    ]
)

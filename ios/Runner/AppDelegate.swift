//
// Copyright © 2022 Nevis Security AG. All rights reserved.
//

import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
	// MARK: Properties

	var deepLinkMethodChannel: FlutterMethodChannel?
	var deepLinkEventChannel: FlutterEventChannel?
	let linkStreamHandler = LinkStreamHandler()

	// MARK: UIApplicationDelegate

	override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let controller = window.rootViewController as! FlutterViewController
		deepLinkMethodChannel = FlutterMethodChannel(name: MethodChannel.Name.deeplink,
		                                             binaryMessenger: controller.binaryMessenger)
		deepLinkEventChannel = FlutterEventChannel(name: EventChannel.Name.deeplink,
		                                           binaryMessenger: controller.binaryMessenger)

		deepLinkMethodChannel?.setMethodCallHandler { (call: FlutterMethodCall, result: FlutterResult) in
			guard call.method == FlutterMethod.initialLink else {
				result(FlutterMethodNotImplemented)
				return
			}

			result(String())
		}

		GeneratedPluginRegistrant.register(with: self)
		deepLinkEventChannel?.setStreamHandler(linkStreamHandler)

		return super.application(application, didFinishLaunchingWithOptions: launchOptions)
	}

	override func application(_: UIApplication, open url: URL, options _: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
		deepLinkEventChannel?.setStreamHandler(linkStreamHandler)
		return linkStreamHandler.handleLink(url.absoluteString)
	}
}

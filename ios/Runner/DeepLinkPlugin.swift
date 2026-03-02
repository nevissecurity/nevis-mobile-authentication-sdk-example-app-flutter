//
// Copyright © 2026 Nevis Security AG. All rights reserved.
//

import Flutter
import Foundation

class DeepLinkPlugin: NSObject, FlutterPlugin, FlutterStreamHandler, FlutterSceneLifeCycleDelegate {
	// MARK: - Properties

	static let shared = DeepLinkPlugin()

	private var eventSink: FlutterEventSink?
	private var initialLink: String?
	private var latestLink: String?

	// MARK: - FlutterPlugin

	static func register(with registrar: FlutterPluginRegistrar) {
		let deepLinkMethodChannel = FlutterMethodChannel(name: MethodChannel.Name.deeplink,
		                                                 binaryMessenger: registrar.messenger())
		let deepLinkEventChannel = FlutterEventChannel(name: EventChannel.Name.deeplink,
		                                               binaryMessenger: registrar.messenger())
		let instance = DeepLinkPlugin.shared
		registrar.addMethodCallDelegate(instance, channel: deepLinkMethodChannel)
		deepLinkEventChannel.setStreamHandler(instance)
		registrar.addSceneDelegate(instance)
	}

	func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
		switch call.method {
		case FlutterMethod.initialLink:
			result(initialLink)
		default:
			result(FlutterMethodNotImplemented)
		}
	}

	// MARK: - FlutterSceneLifeCycleDelegate

	// swiftformat:disable:next unusedArguments
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions?) -> Bool {
		guard let urlContext = connectionOptions?.urlContexts.first else {
			return false
		}

		handleLink(url: urlContext.url)
		return true
	}

	// swiftformat:disable:next unusedArguments
	func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) -> Bool {
		guard let urlContext = URLContexts.first else {
			return false
		}

		handleLink(url: urlContext.url)
		return true
	}

	// MARK: - FlutterStreamHandler

	// swiftformat:disable:next unusedArguments
	func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
		eventSink = events
		return nil
	}

	// swiftformat:disable:next unusedArguments
	func onCancel(withArguments arguments: Any?) -> FlutterError? {
		eventSink = nil
		return nil
	}
}

private extension DeepLinkPlugin {
	func handleLink(url: URL) {
		let link = url.absoluteString
		latestLink = link

		if initialLink == nil {
			initialLink = link
		}

		guard let eventSink, latestLink != nil else {
			return
		}

		eventSink(latestLink)
	}
}

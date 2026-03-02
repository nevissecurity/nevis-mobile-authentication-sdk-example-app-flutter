//
// Copyright © 2022 Nevis Security AG. All rights reserved.
//

import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
	// MARK: FlutterImplicitEngineDelegate

	func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
		GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
		DeepLinkPlugin.register(with: engineBridge.pluginRegistry.registrar(forPlugin: "DeepLinkPlugin")!)
	}
}

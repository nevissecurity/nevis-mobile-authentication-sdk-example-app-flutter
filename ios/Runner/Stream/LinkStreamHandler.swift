//
// Copyright © 2022 Nevis Security AG. All rights reserved.
//

import Flutter

class LinkStreamHandler: NSObject, FlutterStreamHandler {
	var eventSink: FlutterEventSink?

	// links will be added to this queue until the sink is ready to process them
	var queuedLinks = [String]()

	func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
		eventSink = events
		queuedLinks.forEach { events($0) }
		queuedLinks.removeAll()
		return nil
	}

	func onCancel(withArguments _: Any?) -> FlutterError? {
		eventSink = nil
		return nil
	}

	func handleLink(_ link: String) -> Bool {
		guard let eventSink else {
			queuedLinks.append(link)
			return false
		}

		eventSink(link)
		return true
	}
}

/*
 * Copyright © 2022 Nevis Security AG. All rights reserved.
 */

package ch.nevis.exampleapp

import android.content.BroadcastReceiver
import android.content.Intent
import android.os.Bundle
import ch.nevis.exampleapp.deeplink.DeepLinkPlatformMethodNames.INITIAL_LINK
import ch.nevis.exampleapp.deeplink.DeepLinkReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    companion object {
        private const val METHOD_CHANNEL_NAME =
            "nevis_mobile_authentication_sdk_example/deeplink_method_channel"
        private const val EVENT_CHANNEL_NAME =
            "nevis_mobile_authentication_sdk_example/deeplink_event_channel"
    }

    private var startString: String? = null
    private var linksReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor,
            METHOD_CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            if (call.method == INITIAL_LINK.methodName) {
                result.success(startString)
            } else {
                result.notImplemented()
            }
        }

        EventChannel(flutterEngine.dartExecutor, EVENT_CHANNEL_NAME).setStreamHandler(
            object : StreamHandler {
                override fun onListen(args: Any?, events: EventSink) {
                    linksReceiver = DeepLinkReceiver(events)
                }

                override fun onCancel(args: Any?) {
                    linksReceiver = null
                }
            }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startString = intent.data?.toString()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action == Intent.ACTION_VIEW) {
            linksReceiver?.onReceive(this.applicationContext, intent)
        }
    }
}

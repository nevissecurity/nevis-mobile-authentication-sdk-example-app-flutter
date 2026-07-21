/*
 * Copyright © 2022 Nevis Security AG. All rights reserved.
 */

package ch.nevis.exampleapp.deeplink

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.EventChannel.EventSink

class DeepLinkReceiver(private val events: EventSink) : BroadcastReceiver() {
    // We assume that intent.getAction() is Intent.ACTION_VIEW
    override fun onReceive(context: Context, intent: Intent) {
        val dataString = intent.dataString ?: events.error(
            "LINK_UNAVAILABLE",
            "App or deeplink data was null",
            null
        )
        events.success(dataString)
    }
}

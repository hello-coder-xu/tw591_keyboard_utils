package com.tw591_keyboard_utils

import android.app.Activity
import com.tw591_keyboard_utils.keyboard.DisplayUtil
import com.tw591_keyboard_utils.keyboard.KeyboardHeightListener
import com.tw591_keyboard_utils.keyboard.KeyboardOptions
import com.tw591_keyboard_utils.keyboard.TwKeyboardUtils
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.PluginRegistry

class Tw591KeyboardUtilsPlugin : FlutterPlugin, ActivityAware, EventChannel.StreamHandler {
    private var keyboardUtil: TwKeyboardUtils? = null
    private var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding? = null
    private var activityPluginBinding: ActivityPluginBinding? = null
    private var activity: Activity? = null
    private var eventChannel: EventChannel? = null
    private final val channelIdentifier = "tw591_keyboard_utils"


    private fun setup(activity: Activity?, messenger: BinaryMessenger) {
        println("test 软键盘")
        if (eventChannel == null) {
            eventChannel = EventChannel(messenger, channelIdentifier)
            eventChannel?.setStreamHandler(this)
        }

        this.activity = activity

        if (this.activity != null) {
            keyboardUtil?.unregisterKeyboardHeightListener()
            keyboardUtil = TwKeyboardUtils()

        }
    }

    private fun tearDown() {
        eventChannel = null
        activityPluginBinding = null
        keyboardUtil?.unregisterKeyboardHeightListener()
        keyboardUtil = null
    }


    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterPluginBinding = binding
        setup(null, binding.binaryMessenger)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        flutterPluginBinding = null
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activityPluginBinding = binding
        if (flutterPluginBinding != null) {
            setup(binding.activity, flutterPluginBinding!!.binaryMessenger)
        }
    }

    override fun onDetachedFromActivity() {
        tearDown()
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        println("test 我进来了 000 ")
        activity?.apply {
            println("test 我进来了 1111")
            keyboardUtil?.registerKeyboardHeightListener(activity, object : KeyboardHeightListener {
                override fun open(height: Int) {
                    val tempHeight = DisplayUtil.pxTodp(activity, height.toFloat())
                    val resultJSON = KeyboardOptions(isKeyboardOpen = true, height = tempHeight)
                    events?.success(resultJSON.toJson())
                }

                override fun hide() {
                    val resultJSON = KeyboardOptions(isKeyboardOpen = false, height = 0)
                    events?.success(resultJSON.toJson())
                }
            })
        }
    }

    override fun onCancel(arguments: Any?) {}
}

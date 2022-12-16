package com.tw591_keyboard_utils.keyboard;

import org.json.JSONObject

/**
 * Created by Wilson Martins on 2019-10-25.
 */
class KeyboardOptions(private val isKeyboardOpen: Boolean, private val height: Int) {
    fun toJson(): String = JSONObject().apply {
        put("isKeyboardOpen", isKeyboardOpen)
        put("keyboardHeight", height)
    }.toString()
}
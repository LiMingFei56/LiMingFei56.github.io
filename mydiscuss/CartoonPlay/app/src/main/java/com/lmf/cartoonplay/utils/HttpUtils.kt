package com.lmf.cartoonplay.utils

import com.lmf.cartoonplay.BuildConfig
import java.io.BufferedReader
import java.io.InputStreamReader
import java.lang.StringBuilder
import java.net.HttpURLConnection
import java.net.URL


fun httpGet(method: String, param: String): String? {
    val requestUrl = "${BuildConfig.baseUrl}/$method?$param"

    val conn = URL(requestUrl).openConnection() as HttpURLConnection
    val buff = StringBuilder()
    try {
        val reader = BufferedReader(InputStreamReader(conn.inputStream))

        reader.forEachLine {
            buff.append(it)
        }

        reader.close()
    } catch (e: Exception) {

    }

    return buff.toString()
}
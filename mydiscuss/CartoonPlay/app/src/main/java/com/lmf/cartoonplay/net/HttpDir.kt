package com.lmf.cartoonplay.net

import android.os.AsyncTask
import android.text.TextUtils
import com.github.salomonbrys.kotson.*
import com.google.gson.Gson
import com.lmf.cartoonplay.model.Dir
import com.lmf.cartoonplay.utils.httpGet
import java.net.URLEncoder

class HttpDir(private val callback: HttpDirCallback): AsyncTask<Dir, Void, List<Dir>>() {

    lateinit var response: String

    override fun doInBackground(vararg params: Dir?): List<Dir> {
        var requestPath = if (params.count() == 0 || params[0] == null) "/" else connRequestPath(params[0]!!.parentDir, params[0]!!.name )
        requestPath = URLEncoder.encode(requestPath, "UTF-8")
        response = httpGet("CartoonFileManager/path", "path=$requestPath")!!
        if (TextUtils.isEmpty(response)) {
            return listOf();
        }
        val gson = Gson()
        return gson.fromJson<List<Dir>>(response!!)
    }

    override fun onPostExecute(result: List<Dir>?) {
        callback.callback(result!!, response)
    }

    private fun connRequestPath(parent: String, filename: String): String {
        return if (parent[parent.count() - 1] != '/') "$parent/$filename" else "$parent$filename"
    }
}

interface HttpDirCallback {

    fun callback(data: List<Dir>, response: String)

}
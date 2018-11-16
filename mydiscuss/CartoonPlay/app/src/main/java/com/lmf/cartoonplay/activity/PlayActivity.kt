package com.lmf.cartoonplay.activity

import android.app.Activity
import android.os.Bundle
import android.os.Environment
import cn.jzvd.Jzvd
import com.github.salomonbrys.kotson.*
import cn.jzvd.JzvdStd
import com.google.gson.Gson
import com.lmf.cartoonplay.BuildConfig
import com.lmf.cartoonplay.JzvdLoopVideo
import com.lmf.cartoonplay.JzvdLoopVideoDelegate
import com.lmf.cartoonplay.R
import com.lmf.cartoonplay.model.Dir
import kotlinx.android.synthetic.main.activity_play.view.*
import java.net.URLEncoder

class PlayActivity: Activity() {

    companion object {
        const val KEY_DIR_LIST = "payactivity.dir.list"
        const val KEY_POSITION = "payactivity.position"
    }

    lateinit var dirData: List<Dir>
    lateinit var myJzvdStd: JzvdLoopVideo
    private var position: Int = 0
    private var isFirst = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_play)


        val gson = Gson()
        dirData = gson.fromJson(intent.getStringExtra(KEY_DIR_LIST))
        position = intent.getIntExtra(KEY_POSITION, 0)

        myJzvdStd = findViewById<JzvdLoopVideo>(R.id.videoplayer)
        myJzvdStd.delegate = object: JzvdLoopVideoDelegate {
            override fun videoCompletion() {
                isFirst = false
                val newPosition = if (position >= dirData.count() - 1) 0 else position + 1
                if (position != newPosition) {
                    position = newPosition
                    playHttpVideo()
                }
            }
        }
        playHttpVideo()
//        myJzvdStd.setUp(Environment.getExternalStorageDirectory().getAbsolutePath() + "/abc.mp4", "饺子不信",Jzvd.SCREEN_WINDOW_NORMAL);

    }

    override fun onResume() {
        super.onResume()
        JzvdStd.goOnPlayOnResume()
    }

    override fun onPause() {
        super.onPause()
        JzvdStd.goOnPlayOnPause()
    }

    override fun onBackPressed() {
        if (Jzvd.backPress()) {
            return
        }
        super.onBackPressed()
    }

    override fun onDestroy() {
        super.onDestroy()
        Jzvd.releaseAllVideos()
    }

    private fun playHttpVideo() {
        val currDir = dirData[position]
        val path = if (currDir.parentDir[currDir.parentDir.count() - 1] != '/') "${currDir.parentDir}/${currDir.name}" else "${currDir.parentDir}${currDir.name}"
        val pathEncode = URLEncoder.encode(path, "UTF-8")
        val httpUrl = "http://192.168.2.183:8856/CartoonFileManager/video?path=$pathEncode"
        val title = currDir.name
        if (isFirst) {
            myJzvdStd.setUp(httpUrl, title, JzvdStd.SCREEN_WINDOW_NORMAL)
            myJzvdStd.startVideo()
        } else {
            myJzvdStd.changeUrl(httpUrl, title, 0)
        }
    }
}
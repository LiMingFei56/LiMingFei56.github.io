package com.lmf.cartoonplay.activity

import android.app.Activity
import android.os.Bundle
import cn.jzvd.Jzvd
import cn.jzvd.JzvdStd
import com.lmf.cartoonplay.R
import java.net.URLEncoder

class PlayActivity: Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_play)
        val jzvdView = findViewById<JzvdStd>(R.id.videoplayer)
        jzvdView.setUp("http://192.168.2.183:8856/CartoonFileManager/streamVideo", "S101", JzvdStd.SCREEN_WINDOW_NORMAL)
    }

    override fun onBackPressed() {
        if(Jzvd.backPress()){
            return;
        }
        super.onBackPressed()
    }

    override fun onPause() {
        super.onPause()
        Jzvd.releaseAllVideos();
    }

}
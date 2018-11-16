package com.lmf.cartoonplay

import android.app.Application
import cn.jzvd.JZMediaSystem
import cn.jzvd.Jzvd
import com.lmf.cartoonplay.utils.JZExoPlayer
import com.lmf.cartoonplay.utils.JZMediaIjkplayer

class MyApplication : Application() {

    override fun onCreate() {
        super.onCreate()

        Jzvd.WIFI_TIP_DIALOG_SHOWED = true
        Jzvd.setMediaInterface(JZMediaIjkplayer())
        Jzvd.setMediaInterface(JZMediaSystem())
//        Jzvd.setMediaInterface(JZExoPlayer())
    }

}
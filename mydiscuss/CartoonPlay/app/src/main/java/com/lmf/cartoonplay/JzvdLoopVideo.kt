package com.lmf.cartoonplay

import android.content.Context
import android.media.AudioManager
import android.util.AttributeSet
import android.util.Log
import android.view.WindowManager
import cn.jzvd.JZMediaManager
import cn.jzvd.JZUtils
import cn.jzvd.Jzvd
import cn.jzvd.JzvdStd
import cn.jzvd.JzvdMgr



class JzvdLoopVideo(context: Context, attributeSet: AttributeSet): JzvdStd(context, attributeSet) {

    var delegate: JzvdLoopVideoDelegate? = null

    override fun onCompletion() {
        if (currentState == Jzvd.CURRENT_STATE_PLAYING || currentState == Jzvd.CURRENT_STATE_PAUSE) {
            val position = currentPositionWhenPlaying
            JZUtils.saveProgress(context, jzDataSource.currentUrl, position)
        }
        cancelProgressTimer()
        dismissBrightnessDialog()
        dismissProgressDialog()
        dismissVolumeDialog()
        onStateNormal()
        textureViewContainer.removeView(JZMediaManager.textureView)
        JZMediaManager.instance().currentVideoWidth = 0
        JZMediaManager.instance().currentVideoHeight = 0

        val mAudioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        mAudioManager.abandonAudioFocus(Jzvd.onAudioFocusChangeListener)
        JZUtils.scanForActivity(context).window.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        clearFullscreenLayout()
//        JZUtils.setRequestedOrientation(context, Jzvd.NORMAL_ORIENTATION)

        if (JZMediaManager.surface != null) JZMediaManager.surface.release()
        if (JZMediaManager.savedSurfaceTexture != null)
            JZMediaManager.savedSurfaceTexture.release()
        JZMediaManager.textureView = null

        JZMediaManager.savedSurfaceTexture = null

        cancelDismissControlViewTimer()
        if (clarityPopWindow != null) {
            clarityPopWindow.dismiss()
        }
    }

    override fun onAutoCompletion() {
        super.onAutoCompletion()
        delegate?.videoCompletion()
    }

}

interface JzvdLoopVideoDelegate {

    fun videoCompletion()

}
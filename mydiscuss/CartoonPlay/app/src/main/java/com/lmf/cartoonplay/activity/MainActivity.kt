package com.lmf.cartoonplay.activity

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v4.widget.SwipeRefreshLayout
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.github.salomonbrys.kotson.jsonArray
import com.lmf.cartoonplay.R
import com.lmf.cartoonplay.model.Dir
import com.lmf.cartoonplay.net.HttpDir
import com.lmf.cartoonplay.net.HttpDirCallback
import java.lang.ref.WeakReference
import java.util.*

class MainActivity : AppCompatActivity() {

    private lateinit var gridView: GridView
    lateinit var gridAdapter: BaseAdapter
    lateinit var refreshView: SwipeRefreshLayout
    var dirData: List<Dir>? = null
    var dirDataJson: String = ""

    private val dirStack: Stack<Dir> = Stack()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        gridView = findViewById(R.id.gridview)
        gridAdapter = MyAdapter()
        gridView.adapter = gridAdapter
        gridView.setOnItemClickListener { _, _, position, _ ->
            val newDir = dirData!![position]
            if (!newDir.isVedio) {
                dirStack.push(newDir)
                requestDir(newDir)
            } else {
                val intent = Intent(this, PlayActivity::class.java)
                intent.putExtra(PlayActivity.KEY_DIR_LIST, dirDataJson)
                intent.putExtra(PlayActivity.KEY_POSITION, position)
                startActivity(intent)
            }
        }

        refreshView = findViewById(R.id.refresh)
        refreshView.isEnabled = false

        requestDir(null)
    }

    override fun onBackPressed() {
        if (dirStack.count() > 0) {
            dirStack.pop()
            requestDir(if (dirStack.count() == 0) null else dirStack[dirStack.count() - 1])
            return
        }
        super.onBackPressed()
    }

    private fun requestDir(dir: Dir?) {
        val dirRequest = HttpDir(object: HttpDirCallback{
            override fun callback(data: List<Dir>, response: String) {
                refreshView.isRefreshing = false
                if (data.count() > 0) {
                    dirDataJson = response
                    dirData = data
                    gridAdapter.notifyDataSetChanged()
                } else {
                    Toast.makeText(this@MainActivity, "没有内容或者没有网络", Toast.LENGTH_SHORT).show()
                }
            }

        })
        dirRequest.execute(dir)
        refreshView.isRefreshing = true
    }

    inner class MyAdapter: BaseAdapter() {

        override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
            val view = convertView ?: MyViewHolder(position, parent).itemView.get() as View
            val myViewHolder = view.tag as MyViewHolder
            myViewHolder.itemText.text = dirData!![position].name
            return view
        }

        override fun getItem(position: Int): Any {
            return dirData!![position]
        }

        override fun getItemId(position: Int): Long {
            return position.toLong()
        }

        override fun getCount(): Int {
            return if(dirData == null) 0 else dirData!!.count()
        }

    }

    inner class MyViewHolder(val position: Int, val parent: ViewGroup?) {
        var itemImg: ImageView
        var itemText: TextView
        var itemView: WeakReference<View>

        init {
            val view = layoutInflater.inflate(R.layout.item_main_grid, parent, false)
            itemView = WeakReference(view)

            itemImg = view.findViewById(R.id.item_img)
            itemText = view.findViewById(R.id.item_text)

            view.tag = this

        }

    }
}

---
layout: post
title: Android Widget
categories: android
tags: [android]
date: 2023-04-18
---

## Android Widget

### 1. widgets分类

1. Information widgets
2. Collection widgets
3. Control widgets
4. Hybrid widgets

### 2. Widgets组件

1. AppWidgetProviderInfo
2. AppWidgetProvider

#### AppWidgetProvider

* onUpdate() : 
* onAppWidgetOptionsChanged()
* onDeleted(Context, int[])
* onEnabled(Context)
* onDisabled(Context)
* onReceive(Context, Intent)


#### [Use collection widgets](https://developer.android.google.cn/develop/ui/views/appwidgets/collections?hl=en)

> 支持AbsListView or AdapterViewAnimator 的子类

* ListView
    A view that shows items in a vertically scrolling list.
* GridView
    A view that shows items in a two-dimensional scrolling grid.
* StackView
    A stacked card view—kind of like a rolodex—where the user can flick the front card up or down to see the previous or next card, respectively.
* AdapterViewFlipper
    An adapter-backed simple ViewAnimator that animates between two or more views. Only one child is shown at a time. 

    RemoteViewsService, RemoteViewsService.RemoteViewsFactor

    <service android:name="MyWidgetService"
    android:permission="android.permission.BIND_REMOTEVIEWS" />

    Intent intent = new Intent(context, WeekWidgetService.class);
    intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, appWidgetId);
    intent.setData(Uri.parse(intent.toUri(Intent.URI_INTENT_SCHEME)));
    intent.putExtra("data", data);
    remoteViews.setRemoteAdapter(R.id.gv_calendar, intent);

    AppWidgetManager.getInstance(context).updateAppWidget(appWidgetId, remoteViews);

### RemoteViews

#### 支持的控件

支持的布局:
    FrameLayout
    LinearLayout
    RelativeLayout
    GridLayout

支持的控件:
    AnalogClock
    Button
    Chronometer
    ImageButton
    ImageView
    ProgressBar
    TextView
    ViewFlipper
    ListView
    GridView
    StackView
    AdapterViewFlipper


### 更新Widget

    // 更新remoteViews, 不会调用provider onUpdate
    AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
    ComponentName componentName = new ComponentName(context, WidgetWeekProvider.class);
    appWidgetManager.updateAppWidget(componentName, remoteViews);

    // 发送广播更新, 会调用provider onUpdate方法
    Intent intent = new Intent(context.getApplicationContext(), WidgetWeekProvider.class);
    intent.setAction(AppWidgetManager.ACTION_APPWIDGET_UPDATE);
    int[] ids = new int[]{appWidgetId};
    intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids);
    context.sendBroadcast(intent);

widget不刷新:
    
    1. 是否有exception
    2. 有可能是布局和数据一样, 需要把设置不同layout, 可以大致一样, 但有细微差别
    3. remoteViews先设空, 再刷新
        
    
    // RemoteViewsFactory
    int[] widgetIds = mAppWidgetManager.getAppWidgetIds(mComponentName);
    mAppWidgetManager.notifyAppWidgetViewDataChanged( widgetIds, R.id.widget_listview );

> notifyAppWidgetViewDataChanged 会调用RemoteViewsService.RemoteViewsFactory类的onDataSetChanged方法, 
> 只有在FourQuadrantProvider中的onUpdate方法中调用 notifyAppWidgetViewDataChanged 才有效.

    appWidgetManager.updateAppWidget(componentName, null);
    appWidgetManager.updateAppWidget(componentName, remoteViews);


    


## Reference
+ [App widgets overview](https://developer.android.google.cn/develop/ui/views/appwidgets/overview?hl=en)
+ [Android: loading bitmap from local storage into app widget (RemoteViews)](https://stackoverflow.com/questions/35138924/android-loading-bitmap-from-local-storage-into-app-widget-remoteviews)

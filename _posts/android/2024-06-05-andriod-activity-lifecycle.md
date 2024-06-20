---
layout: post
title: Android Activity Lifecycle
categories: android
tags: [android]
date: 2024-06-05
---

## Android Activity Lifecycle

### 生命周期

    onCreate
    onStart
    onResume
    onPause
    onStop
    onDestroy

当Activity在异常情况下终止时: 
    onSaveInstanceState
    onRestoreInstanceState

    横竖屏切换的生命周期：onPause() --> onSaveInstanceState() --> onStop() --> onDestory() --> onCreate() --> onStart() --> onRestoreInstanceState() --> onResume()

### Activity 四种启动模式

* standard
* singleTop
* singleTask
* singleInstance
* singleInstancePerTask(android 12)

   onNewIntent 

int 	FLAG_ACTIVITY_BROUGHT_TO_FRONT

This flag is not normally set by application code, but set for you by the system as described in the launchMode documentation for the singleTask mode.
int 	FLAG_ACTIVITY_CLEAR_TASK

If set in an Intent passed to Context.startActivity(), this flag will cause any existing task that would be associated with the activity to be cleared before the activity is started.
int 	FLAG_ACTIVITY_CLEAR_TOP

If set, and the activity being launched is already running in the current task, then instead of launching a new instance of that activity, all of the other activities on top of it will be closed and this Intent will be delivered to the (now on top) old activity as a new Intent.
int 	FLAG_ACTIVITY_CLEAR_WHEN_TASK_RESET

This constant was deprecated in API level 21. As of API 21 this performs identically to FLAG_ACTIVITY_NEW_DOCUMENT which should be used instead of this.
int 	FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS

If set, the new activity is not kept in the list of recently launched activities.
int 	FLAG_ACTIVITY_FORWARD_RESULT

If set and this intent is being used to launch a new activity from an existing one, then the reply target of the existing activity will be transferred to the new activity.
int 	FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY

This flag is not normally set by application code, but set for you by the system if this activity is being launched from history.
int 	FLAG_ACTIVITY_LAUNCH_ADJACENT

This flag is only used for split-screen multi-window mode.
int 	FLAG_ACTIVITY_MATCH_EXTERNAL

If set in an Intent passed to Context.startActivity(), this flag will attempt to launch an instant app if no full app on the device can already handle the intent.
int 	FLAG_ACTIVITY_MULTIPLE_TASK

This flag is used to create a new task and launch an activity into it.
int 	FLAG_ACTIVITY_NEW_DOCUMENT

This flag is used to open a document into a new task rooted at the activity launched by this Intent.
int 	FLAG_ACTIVITY_NEW_TASK

If set, this activity will become the start of a new task on this history stack.
int 	FLAG_ACTIVITY_NO_ANIMATION

If set in an Intent passed to Context.startActivity(), this flag will prevent the system from applying an activity transition animation to go to the next activity state.
int 	FLAG_ACTIVITY_NO_HISTORY

If set, the new activity is not kept in the history stack.
int 	FLAG_ACTIVITY_NO_USER_ACTION

If set, this flag will prevent the normal Activity.onUserLeaveHint() callback from occurring on the current frontmost activity before it is paused as the newly-started activity is brought to the front.
int 	FLAG_ACTIVITY_PREVIOUS_IS_TOP

If set and this intent is being used to launch a new activity from an existing one, the current activity will not be counted as the top activity for deciding whether the new intent should be delivered to the top instead of starting a new one.
int 	FLAG_ACTIVITY_REORDER_TO_FRONT

If set in an Intent passed to Context.startActivity(), this flag will cause the launched activity to be brought to the front of its task's history stack if it is already running.
int 	FLAG_ACTIVITY_REQUIRE_DEFAULT

If set in an intent passed to Context.startActivity(), this flag will only launch the intent if it resolves to a single result.
int 	FLAG_ACTIVITY_REQUIRE_NON_BROWSER

If set in an intent passed to Context.startActivity(), this flag will only launch the intent if it resolves to a result that is not a browser.
int 	FLAG_ACTIVITY_RESET_TASK_IF_NEEDED

If set, and this activity is either being started in a new task or bringing to the top an existing task, then it will be launched as the front door of the task.
int 	FLAG_ACTIVITY_RETAIN_IN_RECENTS

By default a document created by FLAG_ACTIVITY_NEW_DOCUMENT will have its entry in recent tasks removed when the user closes it (with back or however else it may finish()).
int 	FLAG_ACTIVITY_SINGLE_TOP

If set, the activity will not be launched if it is already running at the top of the history stack.
int 	FLAG_ACTIVITY_TASK_ON_HOME

If set in an Intent passed to Context.startActivity(), this flag will cause a newly launching task to be placed on top of the current home activity task (if there is one). 

### task

> 一个任务是用户作业的一个堆栈, 堆栈中保存Activity实例


## Reference


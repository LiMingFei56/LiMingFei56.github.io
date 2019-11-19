---
layout: post
title: Android hideSoftInputFromWindow无效
categories: [android]
tags: [imm]
date: 2019-02-25
---

## Android hideSoftInputFromWindow无效

    InputMethodManager imm = (InputMethodManager) contextWeakReference.get().getSystemService(Context.INPUT_METHOD_SERVICE);
    imm.hideSoftInputFromWindow(queryEdit.getWindowToken(), 0);
    // 不能隐藏软键盘

### 解决
如果InputMethodManager状态为`SHOW_FORCED`，非强制不可隐藏，所以要改变当前状态

    imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT);
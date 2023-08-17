---
layout: post
title: Android 矢量图 vector
categories: android
tags: [android]
date: 2023-05-04
---

## Android 矢量图 vector

> SVG 在Android中不支持, Android支持自己的矢量格式`vector`


### vector旋转


    <vector xmlns:android="http://schemas.android.com/apk/res/android"
        android:width="16dp"
        android:height="16dp"
        android:viewportWidth="1024"
        android:viewportHeight="1024">

        <group
            android:pivotX="512"
            android:pivotY="512"
            android:rotation="180"
            >
            <path
                android:fillColor="#000000"
                android:pathData="M588.8 512L343.466667 266.666667c-14.933333-14.933333-14.933333-40.533333 0-55.466667l4.266666-4.266667c14.933333-14.933333 40.533333-14.933333 57.6 0l275.2 275.2c8.533333 8.533333 12.8 19.2 10.666667 29.866667 0 10.666667-4.266667 21.333333-10.666667 29.866667L405.333333 817.066667c-14.933333 14.933333-40.533333 14.933333-55.466666 0l-4.266667-4.266667c-14.933333-14.933333-14.933333-40.533333 0-55.466667L588.8 512z" />
        </group>
    </vector

> pivotX pivotY 为中心点, 以viewportWidth和viewportHeight为参照

## Reference

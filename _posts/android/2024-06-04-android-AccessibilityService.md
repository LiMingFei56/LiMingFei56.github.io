---
layout: post
title: Android AccessibilityService
categories: android
tags: [android]
date: 2024-06-04
---

## Android AccessibilityService

### 1. 创建

    1. create xml config in res/xml/config_accessibility_service

    <?xml version="1.0" encoding="utf-8"?>
    <accessibility-service xmlns:android="http://schemas.android.com/apk/res/android"
        android:accessibilityEventTypes="typeAllMask"
        android:accessibilityFeedbackType="feedbackAllMask"
        android:accessibilityFlags="flagDefault"
        android:canPerformGestures="true"
        android:description="@string/accessibility_service_description"
        android:notificationTimeout="100" />

    2. create AccessibilityService

    public class ApnSwitchService extends AccessibilityService {

        private static final String TAG = ApnSwitchService.class.getSimpleName();

        @Override
        public void onCreate() {
            super.onCreate();
        }


        //apparently this method is called every time a event occurs
        @Override
        public void onAccessibilityEvent(AccessibilityEvent accessibilityEvent) {
            Log.d(TAG, "onAccessibilityEvent: " + accessibilityEvent);
            //autoClick(2000, 100, 950, 581);
        }


        @Override
        public void onServiceConnected() {
            super.onServiceConnected();
        }

        @Override
        public void onInterrupt() {

        }

        public void autoClick(int startTimeMs, int durationMs, int x, int y) {
            boolean isCalled = dispatchGesture(gestureDescription(startTimeMs, durationMs, x, y), null, null);
            System.out.println(isCalled);
        }

        public GestureDescription gestureDescription(int startTimeMs, int durationMs, int x, int y) {
            Path path = new Path();
            path.moveTo(x, y);
            return createGestureDescription(new GestureDescription.StrokeDescription(path, startTimeMs, durationMs));
        }

        public GestureDescription createGestureDescription(GestureDescription.StrokeDescription... strokes) {
            GestureDescription.Builder builder = new GestureDescription.Builder();
            for (GestureDescription.StrokeDescription stroke : strokes) {
                builder.addStroke(stroke);
            }
            return builder.build();
        }
    }

    3. AndroidManifest.xml

    <service
           android:name="com.hbzxt.apn_switch.ApnSwitchService"
           android:enabled="true"
           android:label="ApnSwitchService"
           android:permission="android.permission.BIND_ACCESSIBILITY_SERVICE"
           android:exported="true">
           <intent-filter>
               <action android:name="android.accessibilityservice.AccessibilityService"/>
           </intent-filter>

           <meta-data
               android:name="android.accessibilityservice"
               android:resource="@xml/config_accessibility_service"/>
    </service>

### 2. 无障碍权限

> AccessibilityService 不能用户开启, 当开启了无障碍功能和开启应用无障碍(两个地方需要开启, 应用重装后也需要开启) 后AccessibilityManagerService会自动开启

    public int checkAccessibilityServicePermission(boolean isJumpSet) {
        AccessibilityManager accessibilityManager = (AccessibilityManager) context.getSystemService(Context.ACCESSIBILITY_SERVICE);
        boolean isAccessibilityEnabled = accessibilityManager.isEnabled();
        List<AccessibilityServiceInfo> enableAccessibilityServiceInfos = accessibilityManager.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_ALL_MASK);

        boolean isAppEnabled = false;
        for (AccessibilityServiceInfo accessibilityServiceInfo : enableAccessibilityServiceInfos) {
            if (accessibilityServiceInfo.getId().toLowerCase().contains(context.getPackageName())) {
                isAppEnabled = true;
                break;
            }
        }
        if (isJumpSet && !isAccessibilityEnabled || !isAppEnabled) {
            Toast.makeText(context, "自动功能需要打开辅助功能, 和应用授权", Toast.LENGTH_LONG).show();
            Intent myIntent = new Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS);
            myIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(myIntent);
        }
        int result = isAccessibilityEnabled && isAppEnabled ? 0 : (isAccessibilityEnabled ? 2 : 1);
        return result;
    }


     AccessibilityManager accessibilityManager = (AccessibilityManager) context.getSystemService(Context.ACCESSIBILITY_SERVICE);
     boolean isAccessibilityEnabled = accessibilityManager.isTouchExplorationEnabled();

     public void enableAccessibility(Context context) {
            String accessibilityServices = Settings.Secure.getString(
                    context.getContentResolver(),
                    Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            );

            if (accessibilityServices == null) {
                accessibilityServices = "";
            } else if (!accessibilityServices.isEmpty()) {
                accessibilityServices = ":$accessibilityServices";
            }
            Settings.Secure.putString(
                    context.getContentResolver(),
                    Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES,
                    "${activity.applicationInfo.packageName}/${ForegroundDetectorService::class.java.canonicalName}$accessibilityServices"
            );
            Settings.Secure.putString(
                    context.getContentResolver(),
                    Settings.Secure.ACCESSIBILITY_ENABLED, "1"
            );
     }


## Reference
+[A Complete Guide to Accessibility Service Part 2 — Android](https://medium.com/mindorks/a-complete-guide-to-accessibility-service-part-2-ec2bf4b693b1)
+[AccessibilityService原理及实践 ](https://juejin.cn/post/7109434056575549477)

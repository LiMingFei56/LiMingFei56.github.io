---
layout: post
title: "Andorid6.0获取权限"
categories: android
tags: [premission]
date: 2020-02-10
excerpt: "Andorid6.0获取权限"
---

## Andorid6.0获取权限
系统6.0后需要动态获取权限

1. 判断系统版本 Build.VERSION.SDK_INT >= 23

2. 判断是否有对应的权限 
    int checkCallPhonePermission = ContextCompat.checkSelfPermission(WelcomeActivity.this, Manifest.permission.READ_PHONE_STATE);
    if (checkCallPhonePermission != PackageManager.PERMISSION_GRANTED)

3. 请求权限
    requestPermissions(new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_CODE_READ_PHONE_STATE);

4. onActivityResult中处理授权结果

## 部分机型不会弹出授权框(小米, 华为等)
这些机型一般是到了调用对应功能时, 才会调用授权, 所以需要先请求权限, 然后模拟调用对应功能, 最后再请求权限

## 小米手机授权BUG
小米部分手机ContextCompat.checkSelfPermission(WelcomeActivity.this, Manifest.permission.READ_PHONE_STATE) 不会返回正确的结果

需要使用下面判断

    AppOpsManager appOpsManager = (AppOpsManager) getSystemService(Context.APP_OPS_SERVICE);
    int checkOp = appOpsManager.checkOp(AppOpsManager.OPSTR_READ_PHONE_STATE, Process.myUid(), getPackageName());
    if (checkOp != AppOpsManager.MODE_ALLOWED) {
        requestPermissions(new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_CODE_READ_PHONE_STATE);
        return;
    } else {
        //获取权限后的操作

    }

    if (Build.VERSION.SDK_INT >= 23) {
        int checkCallPhonePermission = ContextCompat.checkSelfPermission(WelcomeActivity.this, Manifest.permission.READ_PHONE_STATE);
                    if (checkCallPhonePermission != PackageManager.PERMISSION_GRANTED) {
                        requestPermissions(new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_CODE_READ_PHONE_STATE);
                        return;
                    } else {
                        //适配小米机型
                        AppOpsManager appOpsManager = (AppOpsManager) getSystemService(Context.APP_OPS_SERVICE);
                        int checkOp = appOpsManager.checkOp(AppOpsManager.OPSTR_READ_PHONE_STATE, Process.myUid(), getPackageName());
                        if (checkOp != AppOpsManager.MODE_ALLOWED) {
                            requestPermissions(new String[]{Manifest.permission.READ_PHONE_STATE}, REQUEST_CODE_READ_PHONE_STATE);
                            return;
                        } else {
                        //获取权限后的操作

                        }
                    }

                } else {
                //获取权限后的操作
                }
    }

## 没有权限跳转到设置中的权限页面

    class PermissionUtil {

        companion object {
            fun gotoPermission(context: Context) {
                val brand = Build.BRAND//手机厂商
                if (TextUtils.equals(
                        brand.toLowerCase(),
                        "redmi"
                    ) || TextUtils.equals(brand.toLowerCase(), "xiaomi")
                ) {
                    gotoMiuiPermission(
                        context
                    )//小米
                } else if (TextUtils.equals(brand.toLowerCase(), "meizu")) {
                    gotoMeizuPermission(
                        context
                    )
                } else if (TextUtils.equals(
                        brand.toLowerCase(),
                        "huawei"
                    ) || TextUtils.equals(brand.toLowerCase(), "honor")
                ) {
                    gotoHuaweiPermission(
                        context
                    )
                } else {
                    context.startActivity(
                        getAppDetailSettingIntent(
                            context
                        )
                    )
                }
            }


            /**
            * 跳转到miui的权限管理页面
            */
            private fun gotoMiuiPermission(context: Context) {
                try { // MIUI 8
                    val localIntent = Intent("miui.intent.action.APP_PERM_EDITOR")
                    localIntent.setClassName(
                        "com.miui.securitycenter",
                        "com.miui.permcenter.permissions.PermissionsEditorActivity"
                    )
                    localIntent.putExtra("extra_pkgname", context.getPackageName())
                    context.startActivity(localIntent)
                } catch (e: Exception) {
                    try { // MIUI 5/6/7
                        val localIntent = Intent("miui.intent.action.APP_PERM_EDITOR")
                        localIntent.setClassName(
                            "com.miui.securitycenter",
                            "com.miui.permcenter.permissions.AppPermissionsEditorActivity"
                        )
                        localIntent.putExtra("extra_pkgname", context.getPackageName())
                        context.startActivity(localIntent)
                    } catch (e1: Exception) { // 否则跳转到应用详情
                        context.startActivity(
                            getAppDetailSettingIntent(
                                context
                            )
                        )
                    }

                }

            }

            /**
            * 跳转到魅族的权限管理系统
            */
            private fun gotoMeizuPermission(context: Context) {
                try {
                    val intent = Intent("com.meizu.safe.security.SHOW_APPSEC")
                    intent.addCategory(Intent.CATEGORY_DEFAULT)
                    intent.putExtra("packageName", context.packageName)
                    context.startActivity(intent)
                } catch (e: Exception) {
                    e.printStackTrace()
                    context.startActivity(
                        getAppDetailSettingIntent(
                            context
                        )
                    )
                }

            }

            /**
            * 华为的权限管理页面
            */
            private fun gotoHuaweiPermission(context: Context) {
                try {
                    val intent = Intent()
                    intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                    val comp = ComponentName(
                        "com.huawei.systemmanager",
                        "com.huawei.permissionmanager.ui.MainActivity"
                    )//华为权限管理
                    intent.component = comp
                    context.startActivity(intent)
                } catch (e: Exception) {
                    e.printStackTrace()
                    context.startActivity(
                        getAppDetailSettingIntent(
                            context
                        )
                    )
                }

            }

            /**
            * 获取应用详情页面intent（如果找不到要跳转的界面，也可以先把用户引导到系统设置页面）
            */
            private fun getAppDetailSettingIntent(context: Context): Intent {
                val localIntent = Intent()
                localIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                localIntent.action = "android.settings.APPLICATION_DETAILS_SETTINGS"
                localIntent.data = Uri.fromParts("package", context.getPackageName(), null)

                return localIntent
            }
        }
    }
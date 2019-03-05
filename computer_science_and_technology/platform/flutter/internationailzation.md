---
layout: page
permalink: ./technology-home/platform/flutter/internationalization
---

## Internationalization
默认flutter只支持US语言，需要支持其他语言需要配置`flutter_localizations`，这个库支持25种语言:

    dependencies:
        flutter:
            sdk: flutter
        flutter_localizations:
            sdk: flutter

    // 使用
    import 'package:flutter_localizations/flutter_localizations.dart';

    MaterialApp(
        localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate, 
        ],
        supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale('he', 'IL'), // Hebrew
            // ... other locales the app supports
        ],
        // ...
    )
```
如果使用WidgetsApp, 那么不需要GlobalMaterialLocalizations.delegate，而且需要在语言改变时使用当前Locale重建Widget
```

### 1. 判断本地语言

    Locale myLocale = Localizations.localeOf(context);

### 2. 加载和监听本地语言
1. Localizations Widget 使用Localizations.of(context,type) 加载和监听本地语言 同InheritedWidget
2. Localizations Widget 使用LocalizationsDelegate加载本地语言
3. Flutter内置`MaterialLocalizations`和`WidgetsLocalizations`，只支持英文
4. 需要实现`DefaultMaterialLocalizations`和`DefaultWidgetsLocalizations`
5. `flutter_localizations`包的`GlobalMaterialLocalizations`和`GlobalWidgetsLocalizations`支持24种语言

### 3. 实现

#### 3.1. 定义Localizations，本地语言源
* 接收一个`Locale`
* 实现`of`函数，简化获取`Localiztions`
* 定义多种语言的值`_localizedValues`
* 定义`get`函数，简化获取`title`

    class DemoLocalizations {
        DemoLocalizations(this.locale);

        final Locale locale;

        static DemoLocalizations of(BuildContext context) {
            return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
        }

        static Map<String, Map<String, String>> _localizedValues = {
            'en': {
            'title': 'Hello World',
            },
            'es': {
            'title': 'Hola Mundo',
            },
        };

        String get title {
            return _localizedValues[locale.languageCode]['title'];
        }
    }

#### 3.2. LocalizationsDelegate
* 继承`LocalizationsDelegate`, 指定类型自定义类`DemoLocalizations`
* `isSupported`，指定支持的语言
* `load`，加载本地语言源
* `shouldReload`，如果需要重新调用`load`，就返回true

    class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
        const DemoLocalizationsDelegate();

        @override
        bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

        @override
        Future<DemoLocalizations> load(Locale locale) {
            // Returning a SynchronousFuture here because an async "load" operation
            // isn't needed to produce an instance of DemoLocalizations.
            return SynchronousFuture<DemoLocalizations>(DemoLocalizations(locale));
        }

        @override
        bool shouldReload(DemoLocalizationsDelegate old) => false;
    }

#### 3.3. 配置

    class Demo extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
            return MaterialApp(
            onGenerateTitle: (BuildContext context) => DemoLocalizations.of(context).title,
            localizationsDelegates: [
                const DemoLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
                const Locale('en', ''),
                const Locale('es', ''),
            ],
            // Watch out: MaterialApp creates a Localizations widget
            // with the specified delegates. DemoLocalizations.of()
            // will only find the app's Localizations widget if its
            // context is a child of the app.
            home: DemoApp(),
            );
        }
    }

#### 3.4. 使用

    Text(DemoLocalizations.of(context).title)

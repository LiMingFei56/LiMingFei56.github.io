---
layout: post
title: Tabbar andd PageView
categories: flutter
tags: [flutter]
date: 2023-10-20
---

## Tabbar andd PageView

    import 'package:flutter/material.dart';

    void main() {
      runApp(MyApp());
    }

    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: MyTabbedPage(),
        );
      }
    }

    class MyTabbedPage extends StatefulWidget {
      @override
      _MyTabbedPageState createState() => _MyTabbedPageState();
    }

    class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {
      TabController _tabController;
      PageController _pageController;

      bool istabchange = false;
      bool istimeout = false;

      @override
      void initState() {
        super.initState();
        _tabController = TabController(length: 3, vsync: this);
        _pageController = PageController(initialPage: 0);

        _tabController.addListener(() {
          // Listen to tab changes and set the page accordingly
        istimeout = true;
          _pageController.animateToPage(
            _tabController.index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });

        _pageController.addListener(() {
         // 解决冲突
         if (istabchange) {
            if (!istimeout) {
                istimeout = true;
                Future.delayed(Duration(milliseconds: 300), () {
                    istabchange = false;
                    istimeout = false;
                });
            }        
            return;
          }
          // Listen to page changes and set the selected tab accordingly
          _tabController.index = _pageController.page.round();
        });
      }

      @override
      void dispose() {
        _tabController.dispose();
        _pageController.dispose();
        super.dispose();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Tab Bar Example'),
          ),
          body: Column(
            children: <Widget>[
              TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    Container(color: Colors.red),
                    Container(color: Colors.green),
                    Container(color: Colors.blue),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }


## Reference

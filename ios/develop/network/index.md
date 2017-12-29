---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /ios/develop/network
---

Network

iOS9添加了新特性:App Transport Security(ATS)，需要在Info.plist中添加配置:
`NSAppTransportSecurity`类型`Dictionary`
item `NSAllowsArbitraryLoads`设置为`YES`

* [URL Session](./network/url-session)

---
layout: page
permalink: /operate-system/macos/uploadIosApp
---

Upload Ios APP

### Error

1. Error ITMS-90717: "Invalid App Store Icon. The App Store Icon in the asset catalog in 'YourApp.app' can't be transparent nor contain an alpha channel."

    brew install imagemagick
    find ./resources/ -name "*.png" -exec convert "{}" -alpha off "{}" \;

    [见](https://stackoverflow.com/questions/46585809/error-itms-90717-invalid-app-store-icon)

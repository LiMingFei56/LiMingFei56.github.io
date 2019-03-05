---
layout: page
permalink: ./technology-home/platform/flutter/performance
---

## Performance

### 1. 思考在哪调用setState()


### 2. 避免调用saveLayer()

* Opacity
* Clipping(不会调用saveLayer)，但还是慢
* ShaderMask
* ColorFilter
* Chip—may cause call to saveLayer() if disabledColorAlpha != 0xff
* Text—may cause call to saveLayer() if there’s an overflowShader

### 3. 懒加载

### 4. 60fps-16ms 120fp-8ms

构建和渲染是两小线程，所以是分别16ms


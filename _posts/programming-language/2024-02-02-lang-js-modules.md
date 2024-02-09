---
layout: post
title: JS modules
categories: lang
tags: [lang]
date: 2024-02-01
---

## JS modules

### basic-modules

    index.html
    main.js
    modules/
        canvas.js
        square.js

### Exporting module features

> export statement
> can export functions, var, let, const, class. need top-level

    export { name, draw, reportArea, reportPerimeter };

### Importing features into your script

    import { name, draw, reportArea, reportPerimeter } from "./modules/square.js";

    // Importing modules using import maps
    import { name as squareName, draw } from "./shapes/square.js";
    import { name as circleName } from "https://example.com/shapes/circle.js";

    <script type="importmap">
      {
        "imports": {
          "shapes": "./shapes/square.js",
          "shapes/square": "./modules/shapes/square.js",
          "https://example.com/shapes/square.js": "./shapes/square.js",
          "https://example.com/shapes/": "/shapes/square/",
          "../shapes/square": "./shapes/square.js"
        }
      }
    </script>

    // Bare module names as module specifiers
    import { name as squareNameOne } from "shapes";
    import { name as squareNameTwo } from "shapes/square";

    // Remap a URL to another URL
    import { name as squareNameThree } from "https://example.com/shapes/square.js";


### Packages of modules

    {
      "imports": {
        "lodash": "/node_modules/lodash-es/lodash.js",
        "lodash/": "/node_modules/lodash-es/"
      }
    }

    import _ from "lodash";
    import fp from "lodash/fp.js";

### General URL remapping

    {
      "imports": {
        "https://www.unpkg.com/moment/": "/node_modules/moment/"
      }
    }

### Scoped modules for version management

    {
      "imports": {
        "coolmodule": "/node_modules/coolmodule/index.js"
      },
      "scopes": {
        "/node_modules/dependency/": {
          "coolmodule": "/node_modules/some/other/location/coolmodule/index.js"
        }
      }
    }

    // Improve caching by mapping away hashed filenames
    {
      "imports": {
        "main_script": "/node/srcs/application-fg7744e1b.js",
        "dependency_script": "/node/srcs/dependency-3qn7e4b1q.js"
      }
    }


### Applying the module to your HTML

    <script type="module" src="main.js"></script>


> Other differences between modules and standard scripts
    
   * You need to pay attention to local testing — if you try to load the HTML file locally (i.e. with a file:// URL), you'll run into CORS errors due to JavaScript module security requirements. You need to do your testing through a server.
   * Also, note that you might get different behavior from sections of script defined inside modules as opposed to in standard scripts. This is because modules use strict mode automatically.
   * There is no need to use the defer attribute (see <script> attributes) when loading a module script; modules are deferred automatically.
   * Modules are only executed once, even if they have been referenced in multiple <script> tags.
   * Last but not least, let's make this clear — module features are imported into the scope of a single script — they aren't available in the global scope. Therefore, you will only be able to access imported features in the script they are imported into, and you won't be able to access them from the JavaScript console, for example. You'll still get syntax errors shown in the DevTools, but you'll not be able to use some of the debugging techniques you might have expected to use.

### Default exports versus named exports

> only one default export allowed per module

    export default randomSquare;

    export default function (ctx) {
      // …
    }

    import randomSquare from "./modules/square.js";

    import { default as randomSquare } from "./modules/square.js";

### Avoiding naming conflicts

#### Renaming imports and exports

    // inside module.js
    export { function1 as newFunctionName, function2 as anotherNewFunctionName };

    // inside main.js
    import { newFunctionName, anotherNewFunctionName } from "./modules/module.js";

    // inside module.js
    export { function1, function2 };

    // inside main.js
    import {
      function1 as newFunctionName,
      function2 as anotherNewFunctionName,
    } from "./modules/module.js";

#### Creating a module object

    import * as Module from "./modules/module.js";

    export { name, draw, reportArea, reportPerimeter };

    import * as Canvas from "./modules/canvas.js";

    import * as Square from "./modules/square.js";
    import * as Circle from "./modules/circle.js";
    import * as Triangle from "./modules/triangle.js";

#### Modules and classes

    class Square
    export { Square };

    import { Square } from "./modules/square.js";

#### Aggregating modules

    modules/
      canvas.js
      shapes.js
      shapes/
        circle.js
        square.js
        triangle.js

    shapes.js

    export { Square } from "./shapes/square.js";
    export { Triangle } from "./shapes/triangle.js";
    export { Circle } from "./shapes/circle.js";

    import { Square, Circle, Triangle } from "./modules/shapes.js";

#### Dynamic module loading

    import("./modules/myModule.js").then((module) => {
      // Do something with the module.
    });


    





## Reference
+ [JavaScript modules](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules)

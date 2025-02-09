---
layout: post
title: Python packages
categories: python
tags: [python]
date: 2024-07-29
---

## Python packages

### Bast Python project dir structure

    project_root/
    my_project/
        __init__.py
        main.py
        config.py
        utils/
            __init__.py
            helper.py
        features/
            __init__.py
            feature_a/
                __init__.py
                module1.py
                module2.py
            feature_b/
                __init__.py
                module3.py
                module4.py
        namespace_packages/
            pkg1/
                my_namespace/
                    moduleA.py
            pkg2/
                my_namespace/
                    moduleB.py
    tests/
        test_main.py
        test_utils/
            test_helper.py
        test_features/
            test_feature_a/
                test_module1.py
                test_module2.py
            test_feature_b/
                test_module3.py
                test_module4.py
    docs/
    setup.py
    requirements.txt
    README.md



## Reference

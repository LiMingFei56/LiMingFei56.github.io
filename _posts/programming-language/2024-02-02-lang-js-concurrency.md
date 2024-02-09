---
layout: post
title: JS Concurrency
categories: lang
tags: [lang]
date: 2024-02-01
---

## JS Concurrency


    Making HTTP requests using fetch()
    Accessing a user's camera or microphone using getUserMedia()
    Asking a user to select files using showOpenFilePicker()

### Promises

    let promise = new Promise(function(resolve, reject) {
      resolve("done");

      reject(new Error("…")); // ignored
      setTimeout(() => resolve("…")); // ignored
    });

    new Promise((resolve, reject) => {
      /* do something that takes time, and then call resolve or maybe reject */
    })
    // runs when the promise is settled, doesn't matter successfully or not
    .finally(() => stop loading indicator)
    // so the loading indicator is always stopped before we go on
    .then(result => show result, err => show error)
    .catch(err => alert(err));  // <-- .catch shows the error





## Reference
+ [Concurrency model and Event Loop](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Event_loop)
+ [Asynchronous JavaScript](https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Asynchronous)
+ [Promises, async/await](https://javascript.info/async)

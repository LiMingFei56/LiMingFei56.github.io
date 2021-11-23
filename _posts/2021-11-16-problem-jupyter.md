---
layout: post
title: "Jupyer Error"
categories: problem
tags: [problem]
date: 2021-11-16
---

## Jupyer Error

### No module named 'jupytext'

		python3 -m pip install jupytext

### Jupyter Notebook : ERROR:asyncio:Exception in callback

		jupyter notebook --generate-config
		vim ~/.jupyter/jupyter_notebook_config.py
		# add
		c.NotebookApp.kernel_manager_class = 'notebook.services.kernels.kernelmanager.AsyncMappingKernelManager'


### Reference
[Jupyter Notebook : ERROR:asyncio:Exception in callback](https://stackoverflow.com/questions/68963183/jupyter-notebook-errorasyncioexception-in-callback)

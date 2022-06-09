---
layout: post
title: "TKinter"
categories: gui
tags: [gui]
date: 2022-04-20
---

## TKinter

### 1. TkConcepts

1. Tkinter屏幕上都是Widgets
2. Widgets 也被称为Controls 或者 Windows
3. hierarchy 由Widgets组成, 可以有任意深度, 主Widgets叫root节点
4. 除了root, 实例化其他Widgets需要传父母节点
5. tk会维护hierarchy结构, 每个Widgets有*pathname*字段用来保存结构, 通用str(widget)来获取pathname

### 2. Configuration options

	>>> from tkinter import *
	>>> from tkinter import ttk
	>>> root = Tk()
	create a button, passing two options:
	>>> button = ttk.Button(root, text="Hello", command="buttonpressed")
	>>> button.grid()
	check the current value of the text option:
	>>> button['text']
	'Hello'
	change the value of the text option:
	>>> button['text'] = 'goodbye'
	another way to do the same thing:
	>>> button.configure(text='goodbye')
	check the current value of the text option:
	>>> button['text']
	'goodbye'
	get all information about the text option:
	>>> button.configure('text')
	('text', 'text', 'Text', '', 'goodbye')
	get information on all options for this widget:
	>>> button.configure()
	{'cursor': ('cursor', 'cursor', 'Cursor', '', ''), 'style': ('style', 'style', 'Style', '', ''), 
	'default': ('default', 'default', 'Default', <index object at 0x00DFFD10>, <index object at 0x00DFFD10>), 
	'text': ('text', 'text', 'Text', '', 'goodbye'), 'image': ('image', 'image', 'Image', '', ''), 
	'class': ('class', '', '', '', ''), 'padding': ('padding', 'padding', 'Pad', '', ''), 
	'width': ('width', 'width', 'Width', '', ''), 
	'state': ('state', 'state', 'State', <index object at 0x0167FA20>, <index object at 0x0167FA20>), 
	'command': ('command', 'command' , 'Command', '', 'buttonpressed'), 
	'textvariable': ('textvariable', 'textVariable', 'Variable', '', ''), 
	'compound': ('compound', 'compound', 'Compound', <index object at 0x0167FA08>, <index object at 0x0167FA08>), 
	'underline': ('underline', 'underline', 'Underline', -1, -1), 
	'takefocus': ('takefocus', 'takeFocus', 'TakeFocus', '', 'ttk::takefocus')}

### 3. Widget Introspection

	def print_hierarchy(w, depth=0):
	print('  '*depth + w.winfo_class() + ' w=' + str(w.winfo_width()) + ' h=' + str(w.winfo_height()) + ' x=' + str(w.winfo_x()) + ' y=' + str(w.winfo_y()))
	for i in w.winfo_children():
			print_hierarchy(i, depth+1)

	print_hierarchy(root)

* winfo_class: a class identifying the type of widget, e.g., TButton for a themed button
* winfo_children: a list of widgets that are the direct children of a widget in the hierarchy
* winfo_parent: parent of the widget in the hierarchy
* winfo_toplevel: the toplevel window containing this widget
* winfo_width, winfo_height: current width and height of the widget; not accurate until it appears onscreen
* winfo_reqwidth, winfo_reqheight: the width and height that the widget requests of the geometry manager (more on this shortly)
* winfo_x, winfo_y: the position of the top-left corner of the widget relative to its parent
* winfo_rootx, winfo_rooty: the position of the top-left corner of the widget relative to the entire screen
* winfo_vieweable: whether the widget is displayed or hidden (all its ancestors in the hierarchy must be viewable for it to be viewable)

### 4. Geometry Management

> The widgets may have a natural size, e.g., the natural width of a label would depend on the text it displays and the font used to display it. What if the application window containing all these different widgets isn't big enough to accommodate them? The geometry manager must decide which widgets to shrink to fit, by how much, etc.
> If the application window is bigger than the natural size of all the widgets, how is the extra space used? Is extra space placed between each widget, and if so, how is that space distributed? Is it used to make certain widgets larger than they usually are, such as a text entry growing to fill a wider window? Which widgets should grow?
> If the application window is resized, how does the size and position of each widget inside it change? Will certain areas (e.g., a text entry area) expand or shrink while other parts stay the same size, or is the area distributed differently? Do certain widgets have a minimum size that you want to avoid going below? A maximum size? Does the window itself have a minimum or maximum size?
> How can widgets in different parts of the user interface be aligned with each other? How much space should be left between them? This is needed to present a clean layout and comply with platform-specific user interface guidelines.
> For a complex user interface, which may have many frames nested in other frames nested in the window (etc.), how can all the above be accomplished, trading off the conflicting demands of different parts of the entire user interface?

#### 4.1 grid
> 指定把widget放到哪一列, 哪一行, 怎么对齐

### 5. Binding To Events

	from tkinter import *
	from tkinter import ttk
	root = Tk()
	l =ttk.Label(root, text="Starting...")
	l.grid()
	l.bind('<Enter>', lambda e: l.configure(text='Moved mouse inside'))
	l.bind('<Leave>', lambda e: l.configure(text='Moved mouse outside'))
	l.bind('<ButtonPress-1>', lambda e: l.configure(text='Clicked left mouse button'))
	l.bind('<3>', lambda e: l.configure(text='Clicked right mouse button'))
	l.bind('<Double-1>', lambda e: l.configure(text='Double clicked'))
	l.bind('<B3-Motion>', lambda e: l.configure(text='right button drag to %d,%d' % (e.x, e.y)))
	root.mainloop()

### 6. Available Events

* <Activate>: Window has become active.
* <Deactivate>: Window has been deactivated.
* <MouseWheel>: Scroll wheel on mouse has been moved.
* <KeyPress>: Key on keyboard has been pressed down.
* <KeyRelease>: Key has been released.
* <ButtonPress>: A mouse button has been pressed.
* <ButtonRelease>: A mouse button has been released.
* <Motion>: Mouse has been moved.
* <Configure>: Widget has changed size or position.
* <Destroy>: Widget is being destroyed.
* <FocusIn>: Widget has been given keyboard focus.
* <FocusOut>: Widget has lost keyboard focus.
* <Enter>: Mouse pointer enters widget.
* <Leave>: Mouse pointer leaves widget.

### 7. Virtual Events

> 使用'<<foo>>' 表示

	root.event_generate("<<foo>>")

### Reference
[TkDocs](https://tkdocs.com/index.html)  
[Tcl8.6.12](https://tcl.tk/man/tcl8.6/contents.htm)  

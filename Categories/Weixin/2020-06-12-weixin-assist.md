## 微信-辅助
source: `{{ page.path }}`

### 1. 分享到朋友圈

使用微信sdk只能发送一张图片:

    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;//分享内容带图片和文字时必须为NO
    UIImage *image = [UIImage imageNamed:@"opinion"];
  
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = [NSData dataWithContentsOfURL:url];

    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:image];
    message.mediaObject = imageObject;
    //如果分享的内容包括文字和,这个时候的文字不能使用req.text属性来接收,必须使用下边的两个属性
    message.title = @"title";
    message.description = @"description";
    req.message = message;
   req.scene = WXSceneSession;//好友
   //req.scene = WXSceneTimeline;//朋友圈

    [WXApi sendReq:req];

    /**
	 * 分享功能
	 *
	 * @param context
	 *            上下文
	 * @param activityTitle
	 *            Activity的名字
	 * @param msgTitle
	 *            消息标题
	 * @param msgText
	 *            消息内容
	 * @param imgPath
	 *            图片路径，不分享图片则传null
	 */
	public void shareMsg(String activityTitle, String msgTitle, String msgText,
			String imgPath) {
		Intent intent = new Intent(Intent.ACTION_SEND);
		if (imgPath == null || imgPath.equals("")) {
			intent.setType("text/plain"); // 纯文本
		} else {
			File f = new File(imgPath);
			if (f != null && f.exists() && f.isFile()) {
				intent.setType("image/jpg");
				Uri u = Uri.fromFile(f);
				intent.putExtra(Intent.EXTRA_STREAM, u);
			}
		}
		intent.putExtra(Intent.EXTRA_SUBJECT, msgTitle);
		intent.putExtra(Intent.EXTRA_TEXT, msgText);
		intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
		startActivity(Intent.createChooser(intent, activityTitle));
	}

发送多张图片:

    UIImage *image1 = [UIImage imageNamed:@"opinion"];
    UIImage *image2 = [UIImage imageNamed:@"current_1"];
    
    NSArray *activityItems = @[image1,image2];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:TRUE completion:nil];

    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
           
        }else{
            
        }
    };


> 上面发送多张图片, 是微信iOS APP实现的统一分享功能, 如果在Android就只能发送一张图片  
> 如果需要发送多个媒体文件, 需要使用`AccessibilityService`, 发送朋友图后, 程序手动选择  
> 媒体.

### 2. 收藏另人的朋友圈, 自动发送自己的朋友圈

* 使用root + xposed
* 使用微信ipad协议, 这个是第三方破解微信协议, 容易被封号

## Reference
[iPAD协议](http://wechat.qeapi.com/Index)

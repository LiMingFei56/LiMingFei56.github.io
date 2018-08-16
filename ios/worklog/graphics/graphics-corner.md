---
layout: page
permalink: /ios/worklog/graphics/graphics-corner
---

## 设置圆角

    // 全圆角
    btn.layer.cornerRadius = 5;

    // 一部分圆角
    NSInteger type = (UIRectCornerTopLeft | UIRectCornerBottomLeft) ;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:type cornerRadii:CGSizeMake(10, 10)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    注：需要在viewDidAppear方法中画，不然view的宽度不对

    // 内凹圆角
    UIBezierPath *leftPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, y) radius:10 startAngle:M_PI/180 * 270 endAngle:M_PI/180 * 90 clockwise:YES];
    [leftPath addLineToPoint:CGPointMake(0, y)]; // 需要连接中心点，才能画扇形
    CAShapeLayer *leftLayer = [[CAShapeLayer alloc] init];
    leftLayer.path = leftPath.CGPath;
    leftLayer.fillColor = [UIColor colorWithHexString:@"#f5f5f5"].CGColor;
    [view.layer addSublayer:leftLayer];
    注：需要在viewDidAppear方法中画，不然view的宽度不对
        横竖屏切换时要把原来的Layer删除，不然都会存在


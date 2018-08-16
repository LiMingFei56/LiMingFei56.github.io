---
layout: page
permalink: /ios/worklog/controller/cell
---

## Cell

1. xib里同级层只能有一个对象，如果在xib中添加一个TapGesture，那么会报错。只能在Cell.m中
    代码添加TapGesTure

2. 使用前需要注册Cell

     [self.tableView registerNib:[UINib nibWithNibName: @"CarManagerItemCellTableViewCell" bundle: nil] forCellReuseIdentifier:@"CarManagerTableCell" ];

3. (UITableViewCell *)getCarManagerCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{中使用

    CarManagerItemCellTableViewCell *cell = (CarManagerItemCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CarManagerTableCell"];

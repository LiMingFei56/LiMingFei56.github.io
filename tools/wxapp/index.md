---
# You don't need to edit this file, it's empty on purpose.
# Edit theme's home layout instead if you wanna make some changes
# See: https://jekyllrb.com/docs/themes/#overriding-theme-defaults
layout: page
permalink: /tools/wxapp
---

### 字符编码问题
    打印机使用GB18030编码，小程序使用utf-16编码，GB18030中ASCII字符是占一位
    ，所以有时候byte数组为单数，转成utf-16,会带错误信息(-1,-3结尾)，因此需要加入占位
    符编码(这里是使用"$$$")，到小程序时需要解码并去除占位符

    // java编码
    public String strToGB18030(String str) {
		if (str == null || "".equals(str)) {
			return "";
		}

		try {
			String result = new String(str.getBytes("GB18030"), "UTF-16");
			byte[] resultByte = result.getBytes("UTF-16");
			if (resultByte[resultByte.length - 2] == -1 && resultByte[resultByte.length - 1] == -3) {
				str += "$$$";
				result = new String(str.getBytes("GB18030"), "UTF-16");
			}
			return result;
		} catch (UnsupportedEncodingException e) {
			System.out.println(e.toString());
			System.out.println(str);
		}
		return null;
	}

    // 小程序解码
    var lastOneChar = str.charCodeAt(str.length - 1)
    var lastTwoChar = str.charCodeAt(str.length - 2)
    if (lastOneChar == 9252 && (lastTwoChar & 0x00FF) == 36) {
      str = str.substr(0, str.length - 2)
    }
    for (var i = 0, strlen = str.length; i < strlen; i++) {
      var data = str.charCodeAt(i)
      this.dataView.setUint16(this._offset, data, false)
      this._offset += 2
    }
    if (lastOneChar == 9252 && (lastTwoChar & 0x00FF) == 36) {
      this.setUInt8(lastTwoChar >> 8);
    }


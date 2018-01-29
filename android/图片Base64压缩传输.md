## 图片Base64+压缩

Base64是为了传输而使用的

传输先压缩再Base64

接收先Base64再解压

图片不能直接转字符串,因为utf-8是可变长度的.转过来,转不回来

	public String compress(byte[] imageByte) {
        String result = null;
        try {
            byte[] b = imageByte;
            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            GZIPOutputStream gzip = new GZIPOutputStream(bos);
            gzip.write(b);
            gzip.finish();
            gzip.close();
            b = bos.toByteArray();
            bos.close();
            result = Base64.encodeToString(b, Base64.DEFAULT);
        } catch (Exception e) {
        }
        return result;
    }

    public byte[] decompression(String imageStr) {
        byte[] result = null;
        try {
            ByteArrayInputStream bis = new ByteArrayInputStream(Base64.decode(imageStr.getBytes("UTF-8"), Base64.DEFAULT));
            GZIPInputStream gzip = new GZIPInputStream(bis);
            byte[] buf = new byte[1024];

            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            int num;
            while ((num = gzip.read(buf, 0, buf.length)) != -1) {
                baos.write(buf, 0, num);
            }

            byte[] b = baos.toByteArray();
            baos.flush();
            baos.close();
            gzip.close();
            bis.close();
            result = b;
        } catch (Exception e) {
        }
        return result;
    }

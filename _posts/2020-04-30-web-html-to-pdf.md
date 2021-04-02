---
layout: post
title: "Java html转pdf"
categories: java
tags: [java]
date: 2020-04-30
---

## Java itext

### html转pdf

### 1. 代码

    	<!--pdf-->
		<dependency>
			<groupId>org.xhtmlrenderer</groupId>
			<artifactId>core-renderer</artifactId>
			<version>R8</version>
		</dependency>
		<dependency>
			<groupId>commons-codec</groupId>
			<artifactId>commons-codec</artifactId>
		</dependency>
		
		<dependency>
			<groupId>com.itextpdf</groupId>
			<artifactId>itextpdf</artifactId>
			<version>5.5.1</version>
		</dependency>
		<dependency>
			<groupId>com.itextpdf.tool</groupId>
			<artifactId>xmlworker</artifactId>
			<version>5.5.9</version>
		</dependency>

    public static byte[] htmlToPdfByBytes(String html) {
        byte[] result = null;
        ByteArrayInputStream input = null;
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            input = new ByteArrayInputStream(html.getBytes("UTF-8"));

            ITextRenderer renderer = new ITextRenderer();
            InputSource is = new InputSource(new BufferedReader(new InputStreamReader(input)));
            Document dom = XMLResource.load(is).getDocument();
            renderer.setDocument(dom, null);

            ITextFontResolver fontResolver = renderer.getFontResolver();
            String fontPath1 = PdfUtils.class.getResource("/fonts/simsun.ttf").getPath();
            String fontPath2 = PdfUtils.class.getResource("/fonts/simsun.ttc").getPath();
            fontResolver.addFont(fontPath1, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            fontResolver.addFont(fontPath2, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);

            renderer.layout();
            renderer.createPDF(os);
            result = os.toByteArray();
        } catch (Exception e) {
            logger.error("htmlToPdfByBytes", e);
        } finally {
            try {
                os.close();
            } catch (IOException e) {
            }
            try {
                if (input != null) {
                    input.close();
                }
            } catch (Exception e) {
                //TODO: handle exception
            }
        }
        return result;
    }

## 2. 中文不显示问题

### 1. 字体

> 需要使用中文字体, 这里使用微软宋体. 
> html转pdf中, fontResolver.addFont  加载字体
> html中, body 需要指定使用的字体, <body style=\"font-size:12.0pt; font-family:SimSun;\">
> 注意字体名称(不是字体文件名), 

### 2. 编码

> 读html 写pdf的编码需要统一

### 3. html要求

> 需要遵守严格的html规范(每个标签必须闭合), 样式最好写到Html 标签里
> XHTML 定义不是必须的, 这样写为了以防万一

> html中`&`转义字符, 需要手动转义

    sb.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n");
    sb.append("<html lang=\"zh\" xmlns=\"http://www.w3.org/1999/xhtml\">\n");

    sb.append("<body style=\"font-size:12.0pt; font-family:SimSun;\">\n");
    sb.append("<p>你好</p>");
    sb.append("</body>\n");
    sb.append("</html>\n");

### PNG 转 PDF

你没有真正将png转换为pdf,但创建了一个带有png的pdf.
    Document document = new Document(PageSize.A4, 20, 20, 20, 20);
    PdfWriter.getInstance(document, new FileOutputStream("C:/test.pdf"));
    document.open();
    Image image = Image.getInstance(getClass().getResource("/logo.png"));
    document.add(image);
    document.close();

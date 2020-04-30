---
layout: post
title: "web 上传及下载文件"
categories: web
tags: [java]
date: 2020-04-30
excerpt: "web 上传及下载文件"
---

## web 上传及下载文件

### 1. 下载文件

#### 1. Controller

    @RequestMapping(value = "/t20/reportDownload", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reportDownload(HttpServletRequest request, HttpServletResponse response) {
		return t20Service.reportDownload(request, response);	
	}


#### 2. Response

    response.setHeader("content-type", "application/octet-stream");
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
    response.getOutputStream().write(pdfbytes);
    response.getOutputStream().flush();
    return "successfully";

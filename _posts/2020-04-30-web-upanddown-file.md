---
layout: post
title: "Javaweb 上传及下载文件"
categories: javaweb
tags: [javaweb]
date: 2020-04-30
---

## Javaweb 上传及下载文件

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

#### 3. 前端

> 不能使用ajax, 因为它返回的是字符格式, 有时候不弹出下载框

    $.ajax({
       url:"/down/downExcel",
       type:"GET",
       dataType:"json",
       success:function(result){
    }});

    使用 window.location.href="/down/downExcel";

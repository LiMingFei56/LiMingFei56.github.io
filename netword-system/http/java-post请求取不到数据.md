---
layout: page
permalink: /netword-system/http/java-post-getparameter
---

#### JAVA-post请求取不到数据

    JS 端

     $.ajax({
        type:‘POST‘,
        data:{a:1},
        url:_this.apiUrl+url,
        dataType:‘json‘,//使用jsonp方式请求
        contentType:"application/json; charset=utf-8",
        json:"callback",//jsonp名
        success:function(re){
    
        }
    });

    java 端取不到数据
        
    @PostMapping(value = "/queryProduct")
    public Map<String,Object> queryProduct(HttpServletRequest request, HttpServletResponse response){
        String tmPlantId = request.getParameter("a");
    }

但是JAVA中换成 

    @PostMapping(value = "/queryProduct")
    public Map<String,Object> queryProduct(@RequestBody String a, HttpServletResponse response){
       System.out.println(a);        
    }

就可以取到数据

或者把ajax的

    contentType:"application/json; charset=utf-8", 换成  contentType:"application/x-www-form-urlencoded; charset=UTF-8"
    , 通过request.getParamater("a") 也是可以获取到值的。

问题出在contentType类型

普通情况下 ，java 是没有对请求参数做处理的， 所有参数都是放到输入流中的，即inputstream
但是tomcat 对 content-type  =  application/x-www.form-urlencoded  和 multipart/form-data
的 请求流做了处理，也就是我们常见的HttpServletRequest 对象。这两种请求方式是标准的表单请求
，也就是键值对的方式。尤其其他方式的请求参数的不固定性，所以只对这两个做了处理。即： 
对输入流处理，把参数按照键值对存放map 中，可以通过request.getParameter获取


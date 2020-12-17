## Http Authorization
source: `{{ page.path }}`


### Basic

`Authorization: Basic jdhaHY0=`

Authorization: http head  
Basic: 认证方式  
jdhaHY0=: user:passwd base64  

### Bearer token

使用Authorization Basic登陆后会拿到token  

`Authorization: Bearer ${token}`  

## Reference


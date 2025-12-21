---
title: VR地板
language_tabs:
  - shell: Shell
  - http: HTTP
  - javascript: JavaScript
  - ruby: Ruby
  - python: Python
  - php: PHP
  - java: Java
  - go: Go
toc_footers: []
includes: []
search: true
code_clipboard: true
highlight_theme: darkula
headingLevel: 2
generator: "@tarslib/widdershins v4.0.30"

---

# VR地板

Base URLs:

# Authentication

# 国际化测试控制器

## POST 测试默认成功响应（使用国际化）

POST /api/i18n/test-success

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试使用消息键的成功响应

POST /api/i18n/test-success-key

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试带参数的国际化消息

POST /api/i18n/test-success-params

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|username|query|string| 是 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试错误响应（使用国际化）

POST /api/i18n/test-error

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试参数错误响应

POST /api/i18n/test-bad-request

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试未找到响应

POST /api/i18n/test-not-found

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试未授权响应

POST /api/i18n/test-unauthorized

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试禁止访问响应

POST /api/i18n/test-forbidden

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 测试服务器内部错误响应

POST /api/i18n/test-internal-error

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

# 管理员控制器

## POST 管理员登录

POST /api/admin/login

> Body 请求参数

```json
{
  "username": "string",
  "password": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[AdminLoginDTO](#schemaadminlogindto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "username": "",
    "email": "",
    "realName": "",
    "phone": "",
    "status": 0,
    "isOnline": 0,
    "lastLoginTime": "",
    "loginIp": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseAdminVO](#schemaapiresponseadminvo)|

## POST 管理员退出登录

POST /api/admin/logout

> Body 请求参数

```json
{
  "username": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[AdminLogoutDTO](#schemaadminlogoutdto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

# 统计数据控制器

## POST 获取统计数据

POST /api/statistics/get

包含：用户平均会话时长、会话总时长、总客户数、平均沉浸式会话时间、
平均3D模型会话时间、正在活动用户数、最受关注产品、最喜爱产品、平均观看时长

> Body 请求参数

```json
{
  "startTime": "string",
  "endTime": "string",
  "dealerId": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[GetStatisticsRequest](#schemagetstatisticsrequest)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "avgSessionTime": 0,
    "totalSessionTime": 0,
    "totalCustomers": 0,
    "avgImmersiveSessionTime": 0,
    "avgModelSessionTime": 0,
    "activeUsers": 0,
    "mostViewedProducts": [
      {
        "productName": "",
        "count": 0
      }
    ],
    "mostFavoriteProducts": [
      {
        "productName": "",
        "count": 0
      }
    ],
    "avgWatchTime": 0
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseStatisticsResponse](#schemaapiresponsestatisticsresponse)|

## POST 获取统计数据（无参数版本，获取全部数据）

POST /api/statistics/get-all

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "avgSessionTime": 0,
    "totalSessionTime": 0,
    "totalCustomers": 0,
    "avgImmersiveSessionTime": 0,
    "avgModelSessionTime": 0,
    "activeUsers": 0,
    "mostViewedProducts": [
      {
        "productName": "",
        "count": 0
      }
    ],
    "mostFavoriteProducts": [
      {
        "productName": "",
        "count": 0
      }
    ],
    "avgWatchTime": 0
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseStatisticsResponse](#schemaapiresponsestatisticsresponse)|

# 用户埋点控制器

## POST 前端主动调用埋点接口

POST /api/user-track/record

> Body 请求参数

```json
{
  "userCode": "string",
  "eventName": "string",
  "trackData": "string",
  "pagePath": "string",
  "extraInfo": "string",
  "sessionTime": 0,
  "pageSessionTime": 0,
  "modelSessionTime": 0,
  "avgWatchTime": 0,
  "pageStayTime": 0,
  "modelViewTime": 0,
  "productName": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserTrackCreateDTO](#schemausertrackcreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": false,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseBoolean](#schemaapiresponseboolean)|

## POST 记录会话时间埋点

POST /api/user-track/record-session

> Body 请求参数

```json
{
  "userCode": "string",
  "eventName": "string",
  "trackData": "string",
  "pagePath": "string",
  "extraInfo": "string",
  "sessionTime": 0,
  "pageSessionTime": 0,
  "modelSessionTime": 0,
  "avgWatchTime": 0,
  "pageStayTime": 0,
  "modelViewTime": 0,
  "productName": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserTrackCreateDTO](#schemausertrackcreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": false,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseBoolean](#schemaapiresponseboolean)|

## POST 根据用户标识查询埋点记录

POST /api/user-track/list-by-user

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|userCode|query|string| 是 |用户标识|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "requestIp": "",
      "requestPath": "",
      "requestMethod": "",
      "requestParams": "",
      "responseStatus": 0,
      "userAgent": "",
      "trackType": "",
      "eventName": "",
      "trackData": "",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "",
      "deleted": 0,
      "createTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserTrack](#schemaapiresponselistusertrack)|

## POST 根据IP查询埋点记录

POST /api/user-track/list-by-ip

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|requestIp|query|string| 是 |请求IP|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "requestIp": "",
      "requestPath": "",
      "requestMethod": "",
      "requestParams": "",
      "responseStatus": 0,
      "userAgent": "",
      "trackType": "",
      "eventName": "",
      "trackData": "",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "",
      "deleted": 0,
      "createTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserTrack](#schemaapiresponselistusertrack)|

## POST 分页查询埋点记录

POST /api/user-track/page

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "requestIp": "string",
  "requestPath": "string",
  "requestMethod": "string",
  "trackType": "string",
  "eventName": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserTrackQueryDTO](#schemausertrackquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "total": 0,
    "list": [
      {
        "id": 0,
        "userId": 0,
        "userCode": "",
        "requestIp": "",
        "requestPath": "",
        "requestMethod": "",
        "requestParams": "",
        "responseStatus": 0,
        "userAgent": "",
        "trackType": "",
        "eventName": "",
        "trackData": "",
        "executionTime": 0,
        "sessionTime": 0,
        "pageSessionTime": 0,
        "modelSessionTime": 0,
        "avgWatchTime": 0,
        "pageStayTime": 0,
        "modelViewTime": 0,
        "productName": "",
        "deleted": 0,
        "createTime": ""
      }
    ],
    "pageNum": 0,
    "pageSize": 0,
    "size": 0,
    "startRow": 0,
    "endRow": 0,
    "pages": 0,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": false,
    "isLastPage": false,
    "hasPreviousPage": false,
    "hasNextPage": false,
    "navigatePages": 0,
    "navigatepageNums": [
      0
    ],
    "navigateFirstPage": 0,
    "navigateLastPage": 0
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponsePageInfoUserTrack](#schemaapiresponsepageinfousertrack)|

## POST 根据埋点类型查询记录

POST /api/user-track/list-by-type

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|trackType|query|string| 是 |埋点类型（AUTO/MANUAL）|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "requestIp": "",
      "requestPath": "",
      "requestMethod": "",
      "requestParams": "",
      "responseStatus": 0,
      "userAgent": "",
      "trackType": "",
      "eventName": "",
      "trackData": "",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "",
      "deleted": 0,
      "createTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserTrack](#schemaapiresponselistusertrack)|

## POST 根据时间范围查询埋点记录

POST /api/user-track/list-by-time

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|startTime|query|string| 是 |开始时间|
|endTime|query|string| 是 |结束时间|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "requestIp": "",
      "requestPath": "",
      "requestMethod": "",
      "requestParams": "",
      "responseStatus": 0,
      "userAgent": "",
      "trackType": "",
      "eventName": "",
      "trackData": "",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "",
      "deleted": 0,
      "createTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserTrack](#schemaapiresponselistusertrack)|

## POST 统计用户埋点总数

POST /api/user-track/count-by-user

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|userCode|query|string| 是 |用户标识|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": 0,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseLong](#schemaapiresponselong)|

## POST 统计IP埋点总数

POST /api/user-track/count-by-ip

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|requestIp|query|string| 是 |请求IP|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": 0,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseLong](#schemaapiresponselong)|

## POST 获取当前请求的IP地址（调试用）

POST /api/user-track/get-client-ip

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 获取会话时间统计

POST /api/user-track/session-stats

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "requestIp": "string",
  "requestPath": "string",
  "requestMethod": "string",
  "trackType": "string",
  "eventName": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserTrackQueryDTO](#schemausertrackquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "": {}
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListMapObject](#schemaapiresponselistmapobject)|

## POST 根据商品名称查询埋点记录

POST /api/user-track/list-by-product

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|productName|query|string| 是 |商品名称|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "requestIp": "",
      "requestPath": "",
      "requestMethod": "",
      "requestParams": "",
      "responseStatus": 0,
      "userAgent": "",
      "trackType": "",
      "eventName": "",
      "trackData": "",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "",
      "deleted": 0,
      "createTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserTrack](#schemaapiresponselistusertrack)|

# 用户收藏控制器

## POST 添加收藏

POST /api/user-favorites/create

> Body 请求参数

```json
{
  "userCode": "string",
  "productInfo": "string",
  "sourcePage": "string",
  "remark": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteCreateDTO](#schemauserfavoritecreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userId": 0,
    "userCode": "",
    "productInfo": "",
    "productName": "",
    "productImage": "",
    "sourcePage": "",
    "remark": "",
    "deleted": 0,
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserFavorite](#schemaapiresponseuserfavorite)|

## POST 更新收藏

POST /api/user-favorites/update

> Body 请求参数

```json
{
  "id": 0,
  "productInfo": "string",
  "sourcePage": "string",
  "remark": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteUpdateDTO](#schemauserfavoriteupdatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userId": 0,
    "userCode": "",
    "productInfo": "",
    "productName": "",
    "productImage": "",
    "sourcePage": "",
    "remark": "",
    "deleted": 0,
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserFavorite](#schemaapiresponseuserfavorite)|

## POST 删除收藏

POST /api/user-favorites/delete

> Body 请求参数

```json
{
  "id": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteDeleteDTO](#schemauserfavoritedeletedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": false,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseBoolean](#schemaapiresponseboolean)|

## POST 根据ID获取收藏详情

POST /api/user-favorites/detail

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userId": 0,
    "userCode": "",
    "productInfo": "",
    "productName": "",
    "productImage": "",
    "sourcePage": "",
    "remark": "",
    "deleted": 0,
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserFavorite](#schemaapiresponseuserfavorite)|

## POST 根据用户标识获取收藏列表

POST /api/user-favorites/list-by-user

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "productInfo": "",
      "productName": "",
      "productImage": "",
      "sourcePage": "",
      "remark": "",
      "deleted": 0,
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserFavorite](#schemaapiresponselistuserfavorite)|

## POST 分页查询收藏列表

POST /api/user-favorites/page

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "total": 0,
    "list": [
      {
        "id": 0,
        "userId": 0,
        "userCode": "",
        "productInfo": "",
        "productName": "",
        "productImage": "",
        "sourcePage": "",
        "remark": "",
        "deleted": 0,
        "createTime": "",
        "updateTime": ""
      }
    ],
    "pageNum": 0,
    "pageSize": 0,
    "size": 0,
    "startRow": 0,
    "endRow": 0,
    "pages": 0,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": false,
    "isLastPage": false,
    "hasPreviousPage": false,
    "hasNextPage": false,
    "navigatePages": 0,
    "navigatepageNums": [
      0
    ],
    "navigateFirstPage": 0,
    "navigateLastPage": 0
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponsePageInfoUserFavorite](#schemaapiresponsepageinfouserfavorite)|

## POST 根据商品名称搜索收藏

POST /api/user-favorites/search-by-product

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "productInfo": "",
      "productName": "",
      "productImage": "",
      "sourcePage": "",
      "remark": "",
      "deleted": 0,
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserFavorite](#schemaapiresponselistuserfavorite)|

## POST 根据来源页面查询收藏

POST /api/user-favorites/list-by-source

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "productInfo": "",
      "productName": "",
      "productImage": "",
      "sourcePage": "",
      "remark": "",
      "deleted": 0,
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserFavorite](#schemaapiresponselistuserfavorite)|

## POST 根据时间范围查询收藏

POST /api/user-favorites/list-by-time

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "",
      "productInfo": "",
      "productName": "",
      "productImage": "",
      "sourcePage": "",
      "remark": "",
      "deleted": 0,
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserFavorite](#schemaapiresponselistuserfavorite)|

## POST 统计用户收藏总数

POST /api/user-favorites/count-by-user

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": 0,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseLong](#schemaapiresponselong)|

## POST 检查是否已收藏某商品

POST /api/user-favorites/check-favorited

> Body 请求参数

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserFavoriteQueryDTO](#schemauserfavoritequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": false,
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseBoolean](#schemaapiresponseboolean)|

# 产品类型控制器

## POST 分页查询产品类型列表

POST /api/product-types/list

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductTypeQueryDTO](#schemaproducttypequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "list": [
      {
        "id": 0,
        "name": "",
        "description": "",
        "status": 0,
        "statusText": "",
        "createTime": "",
        "updateTime": ""
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": false,
    "hasPreviousPage": false
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponsePageVOProductTypeVO](#schemaapiresponsepagevoproducttypevo)|

## POST 根据ID获取产品类型详情

POST /api/product-types/detail

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductTypeQueryDTO](#schemaproducttypequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseProductTypeVO](#schemaapiresponseproducttypevo)|

## POST 获取所有启用的产品类型

POST /api/product-types/enabled

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "name": "",
      "description": "",
      "status": 0,
      "statusText": "",
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListProductTypeVO](#schemaapiresponselistproducttypevo)|

## POST 创建产品类型

POST /api/product-types/create

> Body 请求参数

```json
{
  "name": "string",
  "description": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductTypeCreateDTO](#schemaproducttypecreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseProductTypeVO](#schemaapiresponseproducttypevo)|

## POST 更新产品类型

POST /api/product-types/update

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "description": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductTypeUpdateDTO](#schemaproducttypeupdatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseProductTypeVO](#schemaapiresponseproducttypevo)|

## POST 更新产品类型状态

POST /api/product-types/update-status

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductTypeQueryDTO](#schemaproducttypequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 删除产品类型（逻辑删除）

POST /api/product-types/delete

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductTypeQueryDTO](#schemaproducttypequerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

# 产品控制器

## POST 分页查询产品列表

POST /api/products/list

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "minPrice": 0,
  "maxPrice": 0,
  "unit": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductQueryDTO](#schemaproductquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "list": [
      {
        "id": 0,
        "name": "",
        "productTypeId": 0,
        "productTypeName": "",
        "price": 0,
        "unit": "",
        "imageUrl": "",
        "description": "",
        "status": 0,
        "statusText": "",
        "createTime": "",
        "updateTime": ""
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": false,
    "hasPreviousPage": false
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponsePageVOProductVO](#schemaapiresponsepagevoproductvo)|

## POST 根据ID获取产品详情

POST /api/products/detail

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "minPrice": 0,
  "maxPrice": 0,
  "unit": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductQueryDTO](#schemaproductquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "productTypeId": 0,
    "productTypeName": "",
    "price": 0,
    "unit": "",
    "imageUrl": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseProductVO](#schemaapiresponseproductvo)|

## POST 根据产品类型ID获取产品列表

POST /api/products/by-type

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "minPrice": 0,
  "maxPrice": 0,
  "unit": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductQueryDTO](#schemaproductquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "name": "",
      "productTypeId": 0,
      "productTypeName": "",
      "price": 0,
      "unit": "",
      "imageUrl": "",
      "description": "",
      "status": 0,
      "statusText": "",
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListProductVO](#schemaapiresponselistproductvo)|

## POST 获取所有启用的产品

POST /api/products/enabled

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "name": "",
      "productTypeId": 0,
      "productTypeName": "",
      "price": 0,
      "unit": "",
      "imageUrl": "",
      "description": "",
      "status": 0,
      "statusText": "",
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListProductVO](#schemaapiresponselistproductvo)|

## POST 创建产品

POST /api/products/create

> Body 请求参数

```json
{
  "name": "string",
  "productTypeId": 0,
  "price": 1,
  "unit": "string",
  "imageUrl": "string",
  "description": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductCreateDTO](#schemaproductcreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "productTypeId": 0,
    "productTypeName": "",
    "price": 0,
    "unit": "",
    "imageUrl": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseProductVO](#schemaapiresponseproductvo)|

## POST 更新产品

POST /api/products/update

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "price": 1,
  "unit": "string",
  "imageUrl": "string",
  "description": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductUpdateDTO](#schemaproductupdatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "productTypeId": 0,
    "productTypeName": "",
    "price": 0,
    "unit": "",
    "imageUrl": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseProductVO](#schemaapiresponseproductvo)|

## POST 更新产品状态

POST /api/products/update-status

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "minPrice": 0,
  "maxPrice": 0,
  "unit": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductQueryDTO](#schemaproductquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 删除产品（逻辑删除）

POST /api/products/delete

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "minPrice": 0,
  "maxPrice": 0,
  "unit": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[ProductQueryDTO](#schemaproductquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

# 经销商控制器

## POST 分页查询经销商列表

POST /api/dealers/list

> Body 请求参数

```json
{
  "id": 0,
  "code": "string",
  "name": "string",
  "email": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerQueryDTO](#schemadealerquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "list": [
      {
        "id": 0,
        "name": "",
        "code": "",
        "email": "",
        "phone": "",
        "address": "",
        "description": "",
        "status": 0,
        "statusText": "",
        "createTime": "",
        "updateTime": ""
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": false,
    "hasPreviousPage": false
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponsePageVODealerVO](#schemaapiresponsepagevodealervo)|

## POST 根据ID获取经销商详情

POST /api/dealers/detail

> Body 请求参数

```json
{
  "id": 0,
  "code": "string",
  "name": "string",
  "email": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerQueryDTO](#schemadealerquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "code": "",
    "email": "",
    "phone": "",
    "address": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseDealerVO](#schemaapiresponsedealervo)|

## POST 根据编码获取经销商详情

POST /api/dealers/detail-by-code

> Body 请求参数

```json
{
  "id": 0,
  "code": "string",
  "name": "string",
  "email": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerQueryDTO](#schemadealerquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "code": "",
    "email": "",
    "phone": "",
    "address": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseDealerVO](#schemaapiresponsedealervo)|

## POST 创建经销商

POST /api/dealers/create

> Body 请求参数

```json
{
  "name": "string",
  "code": "string",
  "email": "user@example.com",
  "phone": "string",
  "address": "string",
  "description": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerCreateDTO](#schemadealercreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "code": "",
    "email": "",
    "phone": "",
    "address": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseDealerVO](#schemaapiresponsedealervo)|

## POST 更新经销商

POST /api/dealers/update

> Body 请求参数

```json
{
  "id": 0,
  "name": "string",
  "code": "string",
  "email": "user@example.com",
  "phone": "string",
  "address": "string",
  "description": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerUpdateDTO](#schemadealerupdatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "name": "",
    "code": "",
    "email": "",
    "phone": "",
    "address": "",
    "description": "",
    "status": 0,
    "statusText": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseDealerVO](#schemaapiresponsedealervo)|

## POST 更新经销商状态

POST /api/dealers/update-status

> Body 请求参数

```json
{
  "id": 0,
  "status": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerStatusDTO](#schemadealerstatusdto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 删除经销商（逻辑删除）

POST /api/dealers/delete

> Body 请求参数

```json
{
  "id": 0,
  "code": "string",
  "name": "string",
  "email": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[DealerQueryDTO](#schemadealerquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

# 用户控制器

## POST 分页查询用户列表

POST /api/users/list

> Body 请求参数

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserQueryDTO](#schemauserquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "list": [
      {
        "id": 0,
        "userCode": "",
        "username": "",
        "firstName": "",
        "lastName": "",
        "email": "",
        "dealerId": 0,
        "dealerName": "",
        "status": 0,
        "statusText": "",
        "isOnline": 0,
        "onlineText": "",
        "lastLoginTime": "",
        "lastLogoutTime": "",
        "loginIp": "",
        "createTime": "",
        "updateTime": ""
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": false,
    "hasPreviousPage": false
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponsePageVOUserVO](#schemaapiresponsepagevouservo)|

## POST 根据ID获取用户详情

POST /api/users/detail

> Body 请求参数

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserQueryDTO](#schemauserquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userCode": "",
    "username": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "dealerId": 0,
    "dealerName": "",
    "status": 0,
    "statusText": "",
    "isOnline": 0,
    "onlineText": "",
    "lastLoginTime": "",
    "lastLogoutTime": "",
    "loginIp": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserVO](#schemaapiresponseuservo)|

## POST 根据用户标识获取用户详情

POST /api/users/detail-by-code

> Body 请求参数

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserQueryDTO](#schemauserquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userCode": "",
    "username": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "dealerId": 0,
    "dealerName": "",
    "status": 0,
    "statusText": "",
    "isOnline": 0,
    "onlineText": "",
    "lastLoginTime": "",
    "lastLogoutTime": "",
    "loginIp": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserVO](#schemaapiresponseuservo)|

## POST 根据邮箱获取用户标识

POST /api/users/get-code-by-email

> Body 请求参数

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserQueryDTO](#schemauserquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 用户登录（通过用户标识）

POST /api/users/login

> Body 请求参数

```json
{
  "userCode": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserLoginDTO](#schemauserlogindto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userCode": "",
    "username": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "dealerId": 0,
    "dealerName": "",
    "status": 0,
    "statusText": "",
    "isOnline": 0,
    "onlineText": "",
    "lastLoginTime": "",
    "lastLogoutTime": "",
    "loginIp": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserVO](#schemaapiresponseuservo)|

## POST 用户退出登录

POST /api/users/logout

> Body 请求参数

```json
{
  "userCode": "string"
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserLogoutDTO](#schemauserlogoutdto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 创建用户

POST /api/users/create

> Body 请求参数

```json
{
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "user@example.com",
  "dealerId": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserCreateDTO](#schemausercreatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userCode": "",
    "username": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "dealerId": 0,
    "dealerName": "",
    "status": 0,
    "statusText": "",
    "isOnline": 0,
    "onlineText": "",
    "lastLoginTime": "",
    "lastLogoutTime": "",
    "loginIp": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserVO](#schemaapiresponseuservo)|

## POST 更新用户

POST /api/users/update

> Body 请求参数

```json
{
  "id": 0,
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "user@example.com",
  "dealerId": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserUpdateDTO](#schemauserupdatedto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": {
    "id": 0,
    "userCode": "",
    "username": "",
    "firstName": "",
    "lastName": "",
    "email": "",
    "dealerId": 0,
    "dealerName": "",
    "status": 0,
    "statusText": "",
    "isOnline": 0,
    "onlineText": "",
    "lastLoginTime": "",
    "lastLogoutTime": "",
    "loginIp": "",
    "createTime": "",
    "updateTime": ""
  },
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseUserVO](#schemaapiresponseuservo)|

## POST 更新用户状态

POST /api/users/update-status

> Body 请求参数

```json
{
  "id": 0,
  "status": 0
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserStatusDTO](#schemauserstatusdto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 删除用户（逻辑删除）

POST /api/users/delete

> Body 请求参数

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}
```

### 请求参数

|名称|位置|类型|必选|说明|
|---|---|---|---|---|
|body|body|[UserQueryDTO](#schemauserquerydto)| 否 |none|

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": "",
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseString](#schemaapiresponsestring)|

## POST 获取在线用户列表

POST /api/users/online-list

> 返回示例

> 200 Response

```json
{
  "code": 0,
  "message": "",
  "data": [
    {
      "id": 0,
      "userCode": "",
      "username": "",
      "firstName": "",
      "lastName": "",
      "email": "",
      "dealerId": 0,
      "dealerName": "",
      "status": 0,
      "statusText": "",
      "isOnline": 0,
      "onlineText": "",
      "lastLoginTime": "",
      "lastLogoutTime": "",
      "loginIp": "",
      "createTime": "",
      "updateTime": ""
    }
  ],
  "timestamp": 0
}
```

### 返回结果

|状态码|状态码含义|说明|数据模型|
|---|---|---|---|
|200|[OK](https://tools.ietf.org/html/rfc7231#section-6.3.1)|none|[ApiResponseListUserVO](#schemaapiresponselistuservo)|

# 数据模型

<h2 id="tocS_ApiResponseString">ApiResponseString</h2>

<a id="schemaapiresponsestring"></a>
<a id="schema_ApiResponseString"></a>
<a id="tocSapiresponsestring"></a>
<a id="tocsapiresponsestring"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": "string",
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|string|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_AdminVO">AdminVO</h2>

<a id="schemaadminvo"></a>
<a id="schema_AdminVO"></a>
<a id="tocSadminvo"></a>
<a id="tocsadminvo"></a>

```json
{
  "id": 0,
  "username": "string",
  "email": "string",
  "realName": "string",
  "phone": "string",
  "status": 0,
  "isOnline": 0,
  "lastLoginTime": "string",
  "loginIp": "string",
  "createTime": "string",
  "updateTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|username|string|false|none||none|
|email|string|false|none||none|
|realName|string|false|none||none|
|phone|string|false|none||none|
|status|integer|false|none||none|
|isOnline|integer|false|none||none|
|lastLoginTime|string|false|none||none|
|loginIp|string|false|none||none|
|createTime|string|false|none||none|
|updateTime|string|false|none||none|

<h2 id="tocS_ApiResponseAdminVO">ApiResponseAdminVO</h2>

<a id="schemaapiresponseadminvo"></a>
<a id="schema_ApiResponseAdminVO"></a>
<a id="tocSapiresponseadminvo"></a>
<a id="tocsapiresponseadminvo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "id": 0,
    "username": "string",
    "email": "string",
    "realName": "string",
    "phone": "string",
    "status": 0,
    "isOnline": 0,
    "lastLoginTime": "string",
    "loginIp": "string",
    "createTime": "string",
    "updateTime": "string"
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[AdminVO](#schemaadminvo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_AdminLoginDTO">AdminLoginDTO</h2>

<a id="schemaadminlogindto"></a>
<a id="schema_AdminLoginDTO"></a>
<a id="tocSadminlogindto"></a>
<a id="tocsadminlogindto"></a>

```json
{
  "username": "string",
  "password": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|username|string|true|none||none|
|password|string|true|none||none|

<h2 id="tocS_AdminLogoutDTO">AdminLogoutDTO</h2>

<a id="schemaadminlogoutdto"></a>
<a id="schema_AdminLogoutDTO"></a>
<a id="tocSadminlogoutdto"></a>
<a id="tocsadminlogoutdto"></a>

```json
{
  "username": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|username|string|true|none||none|

<h2 id="tocS_ProductStatistics">ProductStatistics</h2>

<a id="schemaproductstatistics"></a>
<a id="schema_ProductStatistics"></a>
<a id="tocSproductstatistics"></a>
<a id="tocsproductstatistics"></a>

```json
{
  "productName": "string",
  "count": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|productName|string|false|none||产品名称|
|count|integer(int64)|false|none||统计数量|

<h2 id="tocS_StatisticsResponse">StatisticsResponse</h2>

<a id="schemastatisticsresponse"></a>
<a id="schema_StatisticsResponse"></a>
<a id="tocSstatisticsresponse"></a>
<a id="tocsstatisticsresponse"></a>

```json
{
  "avgSessionTime": 0,
  "totalSessionTime": 0,
  "totalCustomers": 0,
  "avgImmersiveSessionTime": 0,
  "avgModelSessionTime": 0,
  "activeUsers": 0,
  "mostViewedProducts": [
    {
      "productName": "string",
      "count": 0
    }
  ],
  "mostFavoriteProducts": [
    {
      "productName": "string",
      "count": 0
    }
  ],
  "avgWatchTime": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|avgSessionTime|integer(int64)|false|none||用户平均会话时长（毫秒）|
|totalSessionTime|integer(int64)|false|none||会话总时长（毫秒）|
|totalCustomers|integer|false|none||总客户数|
|avgImmersiveSessionTime|integer(int64)|false|none||平均沉浸式会话时间（毫秒）|
|avgModelSessionTime|integer(int64)|false|none||平均3D模型会话时间（毫秒）|
|activeUsers|integer|false|none||正在活动用户数|
|mostViewedProducts|[[ProductStatistics](#schemaproductstatistics)]|false|none||最受关注产品|
|mostFavoriteProducts|[[ProductStatistics](#schemaproductstatistics)]|false|none||最喜爱产品|
|avgWatchTime|integer(int64)|false|none||平均观看时长（毫秒）|

<h2 id="tocS_ApiResponseStatisticsResponse">ApiResponseStatisticsResponse</h2>

<a id="schemaapiresponsestatisticsresponse"></a>
<a id="schema_ApiResponseStatisticsResponse"></a>
<a id="tocSapiresponsestatisticsresponse"></a>
<a id="tocsapiresponsestatisticsresponse"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "avgSessionTime": 0,
    "totalSessionTime": 0,
    "totalCustomers": 0,
    "avgImmersiveSessionTime": 0,
    "avgModelSessionTime": 0,
    "activeUsers": 0,
    "mostViewedProducts": [
      {
        "productName": "string",
        "count": 0
      }
    ],
    "mostFavoriteProducts": [
      {
        "productName": "string",
        "count": 0
      }
    ],
    "avgWatchTime": 0
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[StatisticsResponse](#schemastatisticsresponse)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_GetStatisticsRequest">GetStatisticsRequest</h2>

<a id="schemagetstatisticsrequest"></a>
<a id="schema_GetStatisticsRequest"></a>
<a id="tocSgetstatisticsrequest"></a>
<a id="tocsgetstatisticsrequest"></a>

```json
{
  "startTime": "string",
  "endTime": "string",
  "dealerId": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|startTime|string|false|none||统计开始时间（可选）|
|endTime|string|false|none||统计结束时间（可选）|
|dealerId|integer(int64)|false|none||经销商ID（可选，用于筛选特定经销商数据）|

<h2 id="tocS_ApiResponseBoolean">ApiResponseBoolean</h2>

<a id="schemaapiresponseboolean"></a>
<a id="schema_ApiResponseBoolean"></a>
<a id="tocSapiresponseboolean"></a>
<a id="tocsapiresponseboolean"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": true,
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|boolean|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_UserTrackCreateDTO">UserTrackCreateDTO</h2>

<a id="schemausertrackcreatedto"></a>
<a id="schema_UserTrackCreateDTO"></a>
<a id="tocSusertrackcreatedto"></a>
<a id="tocsusertrackcreatedto"></a>

```json
{
  "userCode": "string",
  "eventName": "string",
  "trackData": "string",
  "pagePath": "string",
  "extraInfo": "string",
  "sessionTime": 0,
  "pageSessionTime": 0,
  "modelSessionTime": 0,
  "avgWatchTime": 0,
  "pageStayTime": 0,
  "modelViewTime": 0,
  "productName": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|userCode|string|false|none||用户标识（可选，如果已登录）|
|eventName|string|true|none||事件名称|
|trackData|string|false|none||埋点数据（JSON格式）|
|pagePath|string|false|none||页面路径|
|extraInfo|string|false|none||额外信息|
|sessionTime|integer(int64)|false|none||会话时间相关字段|
|pageSessionTime|integer(int64)|false|none||普通页面会话时间（毫秒）|
|modelSessionTime|integer(int64)|false|none||3D模型会话时间（毫秒）|
|avgWatchTime|integer(int64)|false|none||平均观看时长（毫秒）|
|pageStayTime|integer(int64)|false|none||页面停留时间（毫秒）|
|modelViewTime|integer(int64)|false|none||模型查看时间（毫秒）|
|productName|string|false|none||浏览的商品名称|

<h2 id="tocS_UserTrack">UserTrack</h2>

<a id="schemausertrack"></a>
<a id="schema_UserTrack"></a>
<a id="tocSusertrack"></a>
<a id="tocsusertrack"></a>

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "requestIp": "string",
  "requestPath": "string",
  "requestMethod": "string",
  "requestParams": "string",
  "responseStatus": 0,
  "userAgent": "string",
  "trackType": "string",
  "eventName": "string",
  "trackData": "string",
  "executionTime": 0,
  "sessionTime": 0,
  "pageSessionTime": 0,
  "modelSessionTime": 0,
  "avgWatchTime": 0,
  "pageStayTime": 0,
  "modelViewTime": 0,
  "productName": "string",
  "deleted": 0,
  "createTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|userId|integer(int64)|false|none||用户ID（如果已登录）|
|userCode|string|false|none||用户标识（如果已登录）|
|requestIp|string|true|none||请求IP地址|
|requestPath|string|false|none||请求路径|
|requestMethod|string|false|none||请求方法（GET/POST等）|
|requestParams|string|false|none||请求参数|
|responseStatus|integer|false|none||响应状态码|
|userAgent|string|false|none||用户代理（浏览器信息）|
|trackType|string|false|none||埋点类型：AUTO-自动埋点, MANUAL-手动埋点|
|eventName|string|false|none||事件名称|
|trackData|string|false|none||埋点数据（JSON格式）|
|executionTime|integer(int64)|false|none||接口执行时间（毫秒）|
|sessionTime|integer(int64)|false|none||会话时间相关字段|
|pageSessionTime|integer(int64)|false|none||普通页面会话时间（毫秒）|
|modelSessionTime|integer(int64)|false|none||3D模型会话时间（毫秒）|
|avgWatchTime|integer(int64)|false|none||平均观看时长（毫秒）|
|pageStayTime|integer(int64)|false|none||页面停留时间（毫秒）|
|modelViewTime|integer(int64)|false|none||模型查看时间（毫秒）|
|productName|string|false|none||浏览的商品名称|
|deleted|integer|false|none||0-未删除 1-已删除|
|createTime|string|false|none||none|

<h2 id="tocS_ApiResponseListUserTrack">ApiResponseListUserTrack</h2>

<a id="schemaapiresponselistusertrack"></a>
<a id="schema_ApiResponseListUserTrack"></a>
<a id="tocSapiresponselistusertrack"></a>
<a id="tocsapiresponselistusertrack"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "string",
      "requestIp": "string",
      "requestPath": "string",
      "requestMethod": "string",
      "requestParams": "string",
      "responseStatus": 0,
      "userAgent": "string",
      "trackType": "string",
      "eventName": "string",
      "trackData": "string",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "string",
      "deleted": 0,
      "createTime": "string"
    }
  ],
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[[UserTrack](#schemausertrack)]|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_PageInfoUserTrack">PageInfoUserTrack</h2>

<a id="schemapageinfousertrack"></a>
<a id="schema_PageInfoUserTrack"></a>
<a id="tocSpageinfousertrack"></a>
<a id="tocspageinfousertrack"></a>

```json
{
  "total": 0,
  "list": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "string",
      "requestIp": "string",
      "requestPath": "string",
      "requestMethod": "string",
      "requestParams": "string",
      "responseStatus": 0,
      "userAgent": "string",
      "trackType": "string",
      "eventName": "string",
      "trackData": "string",
      "executionTime": 0,
      "sessionTime": 0,
      "pageSessionTime": 0,
      "modelSessionTime": 0,
      "avgWatchTime": 0,
      "pageStayTime": 0,
      "modelViewTime": 0,
      "productName": "string",
      "deleted": 0,
      "createTime": "string"
    }
  ],
  "pageNum": 0,
  "pageSize": 0,
  "size": 0,
  "startRow": 0,
  "endRow": 0,
  "pages": 0,
  "prePage": 0,
  "nextPage": 0,
  "isFirstPage": true,
  "isLastPage": true,
  "hasPreviousPage": true,
  "hasNextPage": true,
  "navigatePages": 0,
  "navigatepageNums": [
    0
  ],
  "navigateFirstPage": 0,
  "navigateLastPage": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|total|integer(int64)|false|none||none|
|list|[[UserTrack](#schemausertrack)]|false|none||none|
|pageNum|integer|false|none||none|
|pageSize|integer|false|none||none|
|size|integer|false|none||none|
|startRow|integer(int64)|false|none||none|
|endRow|integer(int64)|false|none||none|
|pages|integer|false|none||none|
|prePage|integer|false|none||none|
|nextPage|integer|false|none||none|
|isFirstPage|boolean|false|none||none|
|isLastPage|boolean|false|none||none|
|hasPreviousPage|boolean|false|none||none|
|hasNextPage|boolean|false|none||none|
|navigatePages|integer|false|none||none|
|navigatepageNums|[integer]|false|none||none|
|navigateFirstPage|integer|false|none||none|
|navigateLastPage|integer|false|none||none|

<h2 id="tocS_ApiResponsePageInfoUserTrack">ApiResponsePageInfoUserTrack</h2>

<a id="schemaapiresponsepageinfousertrack"></a>
<a id="schema_ApiResponsePageInfoUserTrack"></a>
<a id="tocSapiresponsepageinfousertrack"></a>
<a id="tocsapiresponsepageinfousertrack"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "total": 0,
    "list": [
      {
        "id": 0,
        "userId": 0,
        "userCode": "string",
        "requestIp": "string",
        "requestPath": "string",
        "requestMethod": "string",
        "requestParams": "string",
        "responseStatus": 0,
        "userAgent": "string",
        "trackType": "string",
        "eventName": "string",
        "trackData": "string",
        "executionTime": 0,
        "sessionTime": 0,
        "pageSessionTime": 0,
        "modelSessionTime": 0,
        "avgWatchTime": 0,
        "pageStayTime": 0,
        "modelViewTime": 0,
        "productName": "string",
        "deleted": 0,
        "createTime": "string"
      }
    ],
    "pageNum": 0,
    "pageSize": 0,
    "size": 0,
    "startRow": 0,
    "endRow": 0,
    "pages": 0,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": true,
    "isLastPage": true,
    "hasPreviousPage": true,
    "hasNextPage": true,
    "navigatePages": 0,
    "navigatepageNums": [
      0
    ],
    "navigateFirstPage": 0,
    "navigateLastPage": 0
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[PageInfoUserTrack](#schemapageinfousertrack)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_UserTrackQueryDTO">UserTrackQueryDTO</h2>

<a id="schemausertrackquerydto"></a>
<a id="schema_UserTrackQueryDTO"></a>
<a id="tocSusertrackquerydto"></a>
<a id="tocsusertrackquerydto"></a>

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "requestIp": "string",
  "requestPath": "string",
  "requestMethod": "string",
  "trackType": "string",
  "eventName": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|userId|integer(int64)|false|none||none|
|userCode|string|false|none||none|
|requestIp|string|false|none||none|
|requestPath|string|false|none||none|
|requestMethod|string|false|none||none|
|trackType|string|false|none||AUTO-自动埋点, MANUAL-手动埋点|
|eventName|string|false|none||none|
|startTime|string|false|none||开始时间|
|endTime|string|false|none||结束时间|
|pageNum|integer|false|none||页码，默认第1页|
|pageSize|integer|false|none||每页大小，默认10条|

<h2 id="tocS_ApiResponseLong">ApiResponseLong</h2>

<a id="schemaapiresponselong"></a>
<a id="schema_ApiResponseLong"></a>
<a id="tocSapiresponselong"></a>
<a id="tocsapiresponselong"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": 0,
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|integer(int64)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_key">key</h2>

<a id="schemakey"></a>
<a id="schema_key"></a>
<a id="tocSkey"></a>
<a id="tocskey"></a>

```json
{}

```

### 属性

*None*

<h2 id="tocS_MapObject">MapObject</h2>

<a id="schemamapobject"></a>
<a id="schema_MapObject"></a>
<a id="tocSmapobject"></a>
<a id="tocsmapobject"></a>

```json
{
  "key": {}
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|key|[key](#schemakey)|false|none||none|

<h2 id="tocS_ApiResponseListMapObject">ApiResponseListMapObject</h2>

<a id="schemaapiresponselistmapobject"></a>
<a id="schema_ApiResponseListMapObject"></a>
<a id="tocSapiresponselistmapobject"></a>
<a id="tocsapiresponselistmapobject"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": [
    {
      "key": {}
    }
  ],
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[[MapObject](#schemamapobject)]|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_UserFavorite">UserFavorite</h2>

<a id="schemauserfavorite"></a>
<a id="schema_UserFavorite"></a>
<a id="tocSuserfavorite"></a>
<a id="tocsuserfavorite"></a>

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productInfo": "string",
  "productName": "string",
  "productImage": "string",
  "sourcePage": "string",
  "remark": "string",
  "deleted": 0,
  "createTime": "string",
  "updateTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|userId|integer(int64)|true|none||用户ID|
|userCode|string|true|none||用户标识|
|productInfo|string|true|none||商品信息JSON格式，包含图片、名称、单位、价格等|
|productName|string|false|none||冗余字段，方便查询和展示|
|productImage|string|false|none||冗余字段，商品主图|
|sourcePage|string|false|none||收藏来源页面|
|remark|string|false|none||用户备注|
|deleted|integer|false|none||0-未删除 1-已删除|
|createTime|string|false|none||none|
|updateTime|string|false|none||none|

<h2 id="tocS_ApiResponseUserFavorite">ApiResponseUserFavorite</h2>

<a id="schemaapiresponseuserfavorite"></a>
<a id="schema_ApiResponseUserFavorite"></a>
<a id="tocSapiresponseuserfavorite"></a>
<a id="tocsapiresponseuserfavorite"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "id": 0,
    "userId": 0,
    "userCode": "string",
    "productInfo": "string",
    "productName": "string",
    "productImage": "string",
    "sourcePage": "string",
    "remark": "string",
    "deleted": 0,
    "createTime": "string",
    "updateTime": "string"
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[UserFavorite](#schemauserfavorite)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_UserFavoriteCreateDTO">UserFavoriteCreateDTO</h2>

<a id="schemauserfavoritecreatedto"></a>
<a id="schema_UserFavoriteCreateDTO"></a>
<a id="tocSuserfavoritecreatedto"></a>
<a id="tocsuserfavoritecreatedto"></a>

```json
{
  "userCode": "string",
  "productInfo": "string",
  "sourcePage": "string",
  "remark": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|userCode|string|true|none||用户标识|
|productInfo|string|true|none||商品信息JSON格式，包含图片、名称、单位、价格等|
|sourcePage|string|false|none||收藏来源页面|
|remark|string|false|none||用户备注|

<h2 id="tocS_UserFavoriteUpdateDTO">UserFavoriteUpdateDTO</h2>

<a id="schemauserfavoriteupdatedto"></a>
<a id="schema_UserFavoriteUpdateDTO"></a>
<a id="tocSuserfavoriteupdatedto"></a>
<a id="tocsuserfavoriteupdatedto"></a>

```json
{
  "id": 0,
  "productInfo": "string",
  "sourcePage": "string",
  "remark": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||收藏ID|
|productInfo|string|false|none||商品信息JSON格式，包含图片、名称、单位、价格等|
|sourcePage|string|false|none||收藏来源页面|
|remark|string|false|none||用户备注|

<h2 id="tocS_UserFavoriteDeleteDTO">UserFavoriteDeleteDTO</h2>

<a id="schemauserfavoritedeletedto"></a>
<a id="schema_UserFavoriteDeleteDTO"></a>
<a id="tocSuserfavoritedeletedto"></a>
<a id="tocsuserfavoritedeletedto"></a>

```json
{
  "id": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||收藏ID|

<h2 id="tocS_UserFavoriteQueryDTO">UserFavoriteQueryDTO</h2>

<a id="schemauserfavoritequerydto"></a>
<a id="schema_UserFavoriteQueryDTO"></a>
<a id="tocSuserfavoritequerydto"></a>
<a id="tocsuserfavoritequerydto"></a>

```json
{
  "id": 0,
  "userId": 0,
  "userCode": "string",
  "productName": "string",
  "sourcePage": "string",
  "startTime": "string",
  "endTime": "string",
  "pageNum": 1,
  "pageSize": 10
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||收藏ID|
|userId|integer(int64)|false|none||用户ID|
|userCode|string|false|none||用户标识|
|productName|string|false|none||商品名称（模糊查询）|
|sourcePage|string|false|none||收藏来源页面|
|startTime|string|false|none||开始时间|
|endTime|string|false|none||结束时间|
|pageNum|integer|false|none||页码，默认第1页|
|pageSize|integer|false|none||每页大小，默认10条|

<h2 id="tocS_ApiResponseListUserFavorite">ApiResponseListUserFavorite</h2>

<a id="schemaapiresponselistuserfavorite"></a>
<a id="schema_ApiResponseListUserFavorite"></a>
<a id="tocSapiresponselistuserfavorite"></a>
<a id="tocsapiresponselistuserfavorite"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "string",
      "productInfo": "string",
      "productName": "string",
      "productImage": "string",
      "sourcePage": "string",
      "remark": "string",
      "deleted": 0,
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[[UserFavorite](#schemauserfavorite)]|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_PageInfoUserFavorite">PageInfoUserFavorite</h2>

<a id="schemapageinfouserfavorite"></a>
<a id="schema_PageInfoUserFavorite"></a>
<a id="tocSpageinfouserfavorite"></a>
<a id="tocspageinfouserfavorite"></a>

```json
{
  "total": 0,
  "list": [
    {
      "id": 0,
      "userId": 0,
      "userCode": "string",
      "productInfo": "string",
      "productName": "string",
      "productImage": "string",
      "sourcePage": "string",
      "remark": "string",
      "deleted": 0,
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "pageNum": 0,
  "pageSize": 0,
  "size": 0,
  "startRow": 0,
  "endRow": 0,
  "pages": 0,
  "prePage": 0,
  "nextPage": 0,
  "isFirstPage": true,
  "isLastPage": true,
  "hasPreviousPage": true,
  "hasNextPage": true,
  "navigatePages": 0,
  "navigatepageNums": [
    0
  ],
  "navigateFirstPage": 0,
  "navigateLastPage": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|total|integer(int64)|false|none||none|
|list|[[UserFavorite](#schemauserfavorite)]|false|none||none|
|pageNum|integer|false|none||none|
|pageSize|integer|false|none||none|
|size|integer|false|none||none|
|startRow|integer(int64)|false|none||none|
|endRow|integer(int64)|false|none||none|
|pages|integer|false|none||none|
|prePage|integer|false|none||none|
|nextPage|integer|false|none||none|
|isFirstPage|boolean|false|none||none|
|isLastPage|boolean|false|none||none|
|hasPreviousPage|boolean|false|none||none|
|hasNextPage|boolean|false|none||none|
|navigatePages|integer|false|none||none|
|navigatepageNums|[integer]|false|none||none|
|navigateFirstPage|integer|false|none||none|
|navigateLastPage|integer|false|none||none|

<h2 id="tocS_ApiResponsePageInfoUserFavorite">ApiResponsePageInfoUserFavorite</h2>

<a id="schemaapiresponsepageinfouserfavorite"></a>
<a id="schema_ApiResponsePageInfoUserFavorite"></a>
<a id="tocSapiresponsepageinfouserfavorite"></a>
<a id="tocsapiresponsepageinfouserfavorite"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "total": 0,
    "list": [
      {
        "id": 0,
        "userId": 0,
        "userCode": "string",
        "productInfo": "string",
        "productName": "string",
        "productImage": "string",
        "sourcePage": "string",
        "remark": "string",
        "deleted": 0,
        "createTime": "string",
        "updateTime": "string"
      }
    ],
    "pageNum": 0,
    "pageSize": 0,
    "size": 0,
    "startRow": 0,
    "endRow": 0,
    "pages": 0,
    "prePage": 0,
    "nextPage": 0,
    "isFirstPage": true,
    "isLastPage": true,
    "hasPreviousPage": true,
    "hasNextPage": true,
    "navigatePages": 0,
    "navigatepageNums": [
      0
    ],
    "navigateFirstPage": 0,
    "navigateLastPage": 0
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[PageInfoUserFavorite](#schemapageinfouserfavorite)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ProductTypeVO">ProductTypeVO</h2>

<a id="schemaproducttypevo"></a>
<a id="schema_ProductTypeVO"></a>
<a id="tocSproducttypevo"></a>
<a id="tocsproducttypevo"></a>

```json
{
  "id": 0,
  "name": "string",
  "description": "string",
  "status": 0,
  "statusText": "string",
  "createTime": "string",
  "updateTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|name|string|false|none||none|
|description|string|false|none||none|
|status|integer|false|none||0-禁用 1-启用|
|statusText|string|false|none||状态文本描述|
|createTime|string|false|none||none|
|updateTime|string|false|none||none|

<h2 id="tocS_PageVOProductTypeVO">PageVOProductTypeVO</h2>

<a id="schemapagevoproducttypevo"></a>
<a id="schema_PageVOProductTypeVO"></a>
<a id="tocSpagevoproducttypevo"></a>
<a id="tocspagevoproducttypevo"></a>

```json
{
  "list": [
    {
      "id": 0,
      "name": "string",
      "description": "string",
      "status": 0,
      "statusText": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "total": 0,
  "pageNum": 0,
  "pageSize": 0,
  "pages": 0,
  "hasNextPage": true,
  "hasPreviousPage": true
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|list|[[ProductTypeVO](#schemaproducttypevo)]|false|none||数据列表|
|total|integer(int64)|false|none||总记录数|
|pageNum|integer|false|none||当前页码|
|pageSize|integer|false|none||每页大小|
|pages|integer|false|none||总页数|
|hasNextPage|boolean|false|none||是否有下一页|
|hasPreviousPage|boolean|false|none||是否有上一页|

<h2 id="tocS_ApiResponsePageVOProductTypeVO">ApiResponsePageVOProductTypeVO</h2>

<a id="schemaapiresponsepagevoproducttypevo"></a>
<a id="schema_ApiResponsePageVOProductTypeVO"></a>
<a id="tocSapiresponsepagevoproducttypevo"></a>
<a id="tocsapiresponsepagevoproducttypevo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "list": [
      {
        "id": 0,
        "name": "string",
        "description": "string",
        "status": 0,
        "statusText": "string",
        "createTime": "string",
        "updateTime": "string"
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": true,
    "hasPreviousPage": true
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[PageVOProductTypeVO](#schemapagevoproducttypevo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ProductTypeQueryDTO">ProductTypeQueryDTO</h2>

<a id="schemaproducttypequerydto"></a>
<a id="schema_ProductTypeQueryDTO"></a>
<a id="tocSproducttypequerydto"></a>
<a id="tocsproducttypequerydto"></a>

```json
{
  "id": 0,
  "name": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|name|string|false|none||none|
|status|integer|false|none||none|
|pageNum|integer|false|none||页码，默认第1页|
|pageSize|integer|false|none||每页大小，默认10条|

<h2 id="tocS_ApiResponseProductTypeVO">ApiResponseProductTypeVO</h2>

<a id="schemaapiresponseproducttypevo"></a>
<a id="schema_ApiResponseProductTypeVO"></a>
<a id="tocSapiresponseproducttypevo"></a>
<a id="tocsapiresponseproducttypevo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "id": 0,
    "name": "string",
    "description": "string",
    "status": 0,
    "statusText": "string",
    "createTime": "string",
    "updateTime": "string"
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[ProductTypeVO](#schemaproducttypevo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ApiResponseListProductTypeVO">ApiResponseListProductTypeVO</h2>

<a id="schemaapiresponselistproducttypevo"></a>
<a id="schema_ApiResponseListProductTypeVO"></a>
<a id="tocSapiresponselistproducttypevo"></a>
<a id="tocsapiresponselistproducttypevo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": [
    {
      "id": 0,
      "name": "string",
      "description": "string",
      "status": 0,
      "statusText": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[[ProductTypeVO](#schemaproducttypevo)]|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ProductTypeCreateDTO">ProductTypeCreateDTO</h2>

<a id="schemaproducttypecreatedto"></a>
<a id="schema_ProductTypeCreateDTO"></a>
<a id="tocSproducttypecreatedto"></a>
<a id="tocsproducttypecreatedto"></a>

```json
{
  "name": "string",
  "description": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|name|string|true|none||none|
|description|string|false|none||none|

<h2 id="tocS_ProductTypeUpdateDTO">ProductTypeUpdateDTO</h2>

<a id="schemaproducttypeupdatedto"></a>
<a id="schema_ProductTypeUpdateDTO"></a>
<a id="tocSproducttypeupdatedto"></a>
<a id="tocsproducttypeupdatedto"></a>

```json
{
  "id": 0,
  "name": "string",
  "description": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||none|
|name|string|true|none||none|
|description|string|false|none||none|

<h2 id="tocS_ProductVO">ProductVO</h2>

<a id="schemaproductvo"></a>
<a id="schema_ProductVO"></a>
<a id="tocSproductvo"></a>
<a id="tocsproductvo"></a>

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "productTypeName": "string",
  "price": 0,
  "unit": "string",
  "imageUrl": "string",
  "description": "string",
  "status": 0,
  "statusText": "string",
  "createTime": "string",
  "updateTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|name|string|false|none||none|
|productTypeId|integer(int64)|false|none||none|
|productTypeName|string|false|none||产品类型名称|
|price|number|false|none||none|
|unit|string|false|none||none|
|imageUrl|string|false|none||none|
|description|string|false|none||none|
|status|integer|false|none||0-禁用 1-启用|
|statusText|string|false|none||状态文本描述|
|createTime|string|false|none||none|
|updateTime|string|false|none||none|

<h2 id="tocS_PageVOProductVO">PageVOProductVO</h2>

<a id="schemapagevoproductvo"></a>
<a id="schema_PageVOProductVO"></a>
<a id="tocSpagevoproductvo"></a>
<a id="tocspagevoproductvo"></a>

```json
{
  "list": [
    {
      "id": 0,
      "name": "string",
      "productTypeId": 0,
      "productTypeName": "string",
      "price": 0,
      "unit": "string",
      "imageUrl": "string",
      "description": "string",
      "status": 0,
      "statusText": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "total": 0,
  "pageNum": 0,
  "pageSize": 0,
  "pages": 0,
  "hasNextPage": true,
  "hasPreviousPage": true
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|list|[[ProductVO](#schemaproductvo)]|false|none||数据列表|
|total|integer(int64)|false|none||总记录数|
|pageNum|integer|false|none||当前页码|
|pageSize|integer|false|none||每页大小|
|pages|integer|false|none||总页数|
|hasNextPage|boolean|false|none||是否有下一页|
|hasPreviousPage|boolean|false|none||是否有上一页|

<h2 id="tocS_ApiResponsePageVOProductVO">ApiResponsePageVOProductVO</h2>

<a id="schemaapiresponsepagevoproductvo"></a>
<a id="schema_ApiResponsePageVOProductVO"></a>
<a id="tocSapiresponsepagevoproductvo"></a>
<a id="tocsapiresponsepagevoproductvo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "list": [
      {
        "id": 0,
        "name": "string",
        "productTypeId": 0,
        "productTypeName": "string",
        "price": 0,
        "unit": "string",
        "imageUrl": "string",
        "description": "string",
        "status": 0,
        "statusText": "string",
        "createTime": "string",
        "updateTime": "string"
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": true,
    "hasPreviousPage": true
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[PageVOProductVO](#schemapagevoproductvo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ProductQueryDTO">ProductQueryDTO</h2>

<a id="schemaproductquerydto"></a>
<a id="schema_ProductQueryDTO"></a>
<a id="tocSproductquerydto"></a>
<a id="tocsproductquerydto"></a>

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "minPrice": 0,
  "maxPrice": 0,
  "unit": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|name|string|false|none||none|
|productTypeId|integer(int64)|false|none||none|
|minPrice|number|false|none||最低价格|
|maxPrice|number|false|none||最高价格|
|unit|string|false|none||none|
|status|integer|false|none||none|
|pageNum|integer|false|none||页码，默认第1页|
|pageSize|integer|false|none||每页大小，默认10条|

<h2 id="tocS_ApiResponseProductVO">ApiResponseProductVO</h2>

<a id="schemaapiresponseproductvo"></a>
<a id="schema_ApiResponseProductVO"></a>
<a id="tocSapiresponseproductvo"></a>
<a id="tocsapiresponseproductvo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "id": 0,
    "name": "string",
    "productTypeId": 0,
    "productTypeName": "string",
    "price": 0,
    "unit": "string",
    "imageUrl": "string",
    "description": "string",
    "status": 0,
    "statusText": "string",
    "createTime": "string",
    "updateTime": "string"
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[ProductVO](#schemaproductvo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ApiResponseListProductVO">ApiResponseListProductVO</h2>

<a id="schemaapiresponselistproductvo"></a>
<a id="schema_ApiResponseListProductVO"></a>
<a id="tocSapiresponselistproductvo"></a>
<a id="tocsapiresponselistproductvo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": [
    {
      "id": 0,
      "name": "string",
      "productTypeId": 0,
      "productTypeName": "string",
      "price": 0,
      "unit": "string",
      "imageUrl": "string",
      "description": "string",
      "status": 0,
      "statusText": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[[ProductVO](#schemaproductvo)]|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_ProductCreateDTO">ProductCreateDTO</h2>

<a id="schemaproductcreatedto"></a>
<a id="schema_ProductCreateDTO"></a>
<a id="tocSproductcreatedto"></a>
<a id="tocsproductcreatedto"></a>

```json
{
  "name": "string",
  "productTypeId": 0,
  "price": 1,
  "unit": "string",
  "imageUrl": "string",
  "description": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|name|string|true|none||none|
|productTypeId|integer(int64)|true|none||none|
|price|number|true|none||none|
|unit|string|true|none||none|
|imageUrl|string|false|none||none|
|description|string|false|none||none|

<h2 id="tocS_ProductUpdateDTO">ProductUpdateDTO</h2>

<a id="schemaproductupdatedto"></a>
<a id="schema_ProductUpdateDTO"></a>
<a id="tocSproductupdatedto"></a>
<a id="tocsproductupdatedto"></a>

```json
{
  "id": 0,
  "name": "string",
  "productTypeId": 0,
  "price": 1,
  "unit": "string",
  "imageUrl": "string",
  "description": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||none|
|name|string|true|none||none|
|productTypeId|integer(int64)|true|none||none|
|price|number|true|none||none|
|unit|string|true|none||none|
|imageUrl|string|false|none||none|
|description|string|false|none||none|

<h2 id="tocS_DealerVO">DealerVO</h2>

<a id="schemadealervo"></a>
<a id="schema_DealerVO"></a>
<a id="tocSdealervo"></a>
<a id="tocsdealervo"></a>

```json
{
  "id": 0,
  "name": "string",
  "code": "string",
  "email": "string",
  "phone": "string",
  "address": "string",
  "description": "string",
  "status": 0,
  "statusText": "string",
  "createTime": "string",
  "updateTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|name|string|false|none||none|
|code|string|false|none||none|
|email|string|false|none||none|
|phone|string|false|none||none|
|address|string|false|none||none|
|description|string|false|none||none|
|status|integer|false|none||0-禁用 1-启用|
|statusText|string|false|none||状态文本描述|
|createTime|string|false|none||none|
|updateTime|string|false|none||none|

<h2 id="tocS_PageVODealerVO">PageVODealerVO</h2>

<a id="schemapagevodealervo"></a>
<a id="schema_PageVODealerVO"></a>
<a id="tocSpagevodealervo"></a>
<a id="tocspagevodealervo"></a>

```json
{
  "list": [
    {
      "id": 0,
      "name": "string",
      "code": "string",
      "email": "string",
      "phone": "string",
      "address": "string",
      "description": "string",
      "status": 0,
      "statusText": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "total": 0,
  "pageNum": 0,
  "pageSize": 0,
  "pages": 0,
  "hasNextPage": true,
  "hasPreviousPage": true
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|list|[[DealerVO](#schemadealervo)]|false|none||数据列表|
|total|integer(int64)|false|none||总记录数|
|pageNum|integer|false|none||当前页码|
|pageSize|integer|false|none||每页大小|
|pages|integer|false|none||总页数|
|hasNextPage|boolean|false|none||是否有下一页|
|hasPreviousPage|boolean|false|none||是否有上一页|

<h2 id="tocS_ApiResponsePageVODealerVO">ApiResponsePageVODealerVO</h2>

<a id="schemaapiresponsepagevodealervo"></a>
<a id="schema_ApiResponsePageVODealerVO"></a>
<a id="tocSapiresponsepagevodealervo"></a>
<a id="tocsapiresponsepagevodealervo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "list": [
      {
        "id": 0,
        "name": "string",
        "code": "string",
        "email": "string",
        "phone": "string",
        "address": "string",
        "description": "string",
        "status": 0,
        "statusText": "string",
        "createTime": "string",
        "updateTime": "string"
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": true,
    "hasPreviousPage": true
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[PageVODealerVO](#schemapagevodealervo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_DealerQueryDTO">DealerQueryDTO</h2>

<a id="schemadealerquerydto"></a>
<a id="schema_DealerQueryDTO"></a>
<a id="tocSdealerquerydto"></a>
<a id="tocsdealerquerydto"></a>

```json
{
  "id": 0,
  "code": "string",
  "name": "string",
  "email": "string",
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|code|string|false|none||none|
|name|string|false|none||none|
|email|string|false|none||none|
|status|integer|false|none||none|
|pageNum|integer|false|none||页码，默认第1页|
|pageSize|integer|false|none||每页大小，默认10条|

<h2 id="tocS_ApiResponseDealerVO">ApiResponseDealerVO</h2>

<a id="schemaapiresponsedealervo"></a>
<a id="schema_ApiResponseDealerVO"></a>
<a id="tocSapiresponsedealervo"></a>
<a id="tocsapiresponsedealervo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "id": 0,
    "name": "string",
    "code": "string",
    "email": "string",
    "phone": "string",
    "address": "string",
    "description": "string",
    "status": 0,
    "statusText": "string",
    "createTime": "string",
    "updateTime": "string"
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[DealerVO](#schemadealervo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_DealerCreateDTO">DealerCreateDTO</h2>

<a id="schemadealercreatedto"></a>
<a id="schema_DealerCreateDTO"></a>
<a id="tocSdealercreatedto"></a>
<a id="tocsdealercreatedto"></a>

```json
{
  "name": "string",
  "code": "string",
  "email": "user@example.com",
  "phone": "string",
  "address": "string",
  "description": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|name|string|true|none||none|
|code|string|true|none||none|
|email|string(email)|false|none||none|
|phone|string|false|none||none|
|address|string|false|none||none|
|description|string|false|none||none|

<h2 id="tocS_DealerUpdateDTO">DealerUpdateDTO</h2>

<a id="schemadealerupdatedto"></a>
<a id="schema_DealerUpdateDTO"></a>
<a id="tocSdealerupdatedto"></a>
<a id="tocsdealerupdatedto"></a>

```json
{
  "id": 0,
  "name": "string",
  "code": "string",
  "email": "user@example.com",
  "phone": "string",
  "address": "string",
  "description": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||none|
|name|string|true|none||none|
|code|string|true|none||none|
|email|string(email)|false|none||none|
|phone|string|false|none||none|
|address|string|false|none||none|
|description|string|false|none||none|

<h2 id="tocS_DealerStatusDTO">DealerStatusDTO</h2>

<a id="schemadealerstatusdto"></a>
<a id="schema_DealerStatusDTO"></a>
<a id="tocSdealerstatusdto"></a>
<a id="tocsdealerstatusdto"></a>

```json
{
  "id": 0,
  "status": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||none|
|status|integer|true|none||0-禁用 1-启用|

<h2 id="tocS_UserVO">UserVO</h2>

<a id="schemauservo"></a>
<a id="schema_UserVO"></a>
<a id="tocSuservo"></a>
<a id="tocsuservo"></a>

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "dealerName": "string",
  "status": 0,
  "statusText": "string",
  "isOnline": 0,
  "onlineText": "string",
  "lastLoginTime": "string",
  "lastLogoutTime": "string",
  "loginIp": "string",
  "createTime": "string",
  "updateTime": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|userCode|string|false|none||none|
|username|string|false|none||none|
|firstName|string|false|none||none|
|lastName|string|false|none||none|
|email|string|false|none||none|
|dealerId|integer(int64)|false|none||none|
|dealerName|string|false|none||经销商名称|
|status|integer|false|none||0-禁用 1-启用|
|statusText|string|false|none||状态文本描述|
|isOnline|integer|false|none||登录状态 0-离线 1-在线|
|onlineText|string|false|none||在线状态文本描述|
|lastLoginTime|string|false|none||最后登录时间|
|lastLogoutTime|string|false|none||最后退出时间|
|loginIp|string|false|none||最后登录IP|
|createTime|string|false|none||none|
|updateTime|string|false|none||none|

<h2 id="tocS_PageVOUserVO">PageVOUserVO</h2>

<a id="schemapagevouservo"></a>
<a id="schema_PageVOUserVO"></a>
<a id="tocSpagevouservo"></a>
<a id="tocspagevouservo"></a>

```json
{
  "list": [
    {
      "id": 0,
      "userCode": "string",
      "username": "string",
      "firstName": "string",
      "lastName": "string",
      "email": "string",
      "dealerId": 0,
      "dealerName": "string",
      "status": 0,
      "statusText": "string",
      "isOnline": 0,
      "onlineText": "string",
      "lastLoginTime": "string",
      "lastLogoutTime": "string",
      "loginIp": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "total": 0,
  "pageNum": 0,
  "pageSize": 0,
  "pages": 0,
  "hasNextPage": true,
  "hasPreviousPage": true
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|list|[[UserVO](#schemauservo)]|false|none||数据列表|
|total|integer(int64)|false|none||总记录数|
|pageNum|integer|false|none||当前页码|
|pageSize|integer|false|none||每页大小|
|pages|integer|false|none||总页数|
|hasNextPage|boolean|false|none||是否有下一页|
|hasPreviousPage|boolean|false|none||是否有上一页|

<h2 id="tocS_ApiResponsePageVOUserVO">ApiResponsePageVOUserVO</h2>

<a id="schemaapiresponsepagevouservo"></a>
<a id="schema_ApiResponsePageVOUserVO"></a>
<a id="tocSapiresponsepagevouservo"></a>
<a id="tocsapiresponsepagevouservo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "list": [
      {
        "id": 0,
        "userCode": "string",
        "username": "string",
        "firstName": "string",
        "lastName": "string",
        "email": "string",
        "dealerId": 0,
        "dealerName": "string",
        "status": 0,
        "statusText": "string",
        "isOnline": 0,
        "onlineText": "string",
        "lastLoginTime": "string",
        "lastLogoutTime": "string",
        "loginIp": "string",
        "createTime": "string",
        "updateTime": "string"
      }
    ],
    "total": 0,
    "pageNum": 0,
    "pageSize": 0,
    "pages": 0,
    "hasNextPage": true,
    "hasPreviousPage": true
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[PageVOUserVO](#schemapagevouservo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_UserQueryDTO">UserQueryDTO</h2>

<a id="schemauserquerydto"></a>
<a id="schema_UserQueryDTO"></a>
<a id="tocSuserquerydto"></a>
<a id="tocsuserquerydto"></a>

```json
{
  "id": 0,
  "userCode": "string",
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "dealerId": 0,
  "status": 0,
  "pageNum": 1,
  "pageSize": 10
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|false|none||none|
|userCode|string|false|none||none|
|username|string|false|none||none|
|firstName|string|false|none||none|
|lastName|string|false|none||none|
|email|string|false|none||none|
|dealerId|integer(int64)|false|none||none|
|status|integer|false|none||none|
|pageNum|integer|false|none||页码，默认第1页|
|pageSize|integer|false|none||每页大小，默认10条|

<h2 id="tocS_ApiResponseUserVO">ApiResponseUserVO</h2>

<a id="schemaapiresponseuservo"></a>
<a id="schema_ApiResponseUserVO"></a>
<a id="tocSapiresponseuservo"></a>
<a id="tocsapiresponseuservo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": {
    "id": 0,
    "userCode": "string",
    "username": "string",
    "firstName": "string",
    "lastName": "string",
    "email": "string",
    "dealerId": 0,
    "dealerName": "string",
    "status": 0,
    "statusText": "string",
    "isOnline": 0,
    "onlineText": "string",
    "lastLoginTime": "string",
    "lastLogoutTime": "string",
    "loginIp": "string",
    "createTime": "string",
    "updateTime": "string"
  },
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[UserVO](#schemauservo)|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|

<h2 id="tocS_UserLoginDTO">UserLoginDTO</h2>

<a id="schemauserlogindto"></a>
<a id="schema_UserLoginDTO"></a>
<a id="tocSuserlogindto"></a>
<a id="tocsuserlogindto"></a>

```json
{
  "userCode": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|userCode|string|true|none||none|

<h2 id="tocS_UserLogoutDTO">UserLogoutDTO</h2>

<a id="schemauserlogoutdto"></a>
<a id="schema_UserLogoutDTO"></a>
<a id="tocSuserlogoutdto"></a>
<a id="tocsuserlogoutdto"></a>

```json
{
  "userCode": "string"
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|userCode|string|true|none||用户标识|

<h2 id="tocS_UserCreateDTO">UserCreateDTO</h2>

<a id="schemausercreatedto"></a>
<a id="schema_UserCreateDTO"></a>
<a id="tocSusercreatedto"></a>
<a id="tocsusercreatedto"></a>

```json
{
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "user@example.com",
  "dealerId": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|username|string|true|none||none|
|firstName|string|true|none||none|
|lastName|string|true|none||none|
|email|string(email)|true|none||none|
|dealerId|integer(int64)|true|none||none|

<h2 id="tocS_UserUpdateDTO">UserUpdateDTO</h2>

<a id="schemauserupdatedto"></a>
<a id="schema_UserUpdateDTO"></a>
<a id="tocSuserupdatedto"></a>
<a id="tocsuserupdatedto"></a>

```json
{
  "id": 0,
  "username": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "user@example.com",
  "dealerId": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||none|
|username|string|true|none||none|
|firstName|string|true|none||none|
|lastName|string|true|none||none|
|email|string(email)|true|none||none|
|dealerId|integer(int64)|true|none||none|

<h2 id="tocS_UserStatusDTO">UserStatusDTO</h2>

<a id="schemauserstatusdto"></a>
<a id="schema_UserStatusDTO"></a>
<a id="tocSuserstatusdto"></a>
<a id="tocsuserstatusdto"></a>

```json
{
  "id": 0,
  "status": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|id|integer(int64)|true|none||none|
|status|integer|true|none||0-禁用 1-启用|

<h2 id="tocS_ApiResponseListUserVO">ApiResponseListUserVO</h2>

<a id="schemaapiresponselistuservo"></a>
<a id="schema_ApiResponseListUserVO"></a>
<a id="tocSapiresponselistuservo"></a>
<a id="tocsapiresponselistuservo"></a>

```json
{
  "code": 0,
  "message": "string",
  "data": [
    {
      "id": 0,
      "userCode": "string",
      "username": "string",
      "firstName": "string",
      "lastName": "string",
      "email": "string",
      "dealerId": 0,
      "dealerName": "string",
      "status": 0,
      "statusText": "string",
      "isOnline": 0,
      "onlineText": "string",
      "lastLoginTime": "string",
      "lastLogoutTime": "string",
      "loginIp": "string",
      "createTime": "string",
      "updateTime": "string"
    }
  ],
  "timestamp": 0
}

```

### 属性

|名称|类型|必选|约束|中文名|说明|
|---|---|---|---|---|---|
|code|integer|false|none||响应码|
|message|string|false|none||响应消息|
|data|[[UserVO](#schemauservo)]|false|none||响应数据|
|timestamp|integer(int64)|false|none||时间戳|


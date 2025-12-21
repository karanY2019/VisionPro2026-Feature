# VR后端项目 API 接口文档

## 概述

本文档描述了VR后端项目的所有REST API接口。所有接口均使用POST方法，返回统一的JSON格式响应。

### 基础信息
- **基础URL**: `/api`
- **请求方法**: 统一使用POST
- **响应格式**: JSON
- **编码**: UTF-8

### 统一响应格式
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {},
  "timestamp": 1234567890
}
```

---

## 1. 用户管理 API

### 1.1 用户列表分页查询
**URL**: `/api/users/list`  
**方法**: POST  
**描述**: 分页查询用户列表

**请求参数** (UserQueryDTO):
```json
{
  "pageNum": 1,
  "pageSize": 10
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "list": [
      {
        "id": 1,
        "username": "张三",
        "email": "zhangsan@example.com",
        "userCode": "USER_CODE_123",
        "dealerId": 1,
        "dealerName": "经销商名称",
        "status": 1,
        "loginStatus": 1,
        "lastLoginTime": "2023-12-01T10:30:00",
        "createTime": "2023-12-01T09:00:00",
        "updateTime": "2023-12-01T10:30:00"
      }
    ],
    "total": 100,
    "pageNum": 1,
    "pageSize": 10
  },
  "timestamp": 1701419400000
}
```

### 1.2 获取用户详情
**URL**: `/api/users/detail`  
**方法**: POST  
**描述**: 根据用户ID获取用户详情

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "username": "张三",
    "email": "zhangsan@example.com",
    "userCode": "USER_CODE_123",
    "dealerId": 1,
    "dealerName": "经销商名称",
    "status": 1,
    "loginStatus": 1,
    "lastLoginTime": "2023-12-01T10:30:00",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T10:30:00"
  },
  "timestamp": 1701419400000
}
```

### 1.3 根据用户标识获取详情
**URL**: `/api/users/detail-by-code`  
**方法**: POST  
**描述**: 根据用户标识获取用户详情

**请求参数**:
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "username": "张三",
    "email": "zhangsan@example.com",
    "userCode": "USER_CODE_123",
    "dealerId": 1,
    "dealerName": "经销商名称",
    "status": 1,
    "loginStatus": 1,
    "lastLoginTime": "2023-12-01T10:30:00",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T10:30:00"
  },
  "timestamp": 1701419400000
}
```

### 1.4 根据邮箱获取用户标识
**URL**: `/api/users/get-code-by-email`  
**方法**: POST  
**描述**: 根据邮箱获取用户标识

**请求参数**:
```json
{
  "email": "user@example.com"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": "USER_CODE_123",
  "timestamp": 1701419400000
}
```

### 1.5 用户登录
**URL**: `/api/users/login`  
**方法**: POST  
**描述**: 用户登录（通过用户标识）

**请求参数** (UserLoginDTO):
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户登录成功",
  "data": {
    "id": 1,
    "username": "张三",
    "email": "zhangsan@example.com",
    "userCode": "USER_CODE_123",
    "dealerId": 1,
    "dealerName": "经销商名称",
    "status": 1,
    "loginStatus": 1,
    "lastLoginTime": "2023-12-01T10:30:00",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T10:30:00"
  },
  "timestamp": 1701419400000
}
```

### 1.6 用户退出登录
**URL**: `/api/users/logout`  
**方法**: POST  
**描述**: 用户退出登录

**请求参数** (UserLogoutDTO):
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户退出成功",
  "data": null,
  "timestamp": 1701419400000
}
```

### 1.7 创建用户
**URL**: `/api/users/create`  
**方法**: POST  
**描述**: 创建新用户

**请求参数** (UserCreateDTO):
```json
{
  "username": "张三",
  "email": "zhangsan@example.com",
  "dealerId": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户创建成功",
  "data": {
    "id": 1,
    "username": "张三",
    "email": "zhangsan@example.com",
    "userCode": "USER_CODE_123",
    "dealerId": 1,
    "dealerName": "经销商名称",
    "status": 1,
    "loginStatus": 0,
    "lastLoginTime": null,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 1.8 更新用户
**URL**: `/api/users/update`  
**方法**: POST  
**描述**: 更新用户信息

**请求参数** (UserUpdateDTO):
```json
{
  "id": 1,
  "username": "张三",
  "email": "zhangsan@example.com",
  "dealerId": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户更新成功",
  "data": {
    "id": 1,
    "username": "张三",
    "email": "zhangsan@example.com",
    "userCode": "USER_CODE_123",
    "dealerId": 1,
    "dealerName": "经销商名称",
    "status": 1,
    "loginStatus": 1,
    "lastLoginTime": "2023-12-01T10:30:00",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T11:00:00"
  },
  "timestamp": 1701419400000
}
```

### 1.9 更新用户状态
**URL**: `/api/users/update-status`  
**方法**: POST  
**描述**: 更新用户状态

**请求参数** (UserStatusDTO):
```json
{
  "id": 1,
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户状态更新成功",
  "data": null,
  "timestamp": 1701419400000
}
```

### 1.10 删除用户
**URL**: `/api/users/delete`  
**方法**: POST  
**描述**: 删除用户（逻辑删除）

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户删除成功",
  "data": null,
  "timestamp": 1701419400000
}
```

### 1.11 获取在线用户列表
**URL**: `/api/users/online-list`  
**方法**: POST  
**描述**: 获取在线用户列表

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "username": "张三",
      "email": "zhangsan@example.com",
      "userCode": "USER_CODE_123",
      "dealerId": 1,
      "dealerName": "经销商名称",
      "status": 1,
      "loginStatus": 1,
      "lastLoginTime": "2023-12-01T10:30:00",
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T10:30:00"
    }
  ],
  "timestamp": 1701419400000
}
```

---

## 2. 产品管理 API

### 2.1 产品列表分页查询
**URL**: `/api/products/list`  
**方法**: POST  
**描述**: 分页查询产品列表

**请求参数** (ProductQueryDTO):
```json
{
  "pageNum": 1,
  "pageSize": 10,
  "name": "产品名称",
  "productTypeId": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "list": [
      {
        "id": 1,
        "name": "产品名称",
        "description": "产品描述",
        "productTypeId": 1,
        "productTypeName": "产品类型名称",
        "status": 1,
        "createTime": "2023-12-01T09:00:00",
        "updateTime": "2023-12-01T09:00:00"
      }
    ],
    "total": 50,
    "pageNum": 1,
    "pageSize": 10
  },
  "timestamp": 1701419400000
}
```

### 2.2 获取产品详情
**URL**: `/api/products/detail`  
**方法**: POST  
**描述**: 根据产品ID获取产品详情

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "name": "产品名称",
    "description": "产品描述",
    "productTypeId": 1,
    "productTypeName": "产品类型名称",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 2.3 根据产品类型获取产品
**URL**: `/api/products/by-type`  
**方法**: POST  
**描述**: 根据产品类型ID获取产品列表

**请求参数**:
```json
{
  "productTypeId": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "name": "产品名称",
      "description": "产品描述",
      "productTypeId": 1,
      "productTypeName": "产品类型名称",
      "status": 1,
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 2.4 获取所有启用的产品
**URL**: `/api/products/enabled`  
**方法**: POST  
**描述**: 获取所有启用状态的产品

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "name": "产品名称",
      "description": "产品描述",
      "productTypeId": 1,
      "productTypeName": "产品类型名称",
      "status": 1,
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 2.5 创建产品
**URL**: `/api/products/create`  
**方法**: POST  
**描述**: 创建新产品

**请求参数** (ProductCreateDTO):
```json
{
  "name": "新产品",
  "description": "产品描述",
  "productTypeId": 1,
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品创建成功",
  "data": {
    "id": 1,
    "name": "新产品",
    "description": "产品描述",
    "productTypeId": 1,
    "productTypeName": "产品类型名称",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 2.6 更新产品
**URL**: `/api/products/update`  
**方法**: POST  
**描述**: 更新产品信息

**请求参数** (ProductUpdateDTO):
```json
{
  "id": 1,
  "name": "更新产品",
  "description": "产品描述",
  "productTypeId": 1,
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品更新成功",
  "data": {
    "id": 1,
    "name": "更新产品",
    "description": "产品描述",
    "productTypeId": 1,
    "productTypeName": "产品类型名称",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T11:00:00"
  },
  "timestamp": 1701419400000
}
```

### 2.7 更新产品状态
**URL**: `/api/products/update-status`  
**方法**: POST  
**描述**: 更新产品状态

**请求参数**:
```json
{
  "id": 1,
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品状态更新成功",
  "data": null,
  "timestamp": 1701419400000
}
```

### 2.8 删除产品
**URL**: `/api/products/delete`  
**方法**: POST  
**描述**: 删除产品（逻辑删除）

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品删除成功",
  "data": null,
  "timestamp": 1701419400000
}
```

---

## 3. 经销商管理 API

### 3.1 经销商列表分页查询
**URL**: `/api/dealers/list`  
**方法**: POST  
**描述**: 分页查询经销商列表

**请求参数** (DealerQueryDTO):
```json
{
  "pageNum": 1,
  "pageSize": 10
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "list": [
      {
        "id": 1,
        "name": "经销商名称",
        "code": "DEALER_001",
        "contact": "联系人",
        "phone": "13800138000",
        "address": "详细地址",
        "status": 1,
        "createTime": "2023-12-01T09:00:00",
        "updateTime": "2023-12-01T09:00:00"
      }
    ],
    "total": 30,
    "pageNum": 1,
    "pageSize": 10
  },
  "timestamp": 1701419400000
}
```

### 3.2 获取经销商详情
**URL**: `/api/dealers/detail`  
**方法**: POST  
**描述**: 根据经销商ID获取详情

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "name": "经销商名称",
    "code": "DEALER_001",
    "contact": "联系人",
    "phone": "13800138000",
    "address": "详细地址",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 3.3 根据编码获取经销商
**URL**: `/api/dealers/detail-by-code`  
**方法**: POST  
**描述**: 根据经销商编码获取详情

**请求参数**:
```json
{
  "code": "DEALER_001"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "name": "经销商名称",
    "code": "DEALER_001",
    "contact": "联系人",
    "phone": "13800138000",
    "address": "详细地址",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 3.4 创建经销商
**URL**: `/api/dealers/create`  
**方法**: POST  
**描述**: 创建新经销商

**请求参数** (DealerCreateDTO):
```json
{
  "name": "经销商名称",
  "code": "DEALER_001",
  "contact": "联系人",
  "phone": "13800138000",
  "address": "详细地址"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "经销商创建成功",
  "data": {
    "id": 1,
    "name": "经销商名称",
    "code": "DEALER_001",
    "contact": "联系人",
    "phone": "13800138000",
    "address": "详细地址",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 3.5 更新经销商
**URL**: `/api/dealers/update`  
**方法**: POST  
**描述**: 更新经销商信息

**请求参数** (DealerUpdateDTO):
```json
{
  "id": 1,
  "name": "经销商名称",
  "contact": "联系人",
  "phone": "13800138000",
  "address": "详细地址"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "经销商更新成功",
  "data": {
    "id": 1,
    "name": "经销商名称",
    "code": "DEALER_001",
    "contact": "联系人",
    "phone": "13800138000",
    "address": "详细地址",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T11:00:00"
  },
  "timestamp": 1701419400000
}
```

### 3.6 更新经销商状态
**URL**: `/api/dealers/update-status`  
**方法**: POST  
**描述**: 更新经销商状态

**请求参数** (DealerStatusDTO):
```json
{
  "id": 1,
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "经销商状态更新成功",
  "data": null,
  "timestamp": 1701419400000
}
```

### 3.7 删除经销商
**URL**: `/api/dealers/delete`  
**方法**: POST  
**描述**: 删除经销商（逻辑删除）

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "经销商删除成功",
  "data": null,
  "timestamp": 1701419400000
}
```

---

## 4. 产品类型管理 API

### 4.1 产品类型列表分页查询
**URL**: `/api/product-types/list`  
**方法**: POST  
**描述**: 分页查询产品类型列表

**请求参数** (ProductTypeQueryDTO):
```json
{
  "pageNum": 1,
  "pageSize": 10
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "list": [
      {
        "id": 1,
        "name": "产品类型名称",
        "description": "类型描述",
        "status": 1,
        "createTime": "2023-12-01T09:00:00",
        "updateTime": "2023-12-01T09:00:00"
      }
    ],
    "total": 20,
    "pageNum": 1,
    "pageSize": 10
  },
  "timestamp": 1701419400000
}
```

### 4.2 获取产品类型详情
**URL**: `/api/product-types/detail`  
**方法**: POST  
**描述**: 根据产品类型ID获取详情

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "name": "产品类型名称",
    "description": "类型描述",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 4.3 获取所有启用的产品类型
**URL**: `/api/product-types/enabled`  
**方法**: POST  
**描述**: 获取所有启用状态的产品类型

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "name": "产品类型名称",
      "description": "类型描述",
      "status": 1,
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 4.4 创建产品类型
**URL**: `/api/product-types/create`  
**方法**: POST  
**描述**: 创建新产品类型

**请求参数** (ProductTypeCreateDTO):
```json
{
  "name": "产品类型名称",
  "description": "类型描述",
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品类型创建成功",
  "data": {
    "id": 1,
    "name": "产品类型名称",
    "description": "类型描述",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 4.5 更新产品类型
**URL**: `/api/product-types/update`  
**方法**: POST  
**描述**: 更新产品类型信息

**请求参数** (ProductTypeUpdateDTO):
```json
{
  "id": 1,
  "name": "产品类型名称",
  "description": "类型描述",
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品类型更新成功",
  "data": {
    "id": 1,
    "name": "产品类型名称",
    "description": "类型描述",
    "status": 1,
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T11:00:00"
  },
  "timestamp": 1701419400000
}
```

### 4.6 更新产品类型状态
**URL**: `/api/product-types/update-status`  
**方法**: POST  
**描述**: 更新产品类型状态

**请求参数**:
```json
{
  "id": 1,
  "status": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品类型状态更新成功",
  "data": null,
  "timestamp": 1701419400000
}
```

### 4.7 删除产品类型
**URL**: `/api/product-types/delete`  
**方法**: POST  
**描述**: 删除产品类型（逻辑删除）

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "产品类型删除成功",
  "data": null,
  "timestamp": 1701419400000
}
```

---

## 5. 用户收藏管理 API

### 5.1 添加收藏
**URL**: `/api/user-favorites/create`  
**方法**: POST  
**描述**: 添加用户收藏

**请求参数** (UserFavoriteCreateDTO):
```json
{
  "userCode": "USER_CODE_123",
  "productName": "产品名称",
  "sourcePage": "来源页面"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "收藏添加成功",
  "data": {
    "id": 1,
    "userCode": "USER_CODE_123",
    "productName": "产品名称",
    "sourcePage": "来源页面",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 5.2 更新收藏
**URL**: `/api/user-favorites/update`  
**方法**: POST  
**描述**: 更新用户收藏信息

**请求参数** (UserFavoriteUpdateDTO):
```json
{
  "id": 1,
  "productName": "产品名称",
  "sourcePage": "来源页面"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "收藏更新成功",
  "data": {
    "id": 1,
    "userCode": "USER_CODE_123",
    "productName": "产品名称",
    "sourcePage": "来源页面",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T11:00:00"
  },
  "timestamp": 1701419400000
}
```

### 5.3 删除收藏
**URL**: `/api/user-favorites/delete`  
**方法**: POST  
**描述**: 删除用户收藏

**请求参数** (UserFavoriteDeleteDTO):
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "收藏删除成功",
  "data": true,
  "timestamp": 1701419400000
}
```

### 5.4 获取收藏详情
**URL**: `/api/user-favorites/detail`  
**方法**: POST  
**描述**: 根据收藏ID获取详情

**请求参数**:
```json
{
  "id": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "id": 1,
    "userCode": "USER_CODE_123",
    "productName": "产品名称",
    "sourcePage": "来源页面",
    "createTime": "2023-12-01T09:00:00",
    "updateTime": "2023-12-01T09:00:00"
  },
  "timestamp": 1701419400000
}
```

### 5.5 根据用户标识获取收藏列表
**URL**: `/api/user-favorites/list-by-user`  
**方法**: POST  
**描述**: 根据用户标识获取收藏列表

**请求参数**:
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "productName": "产品名称",
      "sourcePage": "来源页面",
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 5.6 分页查询收藏
**URL**: `/api/user-favorites/page`  
**方法**: POST  
**描述**: 分页查询收藏列表

**请求参数** (UserFavoriteQueryDTO):
```json
{
  "pageNum": 1,
  "pageSize": 10,
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "list": [
      {
        "id": 1,
        "userCode": "USER_CODE_123",
        "productName": "产品名称",
        "sourcePage": "来源页面",
        "createTime": "2023-12-01T09:00:00",
        "updateTime": "2023-12-01T09:00:00"
      }
    ],
    "total": 25,
    "pageNum": 1,
    "pageSize": 10,
    "pages": 3,
    "navigatePages": 8,
    "navigatepageNums": [1, 2, 3],
    "isFirstPage": true,
    "isLastPage": false,
    "hasPreviousPage": false,
    "hasNextPage": true,
    "prePage": 0,
    "nextPage": 2
  },
  "timestamp": 1701419400000
}
```

### 5.7 根据商品名称搜索收藏
**URL**: `/api/user-favorites/search-by-product`  
**方法**: POST  
**描述**: 根据商品名称搜索收藏

**请求参数**:
```json
{
  "productName": "产品名称"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "productName": "产品名称",
      "sourcePage": "来源页面",
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 5.8 根据来源页面查询收藏
**URL**: `/api/user-favorites/list-by-source`  
**方法**: POST  
**描述**: 根据来源页面查询收藏

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "productName": "产品名称",
      "sourcePage": "来源页面",
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 5.9 根据时间范围查询收藏
**URL**: `/api/user-favorites/list-by-time`  
**方法**: POST  
**描述**: 根据时间范围查询收藏

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "productName": "产品名称",
      "sourcePage": "来源页面",
      "createTime": "2023-12-01T09:00:00",
      "updateTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 5.10 统计用户收藏数量
**URL**: `/api/user-favorites/count-by-user`  
**方法**: POST  
**描述**: 统计用户收藏总数

**请求参数**:
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": 25,
  "timestamp": 1701419400000
}
```

### 5.11 检查是否已收藏
**URL**: `/api/user-favorites/check-favorited`  
**方法**: POST  
**描述**: 检查商品是否已被用户收藏

**请求参数**:
```json
{
  "userCode": "USER_CODE_123",
  "productName": "产品名称"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": true,
  "timestamp": 1701419400000
}
```

---

## 6. 用户行为追踪 API

### 6.1 记录手动埋点
**URL**: `/api/user-track/record`  
**方法**: POST  
**描述**: 前端主动调用埋点接口

**请求参数** (UserTrackCreateDTO):
```json
{
  "userCode": "USER_CODE_123",
  "eventName": "page_view",
  "trackData": "附加数据",
  "pagePath": "/home",
  "extraInfo": "额外信息"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点记录成功",
  "data": true,
  "timestamp": 1701419400000
}
```

### 6.2 记录会话时间埋点
**URL**: `/api/user-track/record-session`  
**方法**: POST  
**描述**: 记录会话时间埋点

**请求参数**:
```json
{
  "userCode": "USER_CODE_123",
  "eventName": "session_time",
  "sessionTime": 30000,
  "pagePath": "/home"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "会话埋点记录成功",
  "data": true,
  "timestamp": 1701419400000
}
```

### 6.3 根据用户查询埋点记录
**URL**: `/api/user-track/list-by-user`  
**方法**: POST  
**描述**: 根据用户标识查询埋点记录

**请求参数**:
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点查询成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "eventName": "page_view",
      "trackData": "附加数据",
      "pagePath": "/home",
      "requestIp": "192.168.1.1",
      "trackType": "MANUAL",
      "sessionTime": 30000,
      "extraInfo": "额外信息",
      "createTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 6.4 根据IP查询埋点记录
**URL**: `/api/user-track/list-by-ip`  
**方法**: POST  
**描述**: 根据IP查询埋点记录

**请求参数**:
```json
{
  "requestIp": "192.168.1.1"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点查询成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "eventName": "page_view",
      "trackData": "附加数据",
      "pagePath": "/home",
      "requestIp": "192.168.1.1",
      "trackType": "MANUAL",
      "sessionTime": 30000,
      "extraInfo": "额外信息",
      "createTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 6.5 分页查询埋点记录
**URL**: `/api/user-track/page`  
**方法**: POST  
**描述**: 分页查询埋点记录

**请求参数** (UserTrackQueryDTO):
```json
{
  "pageNum": 1,
  "pageSize": 10,
  "userCode": "USER_CODE_123",
  "eventName": "page_view"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点查询成功",
  "data": {
    "list": [
      {
        "id": 1,
        "userCode": "USER_CODE_123",
        "eventName": "page_view",
        "trackData": "附加数据",
        "pagePath": "/home",
        "requestIp": "192.168.1.1",
        "trackType": "MANUAL",
        "sessionTime": 30000,
        "extraInfo": "额外信息",
        "createTime": "2023-12-01T09:00:00"
      }
    ],
    "total": 150,
    "pageNum": 1,
    "pageSize": 10,
    "pages": 15,
    "navigatePages": 8,
    "navigatepageNums": [1, 2, 3, 4, 5, 6, 7, 8],
    "isFirstPage": true,
    "isLastPage": false,
    "hasPreviousPage": false,
    "hasNextPage": true,
    "prePage": 0,
    "nextPage": 2
  },
  "timestamp": 1701419400000
}
```

### 6.6 根据埋点类型查询
**URL**: `/api/user-track/list-by-type`  
**方法**: POST  
**描述**: 根据埋点类型查询记录

**请求参数**:
```json
{
  "trackType": "AUTO"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点查询成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "eventName": "page_view",
      "trackData": "附加数据",
      "pagePath": "/home",
      "requestIp": "192.168.1.1",
      "trackType": "AUTO",
      "sessionTime": 30000,
      "extraInfo": "额外信息",
      "createTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 6.7 根据时间范围查询
**URL**: `/api/user-track/list-by-time`  
**方法**: POST  
**描述**: 根据时间范围查询埋点记录

**请求参数**:
```json
{
  "startTime": "2023-01-01T00:00:00",
  "endTime": "2023-12-31T23:59:59"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点查询成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "eventName": "page_view",
      "trackData": "附加数据",
      "pagePath": "/home",
      "requestIp": "192.168.1.1",
      "trackType": "MANUAL",
      "sessionTime": 30000,
      "extraInfo": "额外信息",
      "createTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

### 6.8 统计用户埋点总数
**URL**: `/api/user-track/count-by-user`  
**方法**: POST  
**描述**: 统计用户埋点总数

**请求参数**:
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点统计成功",
  "data": 156,
  "timestamp": 1701419400000
}
```

### 6.9 统计IP埋点总数
**URL**: `/api/user-track/count-by-ip`  
**方法**: POST  
**描述**: 统计IP埋点总数

**请求参数**:
```json
{
  "requestIp": "192.168.1.1"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点统计成功",
  "data": 89,
  "timestamp": 1701419400000
}
```

### 6.10 获取客户端IP
**URL**: `/api/user-track/get-client-ip`  
**方法**: POST  
**描述**: 获取客户端IP地址

**响应参数**:
```json
{
  "code": 200,
  "message": "IP获取成功",
  "data": "192.168.1.1",
  "timestamp": 1701419400000
}
```

### 6.11 获取会话时间统计
**URL**: `/api/user-track/session-stats`  
**方法**: POST  
**描述**: 获取会话时间统计数据

**请求参数**:
```json
{
  "userCode": "USER_CODE_123"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "会话统计成功",
  "data": [
    {
      "sessionDate": "2023-12-01",
      "totalSessionTime": 120000,
      "sessionCount": 5,
      "averageSessionTime": 24000
    }
  ],
  "timestamp": 1701419400000
}
```

### 6.12 根据产品名称查询埋点
**URL**: `/api/user-track/list-by-product`  
**方法**: POST  
**描述**: 根据产品名称查询埋点记录

**请求参数**:
```json
{
  "productName": "产品名称"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "埋点查询成功",
  "data": [
    {
      "id": 1,
      "userCode": "USER_CODE_123",
      "eventName": "product_view",
      "trackData": "产品名称",
      "pagePath": "/product/1",
      "requestIp": "192.168.1.1",
      "trackType": "MANUAL",
      "sessionTime": 30000,
      "extraInfo": "查看产品详情",
      "createTime": "2023-12-01T09:00:00"
    }
  ],
  "timestamp": 1701419400000
}
```

---

## 7. 统计数据 API

### 7.1 获取统计数据
**URL**: `/api/statistics/get`  
**方法**: POST  
**描述**: 获取统计数据（支持条件筛选）

**请求参数** (GetStatisticsRequest):
```json
{
  "startTime": "2023-01-01T00:00:00",
  "endTime": "2023-12-31T23:59:59",
  "dealerId": 1
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "averageSessionTime": 1800.5,
    "totalSessionTime": 36000.0,
    "totalCustomers": 150,
    "averageImmersiveSessionTime": 900.2,
    "average3DModelSessionTime": 1200.8,
    "activeUsersCount": 25,
    "mostViewedProduct": "VR眼镜Pro",
    "mostFavoritedProduct": "智能手表",
    "averageViewTime": 600.3
  },
  "timestamp": 1701419400000
}
```

**返回数据说明**:
- `averageSessionTime`: 用户平均会话时长（秒）
- `totalSessionTime`: 会话总时长（秒）
- `totalCustomers`: 总客户数
- `averageImmersiveSessionTime`: 平均沉浸式会话时间（秒）
- `average3DModelSessionTime`: 平均3D模型会话时间（秒）
- `activeUsersCount`: 正在活动用户数
- `mostViewedProduct`: 最受关注产品
- `mostFavoritedProduct`: 最喜爱产品
- `averageViewTime`: 平均观看时长（秒）

### 7.2 获取全部统计数据
**URL**: `/api/statistics/get-all`  
**方法**: POST  
**描述**: 获取全部统计数据（无筛选条件）

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": {
    "averageSessionTime": 1800.5,
    "totalSessionTime": 36000.0,
    "totalCustomers": 150,
    "averageImmersiveSessionTime": 900.2,
    "average3DModelSessionTime": 1200.8,
    "activeUsersCount": 25,
    "mostViewedProduct": "VR眼镜Pro",
    "mostFavoritedProduct": "智能手表",
    "averageViewTime": 600.3
  },
  "timestamp": 1701419400000
}
```

---

## 8. 国际化测试 API

### 8.1 测试成功响应
**URL**: `/api/i18n/test-success`  
**方法**: POST  
**描述**: 测试默认成功响应

**响应参数**:
```json
{
  "code": 200,
  "message": "操作成功",
  "data": "Hello World",
  "timestamp": 1701419400000
}
```

### 8.2 测试带键的成功响应
**URL**: `/api/i18n/test-success-key`  
**方法**: POST  
**描述**: 测试使用消息键的成功响应

**响应参数**:
```json
{
  "code": 200,
  "message": "用户登录成功",
  "data": "User data",
  "timestamp": 1701419400000
}
```

### 8.3 测试带参数的成功响应
**URL**: `/api/i18n/test-success-params`  
**方法**: POST  
**描述**: 测试带参数的国际化消息

**请求参数**:
```json
{
  "username": "用户名"
}
```

**响应参数**:
```json
{
  "code": 200,
  "message": "用户登录成功",
  "data": "Login data for: 用户名",
  "timestamp": 1701419400000
}
```

### 8.4 测试错误响应
**URL**: `/api/i18n/test-error`  
**方法**: POST  
**描述**: 测试错误响应

**响应参数**:
```json
{
  "code": 500,
  "message": "用户不存在",
  "data": null,
  "timestamp": 1701419400000
}
```

### 8.5 测试参数错误
**URL**: `/api/i18n/test-bad-request`  
**方法**: POST  
**描述**: 测试参数错误响应

**响应参数**:
```json
{
  "code": 400,
  "message": "参数验证失败",
  "data": null,
  "timestamp": 1701419400000
}
```

### 8.6 测试未找到
**URL**: `/api/i18n/test-not-found`  
**方法**: POST  
**描述**: 测试未找到响应

**响应参数**:
```json
{
  "code": 404,
  "message": "产品不存在",
  "data": null,
  "timestamp": 1701419400000
}
```

### 8.7 测试未授权
**URL**: `/api/i18n/test-unauthorized`  
**方法**: POST  
**描述**: 测试未授权响应

**响应参数**:
```json
{
  "code": 401,
  "message": "未授权访问",
  "data": null,
  "timestamp": 1701419400000
}
```

### 8.8 测试禁止访问
**URL**: `/api/i18n/test-forbidden`  
**方法**: POST  
**描述**: 测试禁止访问响应

**响应参数**:
```json
{
  "code": 403,
  "message": "禁止访问",
  "data": null,
  "timestamp": 1701419400000
}
```

### 8.9 测试服务器内部错误
**URL**: `/api/i18n/test-internal-error`  
**方法**: POST  
**描述**: 测试服务器内部错误响应

**响应参数**:
```json
{
  "code": 500,
  "message": "服务器内部错误",
  "data": null,
  "timestamp": 1701419400000
}
```

---

## 状态码说明

| 状态码 | 说明 |
|--------|------|
| 200 | 操作成功 |
| 400 | 请求参数错误 |
| 401 | 未授权 |
| 403 | 禁止访问 |
| 404 | 资源未找到 |
| 500 | 服务器内部错误 |

---

## 响应参数说明

### 通用响应格式
所有接口的响应都遵循统一格式：
```json
{
  "code": 200,
  "message": "操作成功", 
  "data": {},
  "timestamp": 1701419400000
}
```

### 响应字段说明
- `code`: 响应状态码（200=成功，400=参数错误，401=未授权，403=禁止访问，404=未找到，500=服务器错误）
- `message`: 响应消息（支持国际化）
- `data`: 响应数据（根据接口不同返回不同类型的数据）
- `timestamp`: 响应时间戳

### 常见数据类型
- **分页数据**: 包含list、total、pageNum、pageSize字段
- **用户数据**: 包含id、username、email、userCode、dealerId、dealerName等字段
- **产品数据**: 包含id、name、description、productTypeId、productTypeName等字段
- **经销商数据**: 包含id、name、code、contact、phone、address等字段
- **收藏数据**: 包含id、userCode、productName、sourcePage等字段
- **埋点数据**: 包含id、userCode、eventName、trackData、pagePath等字段

---

## 注意事项

1. 所有接口均使用POST方法请求
2. 请求头需包含 `Content-Type: application/json`
3. 分页查询的页码从1开始
4. 时间格式统一使用ISO 8601格式：`yyyy-MM-ddTHH:mm:ss`
5. 支持国际化，通过Accept-Language请求头指定语言（zh/en）
6. 所有删除操作均为逻辑删除
7. 需要验证的接口使用@Valid注解进行参数校验
8. 所有接口返回的响应格式统一，包含code、message、data、timestamp字段
9. 用户标识（userCode）用于标识匿名用户，支持追踪用户行为
10. 支持按经销商、时间范围等维度进行数据筛选和统计
11. 响应中的时间字段均为ISO 8601格式
12. 状态字段：1=启用/正常，0=禁用/异常
13. 分页数据中total为符合条件的总记录数
14. 对于未提供具体响应示例的接口，请参考同类型接口的响应格式 
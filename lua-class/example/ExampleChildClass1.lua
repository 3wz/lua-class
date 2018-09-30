--2018年8月13日
--作者: 汪振

local ExampleBaseClass = require("_AppProduct.Scripts._LuaProduct.Examples.ExampleBaseClass")

local ExampleChildClass1 = class(ExampleBaseClass)
local base = ExampleBaseClass --定义父级变量

function ExampleChildClass1:ctor(...)
    print("ExampleChildClass1构造函数")
end

function ExampleChildClass1:Init(...)
    -- 调用父级方法的第一种方式
    -- self:super(ExampleChildClass1, "Init")

    -- 调用父级方法的第二种方式 目前推荐第二种方式
    base.Init(self)
    print("ExampleChildClass1 Init")
end

function ExampleChildClass1:Init2(...)
    -- 调用父级方法的第一种方式
    -- self:super(ExampleChildClass1, "Init2")
    
    -- 调用父级方法的第二种方式 目前推荐第二种方式
    base.Init2(self)
    print("ExampleChildClass1 Init2")
end

return ExampleChildClass1

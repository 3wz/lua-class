--2018年8月13日
--作者: 汪振

local ExampleChildClass1 = require("_AppProduct.Scripts._LuaProduct.Examples.ExampleChildClass1")

local ExampleChildClass2 = class(ExampleChildClass1)
local base = ExampleChildClass1 --定义父级变量

function ExampleChildClass2:ctor(...)
    print("ExampleChildClass2构造函数")
end

function ExampleChildClass2:Init(...)
    -- 调用父级方法的第一种方式
    -- self:super(ExampleChildClass2, "Init")

    -- 调用父级方法的第二种方式 目前推荐第二种方式
    base.Init(self)
    print("ExampleChildClass2 Init")
end

function ExampleChildClass2:Init2(...)
    -- 调用父级方法的第一种方式
    -- self:super(ExampleChildClass2, "Init2")

    -- 调用父级方法的第二种方式 目前推荐第二种方式
    base.Init2(self)
    print("ExampleChildClass2 Init2")
end

return ExampleChildClass2

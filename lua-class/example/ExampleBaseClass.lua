--2018年8月13日
--作者: 汪振

local ExampleBaseClass = class()

function ExampleBaseClass:ctor( ... )
    print("ExampleBaseClass构造函数")
    self:Init(...)
end

function ExampleBaseClass:Init( ... )
    print("ExampleBaseClass Init")
    self:Init2(...)
end

function ExampleBaseClass:Init2( ... )
    print("ExampleBaseClass Init2")
end

return ExampleBaseClass
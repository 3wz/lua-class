
local ExampleBaseClass = class()

function ExampleBaseClass:ctor( ... )
    print("ExampleBaseClass构造函数!!!")
    self:Init(...)
end

function ExampleBaseClass:Init( ... )
    print("ExampleBaseClass Init!!!")
end

return ExampleBaseClass
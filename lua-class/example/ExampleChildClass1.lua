
local ExampleBaseClass = require("ExampleBaseClass")

local ExampleChildClass1 = class(ExampleBaseClass)

function ExampleChildClass1:ctor(...)
    print("ExampleChildClass1构造函数!!!")
end

function ExampleChildClass1:Init(...)
    self:super("Init")
    print("ExampleChildClass1 Init!!!")
end

return ExampleChildClass1

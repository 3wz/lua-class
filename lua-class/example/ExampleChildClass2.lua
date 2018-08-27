
local ExampleChildClass1 = require("ExampleChildClass1")

local ExampleChildClass2 = class(ExampleChildClass1)

function ExampleChildClass2:ctor(...)
    print("ExampleChildClass2构造函数!!!")
end

function ExampleChildClass2:Init(...)
    self:super("Init")
    print("ExampleChildClass2 Init!!!")
end

return ExampleChildClass2
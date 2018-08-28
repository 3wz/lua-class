-- Internal register
local _class={}
 
function class(base)
    local class_type={}
 
    class_type.__type   = 'class'
    class_type.ctor     = false
    
    local vtbl = {}
    _class[class_type] = vtbl
    setmetatable(class_type, {__newindex = vtbl, __index = vtbl})
 
    if base then
        setmetatable(vtbl, {__index=
            function(t,k)
                local ret = _class[base][k]
                --缓存调用函数到当前类中, 如果子类中没有的父类函数, 缓存后会加快调用速度
                vtbl[k] = ret
                return ret
            end
        })
    end
    
    class_type.__base   = base
    class_type.new      = function(...)
        --create a object, dependent on .__createFunc
        local obj= {}
        obj.__base  = class_type
        obj.__type  = 'object'
        setmetatable(obj,{ __index = _class[class_type] })
        do
            local create
            create = function(c, ...)
                if c.__base then
                    create(c.__base, ...)
                end
                if c.ctor then
                    c.ctor(obj, ...)
                end
            end
 
            create(class_type,...)
        end
        return obj
    end
 
    class_type.super = function(self, f, ...)
        assert(self and self.__type == 'object', string.format("'self' must be a object when call super(self, '%s', ...)", tostring(f)))
 
        local originBase = self.__base
        local base  = originBase.__base
        --从_class类注册表中使用基类获取对应函数, 不触发__index方式, 在继承链中循环查找
        while base and rawget(_class[base], f) == nil do
            base = base.__base
        end
        
        --断言是否从继承链中找到包含 f 函数的基类
        assert(base, string.format("base class %s function cannot be found when call .super(self, '%s', ...)", tostring(f), tostring(f)))
        --找到base[f]方法后, 可能在经过一次调用后, 由于上面有缓存函数的逻辑, 对应找到的基类可能并不是实际的包含 f 函数的基类, 所以需要继续寻找真正包含f 函数的基类
        while base.__base and base[f] == base.__base[f] do 
            base = base.__base
        end
 
        --临时指定该父类为当前调用对象的基类, 避免调用函数内存在还继续调用父类的逻辑, 导致循环调用堆栈溢出
        self.__base = base
 
        --开始调用函数
        local result = base[f](self, ...)
 
        --临时指定基类为包含函数的基类, 调用完方法后再指定回原基类
        self.__base = originBase
 
        return result
    end
 
    return class_type
end

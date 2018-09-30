-- Internal register
local _class={}
 
function class(base)
    local class_type={}
 
    class_type.__type   = 'class'
    class_type.ctor     = false
    
    -- ****************************************************
    -- 提前定义虚表, 避免在ctor构造函数调用父级方法的时候出错
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
    -- ****************************************************
    
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

    class_type.super = function(self, t, f, ...)
        assert(self and self.__type == 'object', string.format("'self' must be a object when call super(self, '%s', ...)", tostring(f)))
 
        local base = t.__base
        assert(base, "尝试调用不存在的父类方法!!!!")
        local result = base[f](self, ...)
        return result
    end
 
    return class_type
end

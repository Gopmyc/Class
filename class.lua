local function includeHelper(tClass, tOther, tSeen)
    if tOther == nil then return tClass end
    if type(tOther) ~= 'table' then return tOther end
    if tSeen[tOther] then return tSeen[tOther] end
    
    tSeen[tOther] = tClass
    for k, v in pairs(tOther) do if not tSeen[k] then tClass[k] = includeHelper({}, v, tSeen) end end

    return tClass
end

local function debugInfo(tSelf)
    local tMt = type(tSelf) == "userdata" and getmetatable(tSelf) or tSelf
    assert(tMt, "Object has no metatable!")

    local tStr = {
        "==========================",
        "=== DEBUG OBJECT INFO ===",
        "==========================",
        "\nType: " .. (tMt.__type or "Unknown"),
        "\n# Private Data:",
    }

    table.insert(tStr, (tMt.__private and table.concat({table.unpack(tMt.__private, function(k, v) return string.format("  - %s = %s", k, tostring(v)) end)}, "\n") or "  (empty)"))
    table.insert(tStr, "\n# Methods:")
    table.insert(tStr, table.concat((function() local methods = {} for k, v in pairs(tMt) do if type(v) == "function" then table.insert(methods, string.format("  - %s type : %s", k, type(v))) end end return methods end)(), "\n"))

    table.insert(tStr, "\n==========================")
    return table.concat(tStr, "\n")
end

local function include(tClass, tOther) return includeHelper(tClass, tOther, {}) end
local function clone(tOther) return setmetatable(include({}, tOther), assert(getmetatable(tOther), "Cannot clone an object without a metatable.")) end

local function new(class)
	class		=	class or {}
	local inc	=	class.__includes or {}
	if getmetatable(inc) then inc = {inc}; end

	for _, other in ipairs(inc) do if type(other) == "string" then other = _G[other]; end; include(class, other); end

	class.__index	=	class
	class.init		=	class.init    or class[1] or function() end
	class.include	=	class.include or include
	class.clone		=	class.clone   or clone

	return setmetatable(class, {__call = function(c, ...) local o = setmetatable({}, c) o:init(...) return o end})
end

local function overloadOperators(tClass)
    assert(type(tClass) == "table", "[CLASS] ...")
    tClass.__add = function(tA, tB)
        assert(tA.__type == tClass.__type, "[CLASS] Attempted to add incompatible types: " .. tA.__type .. " and " .. tB.__type)
        assert(tB.__type == tClass.__type, "[CLASS] Attempted to add incompatible types: " .. tA.__type .. " and " .. tB.__type)
    
        local tResult = {}
    
        for tKey, tValue in pairs(tA.__private) do tResult[tKey] = tValue end
        for tKey, tValue in pairs(tB.__private) do tResult[tKey] = tResult[tKey] or tValue end
    
        for tKey, tValue in pairs(tA.__privateMethods) do tResult[tKey] = tValue end
        for tKey, tValue in pairs(tB.__privateMethods) do tResult[tKey] = tResult[tKey] or tValue end
    
        return setmetatable(tResult, { __type = tA.__type, __privateMethods = tResult.__privateMethods or {} })
    end
end

local function registerClass(tName, tPrototype, tParent)
    local tCls  =   new{__includes = {tPrototype, tParent}}

    if tParent then tCls.__super = tParent end
    tCls.__type = tName
    overloadOperators(tCls)

    return tCls
end

if class_commons ~= false and not common then common = {}; function common.class(name, prototype, parent) return new{__includes = {prototype, parent}}; end; function common.instance(class, ...) return class(...); end end

return setmetatable(
	{
		new		=	new,
		include	=	include,
		clone	=	clone
	},
	{
		__call	=	function(_,...) return new(...) end
	}
)
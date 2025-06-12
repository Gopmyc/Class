local function includeHelper(tClass, tOther, tSeen)
    if tOther == nil then return tClass end
    if type(tOther) ~= 'table' then return tOther end
    if tSeen[tOther] then return tSeen[tOther] end
    
    tSeen[tOther] = tClass
    for k, v in pairs(tOther) do if not tSeen[k] then tClass[k] = includeHelper({}, v, tSeen) end end

    return tClass
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
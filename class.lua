return setmetatable(
{
	includeHelper		=	function(self, tClass, tOther, tSeen)
        if tOther == nil then           return tClass end
        if type(tOther) ~= 'table' then return tOther end
        if tSeen[tOther] then           return tSeen[tOther] end

        tSeen[tOther]	=	tClass
        for sKey, vValue in pairs(tOther) do if not tSeen[sKey] then tClass[sKey] = self:includeHelper({}, vValue, tSeen) end end

        return tClass
    end,

	debugInfo			=	function(self, tSelf)
        local tMt	= 	(type(tSelf) == "userdata") and getmetatable(tSelf) or tSelf
        local tStr	=	{
            "==========================",
            "=== DEBUG OBJECT INFO ===",
            "==========================",
            "\nType: " .. (tMt.__type or "Unknown"),
            "\n# Private Data:",
        }
		
        table.insert(tStr, (tMt.__private and table.concat({table.unpack(tMt.__private, function(k, v) return string.format("  - %s = %s", k, tostring(v)) end)}, "\n") or "  (empty)"))
        table.insert(tStr, "\n# Methods:")
        table.insert(tStr, table.concat((function() local methods = {} for sKey, vValue in pairs(tMt) do if type(vValue) == "function" then table.insert(methods, string.format("  - %s type : %s", sKey, type(vValue))) end end return methods end)(), "\n"))
        table.insert(tStr, "\n==========================")
		
        return table.concat(tStr, "\n")
    end,

	accessor			=	function(self, tSelf, tVarName, tName, tDefaultValue)
        tSelf["Get" .. tName]	=	function(tSelf) return tSelf.__private[tVarName] end
        tSelf["Set" .. tName]	=	function(tSelf, tV) tSelf.__private[tVarName] = tV ~= nil and tV or tDefaultValue end
    end,

	include				=	function(self, tClass, tOther) return self:includeHelper(tClass, tOther, {}) end,
	clone				=	function(self, tOther) return setmetatable(self:include({}, tOther), assert(getmetatable(tOther), "Cannot clone an object without a metatable.")) end,

	overloadOperators	=	function(self, tClass)
        assert(type(tClass) == "table", "[CLASS] ...")
        tClass.__add	=	function(tA, tB)
            assert(tA.__type == tClass.__type, "[CLASS] Attempted to add incompatible types: " .. tA.__type .. " and " .. tB.__type)
            assert(tB.__type == tClass.__type, "[CLASS] Attempted to add incompatible types: " .. tA.__type .. " and " .. tB.__type)
            local tResult	=	{}
            for tKey, tValue in pairs(tA.__private) do tResult[tKey] = tValue end
            for tKey, tValue in pairs(tB.__private) do tResult[tKey] = tResult[tKey] or tValue end
            for tKey, tValue in pairs(tA.__privateMethods) do tResult[tKey] = tValue end
            for tKey, tValue in pairs(tB.__privateMethods) do tResult[tKey] = tResult[tKey] or tValue end
            return setmetatable(tResult, { __type = tA.__type, __privateMethods = tResult.__privateMethods or {} })
        end
    end,

	new					=	function(self, tClass)
        tClass		=	tClass or {}
        local tInc	=	getmetatable(tClass.__includes) and {tClass.__includes} or tClass.__includes or {}

        for _, tOther in ipairs(tInc) do if type(tOther) == "string" then tOther = _G[tOther] end; self:include(tClass, tOther) end

        tClass.__index			=	tClass
        tClass.__type			=	tClass.__type or "Class"
        tClass.__privateMethods	=	tClass.__privateMethods or {}

        local tMethodsToHide	=	{
            init		=	tClass.init    or tClass[1] or function() end,
            include		=	tClass.include or function(...) return self:include(...) end,
            clone		=	tClass.clone   or function(...) return self:clone(...) end,
            DebugInfos	=	tClass.__privateMethods.DebugInfos or function(...) return self:debugInfo(...) end,
        }

        for sKey, vValue in pairs(tMethodsToHide) do if vValue then tClass.__privateMethods[sKey] = vValue tClass[sKey] = nil end end

        return setmetatable(tClass, {
            __call	=	function(tC, ...)
                local tO			=	setmetatable({}, tC)
                tO.__private		=	{}
                tO.__type			=	tC.__type
                tO.__privateMethods	=	tC.__privateMethods
                assert(xpcall(function(...) tO:init(...) end, function(tErr) return "Init Error: " .. tErr end, ...))
                return tO
            end,
            __gc	=	function(tO) if tO.destroy then pcall(function() tO:destroy() end) else tO = nil end end,
            __index	=	function(tSelf, tKey)
    			if tKey == "__privateMethods" then return nil end
    			if tSelf.__privateMethods[tKey] then
    			    return function(_, ...)
    			        return tSelf.__privateMethods[tKey](tSelf, ...)
    			    end
    			end
    			return rawget(tSelf, tKey)
			end,
        })
    end,

	registerClass		=	function(self, tName, tPrototype, tParent)
        local tCls	=	self:new{__includes = {tPrototype, tParent}}
        tCls.__type	=	tName
        self:overloadOperators(tCls)
        return tCls
    end,
},
{
    __call	=	function(self, ...)
        return self:new(...)
    end
})

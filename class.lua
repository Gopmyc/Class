return setmetatable(
{
	includeHelper	=	function(self, tClass, tOther, tSeen)
        if tOther == nil then           return tClass end
        if type(tOther) ~= 'table' then return tOther end
        if tSeen[tOther] then           return tSeen[tOther] end

        tSeen[tOther]	=	tClass
        for sKey, vValue in pairs(tOther) do if not tSeen[sKey] then tClass[sKey] = self:includeHelper({}, vValue, tSeen) end end

        return tClass
    end,

	debugInfo	=	function(self, tSelf)
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

	accessor	=	function(self, tSelf, tVarName, tName, tDefaultValue)
        tSelf["Get" .. tName]	=	function(tSelf) return tSelf.__private[tVarName] end
        tSelf["Set" .. tName]	=	function(tSelf, tV) tSelf.__private[tVarName] = tV ~= nil and tV or tDefaultValue end
    end,

	include		=	function(self, tClass, tOther) return self:includeHelper(tClass, tOther, {}) end,
	clone		=	function(self, tOther) return setmetatable(self:include({}, tOther), assert(getmetatable(tOther), "Cannot clone an object without a metatable.")) end,

	super		=	function(self, tSelf, tMethod, ...)
        if tSelf.__super and tSelf.__super[tMethod] then return tSelf.__super[tMethod](tSelf, ...) else error("Method " .. tMethod .. " not found in parent class.") end
    end,
},
{
    __call	=	function(self, ...)
        return -- TODO : IMPLEMENT CLASS CREATION LOGIC HERE
    end
})
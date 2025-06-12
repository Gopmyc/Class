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
},
{
    __call	=	function(self, ...)
        return -- TODO : IMPLEMENT CLASS CREATION LOGIC HERE
    end
})
local function include_helper(to, from, seen)
	if from == nil then
		return to
	elseif type(from) ~= 'table' then
		return from
	elseif seen[from] then
		return seen[from]
	end

	seen[from] = to
	for k,v in pairs(from) do
		k = include_helper({}, k, seen)
		if to[k] == nil then
			to[k] = include_helper({}, v, seen)
		end
	end
	return to
end

local function include(class, other)
	return include_helper(class, other, {})
end
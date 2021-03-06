--[[
	Adapted from PolyBool (github.com/voidqk/polybooljs) under the MIT license.
	(c) 2016 Sean Connelly (@voidqk)
	
	Original Lua port by EgoMoose.
	Refactor and optimisations by Elttob.
]]

--[[
	Provides helper functions for working with sorted arrays.
]]

local SortedArray = {}

function SortedArray.insertBefore(array, node, check)	
	local length = #array
	
	if length < 1 then
		array[1] = node
		return node
	end
	
	local lowerBound = 1
	local upperBound = length
	
	local upperBoundChecked = false

	while lowerBound ~= upperBound do
		local index = math.floor((lowerBound + upperBound) / 2)
		
		if check(array[index]) then
			upperBound = index
			upperBoundChecked = true
		else
			lowerBound = index + 1
			upperBoundChecked = false
		end
	end

	if upperBoundChecked or check(array[upperBound]) then
		table.insert(array, upperBound, node)
	else
		array[length + 1] = node
	end
	
	return node
end

function SortedArray.findTransition(array, check)
	local length = #array
	
	if length < 1 then
		return 1
	end
	
	local lowerBound = 1
	local upperBound = length
	
	local upperBoundChecked = false
	
	while lowerBound ~= upperBound do
		local index = math.floor((lowerBound + upperBound) / 2)
		
		if check(array[index]) then
			upperBound = index
			upperBoundChecked = true
		else
			lowerBound = index + 1
			upperBoundChecked = false
		end
	end
	
	if upperBoundChecked or check(array[upperBound]) then
		return upperBound
	else
		return length + 1
	end
end

return SortedArray
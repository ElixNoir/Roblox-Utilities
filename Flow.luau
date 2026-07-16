--!native
--!strict


-- -- State

local Module = {}

--[[
  Assert alternative which formats a string only if the condition is not met.
]]
function Module.assert(condition: any, format: string, ...): any
	if condition then
		return condition
	end
	error(format:format(...))
end


-- -- End

return Module

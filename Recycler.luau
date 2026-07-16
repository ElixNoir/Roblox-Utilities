--!native
--!strict


-- -- State

local Module = {}

local Caches: {[string]: {any}} = {}

function Module.fetch(key: string, callback: () -> any): any
	local cache = Caches[key]
	if #cache == 0 then
		return callback()
	end
	return table.remove(cache)
end

function Module.release(key: string, value: any)
	local cache = Caches[key]
	if not cache then
		cache = {}
		Caches[key] = cache
	end
	table.insert(cache, value)
end


-- -- End

return Module

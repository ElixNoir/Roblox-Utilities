--!native
--!strict


-- -- State

local Partitions: {{any}} = {}
local PartitionSize = 0x100

local Module = {
	PartitionSize = PartitionSize
}


-- -- Functions

--[[
	This will break if any positional axis is not between -(2^15 * PartitionSize - 1) and (2^15 * PartitionSize).
]]
local function quantize(position: CFrame | Vector3 | vector): number
	return ((position.X // PartitionSize) % 0x10000) * 0x100000000 + ((position.Y // PartitionSize) % 0x10000) * 0x10000 + (position.Z // PartitionSize) % 0x10000
end Module.quantize = quantize

function Module.get(position: CFrame | Vector3 | vector): {any}
	return Partitions[quantize(position)]
end

function Module.getValue(position: CFrame | Vector3 | vector, key: any): any
	local quantized = quantize(position)
	local partition = Partitions[quantized]
	return partition and partition[key] or nil
end

function Module.setValue(position: CFrame | Vector3 | vector, key: any, value: any)
	local quantized = quantize(position)
	local partition = Partitions[quantized] or {}
	Partitions[quantized] = partition
	partition[key] = value
end


-- -- End

return Module

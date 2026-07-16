--!native
--!strict


-- -- State

local Module = {}

function Module.faces(tail: Vector3, head: Vector3, minAngle: number, maxAngle: number): boolean
	local angle = math.deg(math.acos(math.clamp(tail.Unit:Dot(head.Unit), -1, 1)))
	return angle >= minAngle and angle <= maxAngle
end


-- -- End

return Module

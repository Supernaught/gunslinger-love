-- 
-- RotatableSystem
-- by Alphonsus
--

local lume = require "lib.lume"

local RotatableSystem = tiny.processingSystem(class "RotatableSystem")

function RotatableSystem:init()
	self.filter = tiny.requireAll("rotatable", "rot")
end

function RotatableSystem:process(e, dt)
	-- update rotatable velocity
	local rot = e.rotatable
	if(rot.acceleration ~= 0) then
		-- update velocity
		rot.velocity = rot.velocity + rot.acceleration * dt
		-- update max velocity
		if math.abs(rot.velocity) > rot.maxVelocity then
			rot.velocity = rot.maxVelocity * lume.sign(rot.velocity)
		end
	elseif(rot.velocity ~= 0 and rot.drag > 0) then
		-- update drag
		if rot.acceleration == 0 and rot.drag > 0 then
			local sign = lume.sign(rot.velocity)
			rot.velocity = rot.velocity - rot.drag * dt * sign
			if (rot.velocity < 0) ~= (sign < 0) then
				rot.velocity = 0
			end
		end
	end

	-- update rot
	if rot.velocity ~= 0 then
		e.rot = e.rot + rot.velocity * dt
	end
end

return RotatableSystem
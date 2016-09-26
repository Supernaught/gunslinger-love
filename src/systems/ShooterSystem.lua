local ShooterSystem = tiny.processingSystem(class "ShooterSystem")
local Bullet = require "src.entities.Bullet"
local timer = require "lib.hump.timer"

function ShooterSystem:init()
	self.filter = tiny.requireAll("shooter")
end

function ShooterSystem:process(e, dt)
	local s = e.shooter

	if s.shoot then
		s.shoot = false

		if s.canAtk then
			self:shoot(e, dt, s)
		end
	end

	-- timer.update(dt)
end

-- actually fire a bullet
function ShooterSystem:shoot(e, dt, s)
	world:addEntity(Bullet(e.pos.x, e.pos.y, e.angle))

	-- screen:setShake(2)
	-- screen:setRotation(0.05)

	s.canAtk = false
	timer.after(s.atkDelay, function() s.canAtk = true end)
end

return ShooterSystem
local ShooterSystem = tiny.processingSystem(class "ShooterSystem")
local Bullet = require "src.entities.Bullet"
local tick = require "lib.tick"

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

	tick.update(dt)
end

function ShooterSystem:shoot(e, dt, s)
	world:addEntity(Bullet(e.pos.x, e.pos.y, e.angle - math.rad(90)))

	s.canAtk = false
	tick.delay(function() s.canAtk = true end, s.atkDelay)
end

return ShooterSystem
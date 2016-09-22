local PlayerInputSystem = tiny.processingSystem(class "PlayerInputSystem")

function PlayerInputSystem:init()
	self.filter = tiny.requireAll("isPlayer", "shooter", "rotatable")
end

function PlayerInputSystem:process(e, dt)
	-- rotate left or right
	local rot = e.rotatable
	local keyLeft, keyRight = love.keyboard.isDown("left"), love.keyboard.isDown("right")

	local leftRightSign = keyLeft and -1 or keyRight and 1 or 0
	rot.velocity = rot.maxVelocity * leftRightSign

	-- fire

	-- press space
	-- local keyFire = love.keyboard.isDown("space")
	-- if keyFire and e.shooter.canAtk then
	-- 	e.shooter.shoot = true
	-- end

	e.shooter.shoot = keyLeft or keyRight

end

return PlayerInputSystem
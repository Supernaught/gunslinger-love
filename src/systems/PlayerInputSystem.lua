local PlayerInputSystem = tiny.processingSystem(class "PlayerInputSystem")

function PlayerInputSystem:init()
	self.filter = tiny.requireAll("isPlayer")
end

function PlayerInputSystem:process(e, dt)
	-- rotate left or right
	local rot = e.rotatable
	local keyLeft, keyRight = love.keyboard.isDown("left"), love.keyboard.isDown("right")
	local keyX = love.keyboard.isDown("x")

	local leftRightSign = keyLeft and -1 or keyRight and 1 or 0

	if keyLeft and keyRight then
		leftRightSign = 0
	elseif keyLeft then
		leftRightSign = -1
	elseif keyRight then
		leftRightSign = 1
	end

	rot.velocity = rot.speed * leftRightSign

	-- press space
	-- local keyFire = love.keyboard.isDown("space")
	-- if keyFire and e.shooter.canAtk then
	-- 	e.shooter.shoot = true
	-- end

	e.shooter.shoot = keyLeft or keyRight or keyX
end

return PlayerInputSystem
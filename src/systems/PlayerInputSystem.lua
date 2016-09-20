local PlayerInputSystem = tiny.processingSystem(class "PlayerInputSystem")

function PlayerInputSystem:init()
	self.filter = tiny.requireAll("isPlayer")
end

function PlayerInputSystem:process(e, dt)
	local rot = e.rotatable
	local keyLeft, keyRight = love.keyboard.isDown("left"), love.keyboard.isDown("right")

	local leftRightSign = keyLeft and -1 or keyRight and 1 or 0
	rot.velocity = rot.maxVelocity * leftRightSign
end

return PlayerInputSystem
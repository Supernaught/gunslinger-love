local Player = Object:extend()
local assets =  require "src.assets"

function Player:new()
	self.isPlayer = true

	-- transform
	self.pos = { x = love.graphics.getWidth() / 2 / 2, y = love.graphics.getHeight() / 2 / 2 }
	self.scale = {}
	self.angle = 0 -- in radians

	-- sprite component
	self.sprite = assets.player
	self.offset = { x = self.sprite:getWidth() / 2, y = self.sprite:getHeight() / 2 }

	-- rotatable component
	self.rotatable = {
		velocity = 0,
		acceleration = 0,
		drag = 30,
		maxVelocity = 12 -- rotate speed
	}

	-- shooter component
	self.shooter = {
		atkDelay = 0.04,
		canAtk = true,
		shoot = false -- if shoot input is pressed
	}

	return self
end

function Player:update(dt)
end

return Player